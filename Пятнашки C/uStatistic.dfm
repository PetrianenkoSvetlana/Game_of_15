object fStatistics: TfStatistics
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1057#1090#1072#1090#1080#1089#1090#1080#1082#1072' '#1080#1075#1088#1099' "'#1055#1103#1090#1085#1072#1096#1082#1080'"'
  ClientHeight = 212
  ClientWidth = 597
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
  object Label1: TLabel
    Left = 368
    Top = 8
    Width = 83
    Height = 13
    Caption = #1055#1088#1086#1074#1077#1076#1077#1085#1086' '#1080#1075#1088': '
  end
  object Label2: TLabel
    Left = 368
    Top = 27
    Width = 56
    Height = 13
    Caption = #1042#1099#1080#1075#1088#1072#1085#1086': '
  end
  object Label3: TLabel
    Left = 368
    Top = 46
    Width = 116
    Height = 13
    Caption = #1055#1088#1086#1094#1077#1085#1090' '#1087#1088#1086#1080#1075#1088#1099#1096#1077#1081': '
  end
  object Label4: TLabel
    Left = 368
    Top = 65
    Width = 107
    Height = 13
    Caption = #1042#1099#1080#1075#1088#1099#1096#1077#1081' '#1087#1086#1076#1088#1103#1076': '
  end
  object Label5: TLabel
    Left = 368
    Top = 84
    Width = 112
    Height = 13
    Caption = #1055#1088#1086#1080#1075#1088#1099#1096#1077#1081' '#1087#1086#1076#1088#1103#1076': '
  end
  object Label6: TLabel
    Left = 368
    Top = 103
    Width = 98
    Height = 13
    Caption = #1042' '#1090#1077#1082#1091#1097#1077#1084' '#1089#1077#1072#1085#1089#1077': '
  end
  object ListBox1: TListBox
    Left = 8
    Top = 8
    Width = 130
    Height = 57
    ItemHeight = 13
    Items.Strings = (
      #1053#1086#1074#1080#1095#1086#1082
      #1051#1102#1073#1080#1090#1077#1083#1100
      #1055#1088#1086#1092#1077#1089#1089#1080#1086#1085#1072#1083)
    TabOrder = 0
    OnClick = ListBox1Click
  end
  object GroupBox1: TGroupBox
    Left = 152
    Top = 8
    Width = 201
    Height = 113
    Caption = #1051#1091#1095#1096#1080#1077' '#1088#1077#1079#1091#1083#1100#1090#1072#1090#1099
    TabOrder = 1
    object lTime1: TLabel
      Left = 16
      Top = 16
      Width = 30
      Height = 13
      Caption = 'lTime1'
      Visible = False
    end
    object lDateTime1: TLabel
      Left = 104
      Top = 16
      Width = 53
      Height = 13
      Caption = 'lDateTime1'
      Visible = False
    end
    object lTime2: TLabel
      Left = 16
      Top = 35
      Width = 30
      Height = 13
      Caption = 'lTime2'
      Visible = False
    end
    object lDateTime2: TLabel
      Left = 104
      Top = 35
      Width = 53
      Height = 13
      Caption = 'lDateTime2'
      Visible = False
    end
    object lTime3: TLabel
      Left = 16
      Top = 54
      Width = 30
      Height = 13
      Caption = 'lTime3'
      Visible = False
    end
    object lDateTime3: TLabel
      Left = 104
      Top = 54
      Width = 53
      Height = 13
      Caption = 'lDateTime3'
      Visible = False
    end
    object lTime4: TLabel
      Left = 16
      Top = 73
      Width = 30
      Height = 13
      Caption = 'lTime4'
      Visible = False
    end
    object lDateTime4: TLabel
      Left = 104
      Top = 73
      Width = 53
      Height = 13
      Caption = 'lDateTime4'
      Visible = False
    end
    object lTime5: TLabel
      Left = 16
      Top = 92
      Width = 30
      Height = 13
      Caption = 'lTime5'
      Visible = False
    end
    object lDateTime5: TLabel
      Left = 104
      Top = 92
      Width = 53
      Height = 13
      Caption = 'lDateTime5'
      Visible = False
    end
  end
  object bClose: TButton
    Left = 280
    Top = 169
    Width = 141
    Height = 25
    Caption = #1047#1072#1082#1088#1099#1090#1100
    TabOrder = 2
    OnClick = bCloseClick
  end
  object Reset: TButton
    Left = 427
    Top = 169
    Width = 141
    Height = 25
    Caption = #1057#1073#1088#1086#1089#1080#1090#1100
    TabOrder = 3
    OnClick = ResetClick
  end
end
