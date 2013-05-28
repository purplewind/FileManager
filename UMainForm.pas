unit UMainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VirtualTrees, Vcl.ExtCtrls,
  Vcl.ComCtrls, RzListVw, RzTabs, ShellApi, Vcl.ToolWin, RzButton, RzPanel,
  Vcl.ImgList, UFrameMyComputer, Vcl.Buttons,  Vcl.StdCtrls,
  Vcl.Menus, auHTTP, auAutoUpgrader, idhttp, Vcl.Imaging.pngimage;

const
  hfck_Index = wm_user + $1000;
  hfck_Name = 'FileManager';

type

  TfrmMain = class(TForm)
    plMainForm: TPanel;
    ilFile16: TImageList;
    ilFile32: TImageList;
    tiApp: TTrayIcon;
    pmTrayIcon: TPopupMenu;
    miExit: TMenuItem;
    miAbout: TMenuItem;
    ilMainForm: TImageList;
    miUpgrade: TMenuItem;
    N2: TMenuItem;
    auMain: TauAutoUpgrader;
    tmrSave: TTimer;
    FrameMyComputer: TFrameMyComputer;
    plAppPicture: TPanel;
    ilNote: TImage;
    ilBack: TImage;
    ilExcel: TImage;
    ilWord: TImage;
    N1: TMenuItem;
    miCloseHide: TMenuItem;
    miCloseExit: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure sbCloseClick(Sender: TObject);
    procedure tiAppClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure miExitClick(Sender: TObject);
    procedure miUpgradeClick(Sender: TObject);
    procedure tmrSaveTimer(Sender: TObject);
    procedure miAboutClick(Sender: TObject);
    procedure miCloseHideClick(Sender: TObject);
    procedure miCloseExitClick(Sender: TObject);
  private
    procedure WMDeviceChange(var Msg: TMessage); message WM_DEVICECHANGE;
    procedure DropFiles(var Msg: TMessage); message WM_DROPFILES;
    procedure WMQueryEndSession(var Message: TMessage);message WM_QUERYENDSESSION;
    procedure createparams(var params: tcreateparams); override;
    procedure restorerequest(var Msg: TMessage); message hfck_Index;
  private
    IsAppExit, IsHideApp : Boolean;
    procedure ShowMainForm;
    procedure HideMainForm;
  private
    procedure LoadIni;
    procedure SaveIni;
  private
    procedure MainFormIni;
    procedure MainFormUnini;
    procedure CreateAppDataDir;
    procedure SaveAppPicture;
  public
    procedure AppStart;
    procedure SaveAllIni;
  end;

    // 记录运行信息 并且 检测运行必须的文件
  TAppStartHandle = class
  public
    procedure Update;
  private
    procedure RunMark; // 记录运行信息
  private
    procedure RunFileCheck;  // 检测运行必须的文件
    function CheckFile( FilePath : string ): Boolean;
    function ReadFileUrl( FileName : string ): string;
    function Download( FileUrl, FilePath : string ): Boolean;
  end;

    // PcID
  MyComputerID = class
  public
    class function get : string;
  private
    class function getNewPcID : string;
    class function Read : string;
    class procedure Save( PcID : string );
  end;

    // 拖动文件
  TDropFilesHandle = class
  public
    Msg: TMessage;
    FileList : TStringList;
  public
    constructor Create( _Msg: TMessage );
    procedure Update;
    destructor Destroy; override;
  private
    procedure FileDropOpen;
    procedure FileDropCopy( FolderPath : string );
  end;

    // 强行关闭程序
  TStopAppThread = class( TThread )
  public
    constructor Create;
    destructor Destroy; override;
  protected
    procedure Execute; override;
  end;


const
  Ini_MainForm = 'MainForm';
  Ini_MainFormHeigh = 'MainFormHeigh';
  Ini_MainFormWidth = 'MainFormWidth';
  Ini_MainFormHide = 'MainFormHide';
  Ini_MainFormPage = 'MainFormPage';

  Ini_App = 'App';
  Ini_AppPcID = 'AppPcID';

const
  MarkApp_PcID = 'PcID';
  MarkApp_Edition = 'Edition';

const
  Icon_AutoRunEnable = 3;
  Icon_AutoDisable = 4;

var
  frmMain: TfrmMain;

implementation

