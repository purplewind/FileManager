program FileManager;

uses
  Vcl.Forms,
  Windows,
  Messages,
  Dialogs,
  SysUtils,
  UMainForm in 'UMainForm.pas' {frmMain},
  UFrameMyComputer in 'UnitMyComputer\UFrameMyComputer.pas' {FrameMyComputer: TFrame},
  UFrameExplorer in 'UnitMyComputer\UFrameExplorer.pas' {FrameExplorer: TFrame},
  UFileSearch in 'UnitMyComputer\UFileSearch.pas',
  UMyUtil in 'UnitUtil\UMyUtil.pas',
  UMyFaceThread in 'UnitUtil\UMyFaceThread.pas',
  UMyIcon in 'UnitUtil\UMyIcon.pas',
  Vcl.Themes,
  Vcl.Styles,
  UFormDestination in 'UnitMyComputer\UFormDestination.pas' {frmDestination},
  UFileThread in 'UnitUtil\UFileThread.pas',
  UThreadUtil in 'UnitUtil\UThreadUtil.pas',
  UFormZip in 'UnitMyComputer\UFormZip.pas' {frmZip},
  SevenZipVCL in 'UnitUtil\SevenZipVCL.pas',
  UFormUnzip in 'UnitMyComputer\UFormUnzip.pas' {frmUnzip},
  RAR in 'UnitUtil\RAR.pas',
  RAR_DLL in 'UnitUtil\RAR_DLL.pas',
  dirnotify in 'UnitUtil\dirnotify.pas',
  UFormHistoryManage in 'UnitMyComputer\UFormHistoryManage.pas' {frmHistoryManger},
  UMultiLanguage in 'UnitUtil\UMultiLanguage.pas',
  UFormAbout in 'UFormAbout.pas' {frmAbout},
  UMyUrl in 'UnitUtil\UMyUrl.pas',
  UFormConflict in 'UnitMyComputer\UFormConflict.pas' {frmConflict};

{$R *.res}

var
  myhandle : Integer;
begin
    // 报告内存泄漏
  ReportMemoryLeaksOnShutdown := DebugHook<>0;

    // 防止多个程序同时运行
  myhandle := findwindow( hfck_Name, nil );
  if myhandle > 0 then  // 窗口在同一个 用户 ID 已经运行, 恢复之前的窗口
  begin
    postmessage( myhandle,hfck_index,0,0 );
    Exit;
  end;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Iceberg Classico');
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmDestination, frmDestination);
  Application.CreateForm(TfrmZip, frmZip);
  Application.CreateForm(TfrmUnzip, frmUnzip);
  Application.CreateForm(TfrmHistoryManger, frmHistoryManger);
  Application.CreateForm(TfrmAbout, frmAbout);
  Application.CreateForm(TfrmConflict, frmConflict);
  frmMain.AppStart;
  Application.Run;
end.
