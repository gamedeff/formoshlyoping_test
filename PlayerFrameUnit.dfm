object PlayerFrame: TPlayerFrame
  Left = 0
  Top = 0
  Width = 209
  Height = 215
  TabOrder = 0
  object Label2: TLabel
    Left = 6
    Top = 188
    Width = 48
    Height = 13
    Caption = #1052#1086#1085#1080#1090#1086#1088':'
  end
  object Label1: TLabel
    Left = 5
    Top = 155
    Width = 75
    Height = 13
    Caption = #1055#1088#1086#1079#1088#1072#1095#1085#1086#1089#1090#1100':'
  end
  object Label7: TLabel
    Left = 138
    Top = 155
    Width = 11
    Height = 13
    Caption = '%'
  end
  object MonitorComboBox: TComboBox
    Left = 60
    Top = 185
    Width = 141
    Height = 21
    TabOrder = 0
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 3
    Width = 155
    Height = 139
    Caption = #1054#1073#1083#1072#1089#1090#1100' '#1101#1082#1088#1072#1085#1072
    TabOrder = 1
    object Label3: TLabel
      Left = 13
      Top = 23
      Width = 10
      Height = 13
      Caption = 'X:'
    end
    object Label4: TLabel
      Left = 13
      Top = 51
      Width = 10
      Height = 13
      Caption = 'Y:'
    end
    object Label5: TLabel
      Left = 13
      Top = 79
      Width = 44
      Height = 13
      Caption = #1064#1080#1088#1080#1085#1072':'
    end
    object Label6: TLabel
      Left = 13
      Top = 107
      Width = 41
      Height = 13
      Caption = #1042#1099#1089#1086#1090#1072':'
    end
    object XSpinEdit: TSpinEdit
      Left = 71
      Top = 20
      Width = 75
      Height = 22
      MaxValue = 0
      MinValue = 0
      TabOrder = 0
      Value = 0
    end
    object YSpinEdit: TSpinEdit
      Left = 71
      Top = 48
      Width = 75
      Height = 22
      MaxValue = 0
      MinValue = 0
      TabOrder = 1
      Value = 0
    end
    object WSpinEdit: TSpinEdit
      Left = 71
      Top = 76
      Width = 75
      Height = 22
      MaxValue = 0
      MinValue = 0
      TabOrder = 2
      Value = 0
    end
    object HSpinEdit: TSpinEdit
      Left = 71
      Top = 104
      Width = 75
      Height = 22
      MaxValue = 0
      MinValue = 0
      TabOrder = 3
      Value = 0
    end
  end
  object AlphaSpinEdit: TSpinEdit
    Left = 86
    Top = 152
    Width = 45
    Height = 22
    MaxValue = 100
    MinValue = 0
    TabOrder = 2
    Value = 100
    OnChange = AlphaSpinEditChange
  end
end