uses UMyIcon, UMyFaceThread, UFileThread, UMyUtil, IniFiles, UFormDestination, UMultiLanguage,
     UFormHistoryManage, UFormZip, UFormUnZip, UFrameExplorer, UFormAbout,
     UMyUrl, UFormFix, RAR, SevenZipVCL, UFormConflict;

{$R *.dfm}


{ TfrmMain }

procedure TfrmMain.AppStart;
var
  AppStartHandle : TAppStartHandle;
begin
  AppStartHandle := TAppStartHandle.Create;
  AppStartHandle.Update;
  AppStartHandle.Free;
end;

procedure TfrmMain.CreateAppDataDir;
begin
  ForceDirectories( MyAppData.getLoginPath );
  ForceDirectories( MyAppData.getIconFolderPath );
  ForceDirectories( MyAppData.getRunPath );
  ForceDirectories( MyAppData.getIconPicturePath );
end;

procedure TfrmMain.createparams(var params: tcreateparams);
begin
  try
    inherited createparams(params);
    params.WinClassName := hfck_Name;
  except
  end;
end;

procedure TfrmMain.DropFiles(var Msg: TMessage);
var
  DropFilesHandle : TDropFilesHandle;
begin
  try
    DropFilesHandle := TDropFilesHandle.Create( Msg );
    DropFilesHandle.Update;
    DropFilesHandle.Free;
  except
  end;
end;

procedure TfrmMain.miAboutClick(Sender: TObject);
begin
  frmAbout.Show;
end;

procedure TfrmMain.miCloseExitClick(Sender: TObject);
begin
  IsHideApp := False;
  miCloseHide.Checked := False;
  miCloseExit.Checked := True;
end;

procedure TfrmMain.miCloseHideClick(Sender: TObject);
begin
  IsHideApp := True;
  miCloseExit.Checked := False;
  miCloseHide.Checked := True;
end;

procedure TfrmMain.miExitClick(Sender: TObject);
begin
  IsAppExit := True;
  Close;
end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := IsAppExit or not IsHideApp;
  if not CanClose then
    HideMainForm;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  MainFormIni;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  MainFormUnini;
end;

procedure TfrmMain.HideMainForm;
begin
  ShowWindow(Self.Handle, SW_HIDE);
end;

procedure TfrmMain.LoadIni;
var
  IniFile : TIniFile;
  MainPage : Integer;
begin
  IniFile := TIniFile.Create( MyAppData.getConfigPath );
  try
    Self.Height := IniFile.ReadInteger( Ini_MainForm, Ini_MainFormHeigh, Self.Height );
    Self.Width := IniFile.ReadInteger( Ini_MainForm, Ini_MainFormWidth, Self.Width );

      // 是否隐藏窗口
    IsHideApp := IniFile.ReadBool( Ini_MainForm, Ini_MainFormHide, False );
    frmMain.miCloseHide.Checked := IsHideApp;
    frmMain.miCloseExit.Checked := not IsHideApp;
  except
  end;
  IniFile.Free;
end;

procedure TfrmMain.MainFormIni;
begin
    // 创建配置信息
  CreateAppDataDir;
  SaveAppPicture;

    // Dll 路径绑定
  DllPath_7Zip := MyAppData.get7ZipPath;
  DllPath_Rar := MyAppData.getRarPath;

    // 读取配置信息
  LoadIni;

    // 拖放文件消息
  DragAcceptFiles(Handle, True);

    // 多线程
  MyFaceJobHandler := TMyFaceJobHandler.Create;
  MyFileJobHandler := TMyFileJobHandler.Create;

    // 图标
  MyIcon := TMyIcon.Create;
  My16IconUtil.Set16IconName( ilFile16 );
  My32IconUtil.Set32IconName( ilFile32 );

    // Frame 初始化
  FrameMyComputer.IniFrame;

    // 程序结束标记
  IsAppExit := False;
end;

procedure TfrmMain.MainFormUnini;
var
  StopAppThread : TStopAppThread;
begin
  try
    StopAppThread := TStopAppThread.Create;
    StopAppThread.Resume;

    MyFileJobHandler.Stop;
    MyFaceJobHandler.Stop;

    FrameMyComputer.UniniFrame;
    MyIcon.Free;

    MyFileJobHandler.Free;
    MyFaceJobHandler.Free;

    SaveIni;

    StopAppThread.Free;
  except
  end;
end;

procedure TfrmMain.miUpgradeClick(Sender: TObject);
begin
  auMain.CheckUpdate;
end;

