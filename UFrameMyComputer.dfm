object FrameMyComputer: TFrameMyComputer
  Left = 0
  Top = 0
  Width = 606
  Height = 429
  TabOrder = 0
  object plMain: TPanel
    Left = 0
    Top = 0
    Width = 606
    Height = 429
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitLeft = 88
    ExplicitTop = 136
    ExplicitWidth = 185
    ExplicitHeight = 41
    object Splitter1: TSplitter
      Left = 193
      Top = 0
      Width = 5
      Height = 429
      ExplicitLeft = 248
    end
    object plLeft: TPanel
      Left = 0
      Top = 0
      Width = 193
      Height = 429
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 0
      ExplicitHeight = 329
      object vstDriver: TVirtualStringTree
        Left = 0
        Top = 0
        Width = 193
        Height = 429
        Align = alClient
        DefaultNodeHeight = 38
        Header.AutoSizeIndex = 0
        Header.Font.Charset = DEFAULT_CHARSET
        Header.Font.Color = clWindowText
        Header.Font.Height = -11
        Header.Font.Name = 'Tahoma'
        Header.Font.Style = []
        Header.Options = [hoAutoResize, hoColumnResize, hoDrag, hoShowSortGlyphs]
        TabOrder = 0
        TreeOptions.PaintOptions = [toShowDropmark, toThemeAware, toUseBlendedImages]
        TreeOptions.SelectionOptions = [toFullRowSelect]
        OnGetText = vstDriverGetText
        OnGetImageIndex = vstDriverGetImageIndex
        OnMouseDown = vstDriverMouseDown
        ExplicitHeight = 342
        Columns = <
          item
            Position = 0
            Width = 189
            WideText = 'DriverPath'
          end>
      end
    end
    object plCenter: TPanel
      Left = 198
      Top = 0
      Width = 408
      Height = 429
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      ExplicitLeft = 199
      ExplicitWidth = 271
      ExplicitHeight = 329
      object PcMain: TRzPageControl
        Left = 0
        Top = 0
        Width = 408
        Height = 429
        Align = alClient
        BoldCurrentTab = True
        Images = il16
        ShowFocusRect = False
        ShowShadow = False
        TabOrder = 0
        TabStyle = tsRoundCorners
        TabWidth = 80
        ExplicitLeft = 1
        FixedDimension = 0
      end
    end
  end
  object il16: TImageList
    Left = 112
    Top = 104
    Bitmap = {
      494C010101000500040010001000FFFFFFFFFF00FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000018799C001879
      9C0018799C0018799C0018799C0018799C0018799C0018799C0018799C001879
      9C0018799C0018799C0018799C00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000188EB500188EB500188E
      B500188EB500188EB500188EB500188EB500188EB500188EB500188EB500188E
      B500188EB500188EB500188EB50018799C000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000319EBD0063CBFF00188EB5009CFF
      FF006BD7FF006BD7FF006BD7FF006BD7FF006BD7FF006BD7FF006BD7FF006BD7
      FF0039B2DE009CF3FF00188EB50018799C000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000319EBD0063CBFF00188EB5009CFF
      FF007BE3FF007BE3FF007BE3FF007BE3FF007BE3FF007BE3FF007BE3FF007BDF
      FF0042B2DE009CFFFF00188EB50018799C000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000319EBD0063CBFF00188EB5009CFF
      FF0084E7FF0084E7FF0084E7FF0084E7FF0084E7FF0084E7FF0084E7FF0084EB
      FF004AB6DE00A5F7FF00188EB50018799C000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000319EBD0063CBFF00188EB5009CFF
      FF0094FBFF0094FBFF0094FBFF0094FBFF0094FBFF0094FBFF0094FBFF008CF3
      FF0052BEE7009CFFFF00188EB50018799C000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000319EBD006BD7FF00188EB5009CFF
      FF009CFFFF009CFFFF009CFFFF00A5F7FF009CFFFF009CFFFF009CFFFF009CFF
      FF0063CBFF009CFFFF00188EB50018799C000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000319EBD007BDFFF00188EB5000000
      0000F7FBFF00F7FBFF00F7FBFF00F7FBFF00F7FBFF0000000000000000000000
      000084D7F700F7FBFF00188EB50018799C000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000319EBD0084EBFF0084E7FF00188E
      B500188EB500188EB500188EB500188EB500188EB500188EB500188EB500188E
      B500188EB500188EB500188EB500000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000319EBD009CF3FF008CF3FF008CF7
      FF008CF7FF008CF3FF008CF3FF00000000000000000000000000000000000000
      0000107DA5000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000319EBD00000000009CFFFF009CFF
      FF009CFFFF009CFFFF0000000000188EB500188EB500188EB500188EB500188E
      B500107DA5000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000319EBD00000000000000
      000000000000F7FBFF00319EBD00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000319EBD00319E
      BD00319EBD00319EBD0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFF000000000000C001000000000000
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000010700000000000000001000000000000
      01F70000000000004207000000000000B9FF000000000000C3FF000000000000
      FFFF000000000000FFFF000000000000}
  end
end
