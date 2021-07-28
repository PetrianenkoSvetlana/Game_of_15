object fParameters: TfParameters
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099
  ClientHeight = 337
  ClientWidth = 394
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 378
    Height = 177
    Caption = #1059#1088#1086#1074#1077#1085#1100
    TabOrder = 0
    object lHeight: TLabel
      Left = 168
      Top = 51
      Width = 74
      Height = 13
      Caption = #1042#1099#1089#1086#1090#1072' (2-10):'
      Enabled = False
    end
    object lWidth: TLabel
      Left = 168
      Top = 78
      Width = 77
      Height = 13
      Caption = #1064#1080#1088#1080#1085#1072' (2-10):'
      Enabled = False
    end
    object rbBeginner: TRadioButton
      Left = 16
      Top = 33
      Width = 113
      Height = 25
      Caption = #1053#1086#1074#1080#1095#1086#1082
      Checked = True
      TabOrder = 0
      TabStop = True
      WordWrap = True
      OnClick = rbBeginnerClick
    end
    object rbAmateur: TRadioButton
      Left = 16
      Top = 80
      Width = 113
      Height = 25
      Caption = #1051#1102#1073#1080#1090#1077#1083#1100
      TabOrder = 1
      WordWrap = True
      OnClick = rbBeginnerClick
    end
    object rbProfessional: TRadioButton
      Left = 16
      Top = 127
      Width = 113
      Height = 25
      Caption = #1055#1088#1086#1092#1077#1089#1089#1080#1086#1085#1072#1083
      TabOrder = 2
      WordWrap = True
      OnClick = rbBeginnerClick
    end
    object rbOther: TRadioButton
      Left = 152
      Top = 28
      Width = 73
      Height = 17
      Caption = #1054#1089#1086#1073#1099#1081
      TabOrder = 3
      WordWrap = True
      OnClick = rbOtherClick
    end
    object eHeight: TEdit
      Left = 288
      Top = 48
      Width = 77
      Height = 21
      Enabled = False
      TabOrder = 4
      Text = '2'
      OnExit = eHeightExit
      OnKeyPress = eHeightKeyPress
    end
    object eWidth: TEdit
      Left = 288
      Top = 75
      Width = 77
      Height = 21
      Enabled = False
      TabOrder = 5
      Text = '2'
      OnExit = eHeightExit
      OnKeyPress = eHeightKeyPress
    end
  end
  object bOk: TButton
    Left = 149
    Top = 298
    Width = 109
    Height = 25
    Caption = 'OK'
    TabOrder = 1
    OnClick = bOkClick
  end
  object bCancel: TButton
    Left = 264
    Top = 298
    Width = 109
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 2
    OnClick = bCancelClick
  end
  object cbSound: TCheckBox
    Left = 8
    Top = 195
    Width = 153
    Height = 17
    Caption = #1047#1074#1091#1082#1086#1074#1086#1077' '#1089#1086#1087#1088#1086#1074#1086#1078#1076#1077#1085#1080#1077
    TabOrder = 3
  end
  object cbContinueGame: TCheckBox
    Left = 8
    Top = 218
    Width = 225
    Height = 17
    Caption = #1042#1089#1077#1075#1076#1072' '#1087#1088#1086#1076#1086#1083#1078#1072#1090#1100' '#1089#1086#1093#1088#1072#1085#1077#1085#1091#1102' '#1080#1075#1088#1091
    TabOrder = 4
  end
  object cbSaveGame: TCheckBox
    Left = 8
    Top = 241
    Width = 209
    Height = 17
    Caption = #1042#1089#1077#1075#1076#1072' '#1089#1086#1093#1088#1072#1085#1103#1090#1100' '#1080#1075#1088#1091' '#1087#1088#1080' '#1074#1099#1093#1086#1076#1077
    TabOrder = 5
  end
end