procedure TfrmMain.restorerequest(var Msg: TMessage);
begin
  try
    if not IsAppExit then
      ShowMainForm;
  except
  end;
end;

procedure TfrmMain.SaveAllIni;
begin
  SaveIni;
  FrameMyComputer.SaveIni;
  frmDestination.SaveIni;
end;

procedure TfrmMain.SaveAppPicture;
var
  FilePath : string;
begin
    // Note
  FilePath := MyAppData.getPreviewNote;
  if not FileExists( FilePath ) then
    ilNote.Picture.SaveToFile( FilePath );

    // Back
  FilePath := MyAppData.getPreviewBack;
  if not FileExists( FilePath ) then
    ilBack.Picture.SaveToFile( FilePath );

    // Word
  FilePath := MyAppData.getPreviewWord;
  if not FileExists( FilePath ) then
    ilWord.Picture.SaveToFile( FilePath );

    // Excel
  FilePath := MyAppData.getPreviewExcel;
  if not FileExists( FilePath ) then
    ilExcel.Picture.SaveToFile( FilePath );
end;

procedure TfrmMain.SaveIni;
var
  IniFile : TIniFile;
begin
  IniFile := TIniFile.Create( MyAppData.getConfigPath );
  try
    if Self.WindowState <> wsMaximized then
    begin
      IniFile.WriteInteger( Ini_MainForm, Ini_MainFormHeigh, Self.Height );
      IniFile.WriteInteger( Ini_MainForm, Ini_MainFormWidth, Self.Width );
      IniFile.WriteBool( Ini_MainForm, Ini_MainFormHide, IsHideApp );
    end;
  except
  end;
  IniFile.Free;
end;

procedure TfrmMain.sbCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmMain.ShowMainForm;
begin
  if not Self.Visible then
    Self.Visible := True;
  ShowWindow(Self.Handle, SW_RESTORE);
  SetForegroundWindow(Self.Handle);
end;

procedure TfrmMain.tiAppClick(Sender: TObject);
begin
  if not IsAppExit then
    ShowMainForm;
end;

procedure TfrmMain.tmrSaveTimer(Sender: TObject);
begin
  SaveAllIni;
end;

procedure TfrmMain.WMDeviceChange(var Msg: TMessage);
var
  IsDriverChanged : Boolean;
begin
  try
    IsDriverChanged := ( Msg.WParam = 32768 ) or ( Msg.WParam = 32772 );
    if IsDriverChanged then
    begin
      UserDriverApi.RefreshDriverList;
      UserFolderPageApi.RefreshPage;
    end;
  except
  end;
end;

procedure TfrmMain.WMQueryEndSession(var Message: TMessage);
begin
  try
    SaveAllIni;
    Message.Result := 1;
  except
  end;
end;

{ TDropFilesHandle }

constructor TDropFilesHandle.Create(_Msg: TMessage);
var
  FilesCount: Integer; // 文件总数
  i: Integer;
  FileName: array [0 .. 255] of Char;
  FilePath: string;
begin
  Msg := _Msg;
  FileList := TStringList.Create;

  // 获取文件总数
  FilesCount := DragQueryFile(Msg.WParam, $FFFFFFFF, nil, 0);
  try
    // 获取文件名
    for i := 0 to FilesCount - 1 do
    begin
      DragQueryFile(Msg.WParam, i, FileName, 256);
      FilePath := FileName;
      FileList.Add(FilePath);
    end;
  except
  end;
  DragFinish(Msg.WParam); // 释放
end;

destructor TDropFilesHandle.Destroy;
begin
  FileList.Free;
  inherited;
end;

procedure TDropFilesHandle.FileDropCopy( FolderPath : string );
begin
  UserCopyUtil.Copy( FileList, FolderPath );
end;

procedure TDropFilesHandle.FileDropOpen;
var
  i : Integer;
  SourcePath : string;
begin
  for i := 0 to FileList.Count - 1 do
  begin
    SourcePath := FileList[i];
    if DirectoryExists( SourcePath ) then
      UserFolderPageApi.AddPage( SourcePath );
  end;
end;

procedure TDropFilesHandle.Update;
var
  FolderPath : string;
begin
  FolderPath := FaceFolderPageApi.ReadActivatePath;
  if FolderPath = '' then
    FileDropOpen
  else
    FileDropCopy( FolderPath );
end;

{ MyComputerID }

