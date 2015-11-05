object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = #1058#1077#1089#1090#1086#1074#1086#1077' '#1079#1072#1076#1072#1085#1080#1077
  ClientHeight = 550
  ClientWidth = 699
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 110
  TextHeight = 16
  object Label1: TLabel
    Left = 10
    Top = 14
    Width = 131
    Height = 16
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1086#1073#1083#1072#1089#1090#1077#1081':'
  end
  object OpenSpeedButton: TSpeedButton
    Left = 464
    Top = 353
    Width = 118
    Height = 31
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = '&'#1054#1090#1082#1088#1099#1090#1100'...'
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
      5555555555555555555555555555555555555555555555555555555555555555
      555555555555555555555555555555555555555FFFFFFFFFF555550000000000
      55555577777777775F55500B8B8B8B8B05555775F555555575F550F0B8B8B8B8
      B05557F75F555555575F50BF0B8B8B8B8B0557F575FFFFFFFF7F50FBF0000000
      000557F557777777777550BFBFBFBFB0555557F555555557F55550FBFBFBFBF0
      555557F555555FF7555550BFBFBF00055555575F555577755555550BFBF05555
      55555575FFF75555555555700007555555555557777555555555555555555555
      5555555555555555555555555555555555555555555555555555}
    NumGlyphs = 2
    OnClick = OpenSpeedButtonClick
  end
  object AddSpeedButton: TSpeedButton
    Left = 590
    Top = 353
    Width = 103
    Height = 31
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = '&'#1044#1086#1073#1072#1074#1080#1090#1100
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
    OnClick = AddSpeedButtonClick
  end
  object Label2: TLabel
    Left = 326
    Top = 12
    Width = 153
    Height = 16
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = #1057#1087#1080#1089#1086#1082' '#1074#1086#1089#1087#1088#1086#1080#1079#1074#1077#1076#1077#1085#1080#1103':'
  end
  object PlayerAreaFormsSpinEdit: TSpinEdit
    Left = 158
    Top = 10
    Width = 71
    Height = 26
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    MaxValue = 256
    MinValue = 1
    TabOrder = 0
    Value = 1
    OnChange = PlayerAreaFormsSpinEditEnter
    OnEnter = PlayerAreaFormsSpinEditEnter
  end
  object PageControl1: TPageControl
    Left = 10
    Top = 44
    Width = 290
    Height = 302
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    TabOrder = 1
  end
  object BottomPanel: TPanel
    Left = 0
    Top = 466
    Width = 699
    Height = 65
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Align = alBottom
    TabOrder = 2
    object PrevBtn: TButton
      Left = 135
      Top = 23
      Width = 62
      Height = 31
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = '9'
      Font.Charset = SYMBOL_CHARSET
      Font.Color = clBlue
      Font.Height = -18
      Font.Name = 'Webdings'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = PrevBtnClick
    end
    object NextBtn: TButton
      Left = 198
      Top = 23
      Width = 62
      Height = 31
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ':'
      Font.Charset = SYMBOL_CHARSET
      Font.Color = clBlue
      Font.Height = -18
      Font.Name = 'Webdings'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = NextBtnClick
    end
    object StopBtn: TButton
      Left = 71
      Top = 23
      Width = 62
      Height = 31
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = '<'
      Font.Charset = SYMBOL_CHARSET
      Font.Color = clBlue
      Font.Height = -18
      Font.Name = 'Webdings'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = StopBtnClick
    end
    object ClearBtn: TButton
      Left = 466
      Top = 23
      Width = 62
      Height = 31
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'r'
      Font.Charset = SYMBOL_CHARSET
      Font.Color = clRed
      Font.Height = -18
      Font.Name = 'Webdings'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      OnClick = ClearBtnClick
    end
    object PlayModeNormalBtn: TButton
      Left = 271
      Top = 23
      Width = 61
      Height = 31
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = '4'
      Font.Charset = SYMBOL_CHARSET
      Font.Color = clWindowText
      Font.Height = -18
      Font.Name = 'Webdings'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      OnClick = PlayModeNormalBtnClick
    end
    object PlayModeLoopBtn: TButton
      Left = 336
      Top = 23
      Width = 60
      Height = 31
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = '4q'
      Font.Charset = SYMBOL_CHARSET
      Font.Color = clWindowText
      Font.Height = -18
      Font.Name = 'Webdings'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      OnClick = PlayModeLoopBtnClick
    end
    object PlayModeRepeatBtn: TButton
      Left = 398
      Top = 23
      Width = 61
      Height = 31
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = '4'#183
      Font.Charset = SYMBOL_CHARSET
      Font.Color = clWindowText
      Font.Height = -18
      Font.Name = 'Webdings'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
      OnClick = PlayModeRepeatBtnClick
    end
    object PauseBtn: TButton
      Left = 10
      Top = 23
      Width = 61
      Height = 31
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = '4'
      Font.Charset = SYMBOL_CHARSET
      Font.Color = clBlue
      Font.Height = -18
      Font.Name = 'Webdings'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 7
      OnClick = PauseBtnClick
    end
  end
  object TrackBar: TTrackBar
    Left = 10
    Top = 407
    Width = 511
    Height = 53
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Max = 100
    PageSize = 10
    Frequency = 5
    TabOrder = 3
    OnChange = TrackBarChange
  end
  object PlayListBox: TListBox
    AlignWithMargins = True
    Left = 308
    Top = 44
    Width = 385
    Height = 302
    Margins.Left = 10
    Margins.Top = 10
    Margins.Right = 10
    Margins.Bottom = 10
    TabOrder = 4
    OnClick = PlayListBoxClick
  end
  object TimePanel: TPanel
    Left = 10
    Top = 391
    Width = 511
    Height = 21
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    BevelOuter = bvNone
    TabOrder = 5
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 531
    Width = 699
    Height = 19
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Panels = <>
    SimplePanel = True
  end
  object NewPlayListItemEdit: TEdit
    Left = 308
    Top = 357
    Width = 149
    Height = 24
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    TabOrder = 7
  end
  object OpenDialog1: TOpenDialog
    Left = 467
    Top = 321
  end
end