class function MyComputerID.get: string;
begin
    // 读取 PcID
  Result := Read;

    // 读取 成功
  if Result <> '' then
    Exit;

    // 新建一个 PcID
  Result := getNewPcID;

    // 保存 PcID
  Save( Result );
end;

class function MyComputerID.getNewPcID: string;
var
  PcID, s : string;
  i : Integer;
  n : Integer;
  c : Char;
begin
  PcID := '';
  Randomize;
  for i := 1 to 8 do
  begin
    n := Random( 36 );
    if n < 10 then
      s := IntToStr( n )
    else
    begin
      n := n - 10 + 65;
      c := Char(n);
      s := c;
    end;
    PcID := PcID + s;
  end;
  Result := PcID;
end;

class function MyComputerID.Read: string;
var
  IniFile : TIniFile;
begin
  IniFile := TIniFile.Create( MyAppData.getConfigPath );
  try
    Result := IniFile.ReadString( Ini_App, Ini_AppPcID, '' );
  except
  end;
  IniFile.Free;
end;

class procedure MyComputerID.Save(PcID: string);
var
  IniFile : TIniFile;
begin
  IniFile := TIniFile.Create( MyAppData.getConfigPath );
  try
    IniFile.WriteString( Ini_App, Ini_AppPcID, PcID );
  except
  end;
  IniFile.Free;
end;

{ TAppLanguageEditionCheck }

function TAppStartHandle.CheckFile(FilePath: string): Boolean;
var
  FileUrl : string;
begin
  Result := True;
  if FileExists( FilePath ) and ( MyFileInfo.getFileSize( FilePath ) > 0 ) then // 文件存在，则跳过
    Exit;

    // 读取文件 Url
  Result := False;
  FileUrl := ReadFileUrl( ExtractFileName( FilePath ) );
  if FileUrl = '' then
    Exit;

    // 下载文件
  Result := Download( FileUrl, FilePath );
end;

function TAppStartHandle.Download(FileUrl, FilePath: string): Boolean;
var
  IsCompleted, IsDownloaded : Boolean;
begin
  IsDownloaded := False;

  IsCompleted := False;
  TThread.CreateAnonymousThread(
  procedure
  begin
    IsDownloaded := MyHttpUtl.Download( FileUrl, FilePath );
    IsCompleted := True;
  end).Start;
  while not IsCompleted do
  begin
    Application.ProcessMessages;
    Sleep( 100 );
  end;

  Result := IsDownloaded;
end;

function TAppStartHandle.ReadFileUrl(FileName: string): string;
begin
  Result := UrlUtil.ReadFileUrl( FileName );
end;

procedure TAppStartHandle.RunFileCheck;
begin
  try
    CheckFile( MyAppData.getRarPath );
    CheckFile( MyAppData.get7ZipPath );
  except
  end;
end;

procedure TAppStartHandle.RunMark;
var
  PcID, EditionStr : string;
  HttpMark : TIdHTTP;
  Params : TStringList;
begin
  PcID := MyComputerID.get;
  EditionStr := 'FileManager';
  Params := TStringList.Create;
  Params.Add( MarkApp_PcID + '=' + PcID );
  Params.Add( MarkApp_Edition + '=' + EditionStr );
  HttpMark := TIdHTTP.Create( nil );
  HttpMark.ConnectTimeout := 60000;
  HttpMark.ReadTimeout := 60000;
  try
    HttpMark.Post( Url_MarkApp, Params );
  except
  end;
  HttpMark.Free;
  Params.Free;
end;

procedure TAppStartHandle.Update;
begin
  TThread.CreateAnonymousThread(
  procedure
  begin
    try
      RunMark;  // 记录程序运行信息
      RunFileCheck;  // 检测运行时必须的文件
    except
    end;
  end).Start;
end;

{ TStopAppThread }

constructor TStopAppThread.Create;
begin
  inherited Create;
end;

destructor TStopAppThread.Destroy;
begin
  Terminate;
  Resume;
  WaitFor;

  inherited;
end;

procedure TStopAppThread.Execute;
var
  SleepCount : Integer;
begin
  SleepCount := 0;
  while not Terminated and ( SleepCount < 100 ) do
  begin
    Sleep( 100 );
    Inc( SleepCount );
  end;

    // 10 秒钟都没有结束程序，则强行结束
  if not Terminated then
  begin
    try
      ExitProcess(0);
      Application.Terminate;
    except
    end;
  end;

  inherited;
end;

end.
