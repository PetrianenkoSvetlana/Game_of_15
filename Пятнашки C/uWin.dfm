object fWin: TfWin
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1048#1075#1088#1072' '#1074#1099#1080#1075#1088#1072#1085#1072
  ClientHeight = 232
  ClientWidth = 312
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 299
    Height = 13
    Alignment = taCenter
    AutoSize = False
    Caption = #1055#1086#1079#1076#1088#1072#1074#1083#1103#1077#1084', '#1074#1099' '#1074#1099#1080#1075#1088#1072#1083#1080'!'
    Layout = tlBottom
  end
  object Label2: TLabel
    Left = 8
    Top = 30
    Width = 299
    Height = 30
    Alignment = taCenter
    AutoSize = False
    Caption = #1042#1099' '#1087#1086#1082#1072#1079#1072#1083#1080' '#1089#1072#1084#1086#1077' '#1083#1091#1095#1096#1077#1077' '#1074#1088#1077#1084#1103' '#1076#1083#1103' '#1101#1090#1086#1075#1086' '#1091#1088#1086#1074#1085#1103' '#1089#1083#1086#1078#1085#1086#1089#1090#1080'!'
    Layout = tlBottom
    Visible = False
    WordWrap = True
  end
  object lTime: TLabel
    Left = 12
    Top = 72
    Width = 37
    Height = 13
    Caption = #1042#1088#1077#1084#1103': '
    Layout = tlBottom
  end
  object lDate: TLabel
    Left = 176
    Top = 72
    Width = 33
    Height = 13
    Caption = #1044#1072#1090#1072': '
    Layout = tlBottom
  end
  object lBestTime: TLabel
    Left = 12
    Top = 98
    Width = 79
    Height = 13
    Caption = #1051#1091#1095#1096#1077#1077' '#1074#1088#1077#1084#1103': '
    Layout = tlBottom
  end
  object lScoreGame: TLabel
    Left = 12
    Top = 118
    Width = 86
    Height = 13
    Caption = #1055#1088#1086#1074#1077#1076#1077#1085#1085#1086' '#1080#1075#1088':'
    Layout = tlBottom
  end
  object lWin: TLabel
    Left = 12
    Top = 138
    Width = 62
    Height = 13
    Caption = #1042#1099#1080#1075#1088#1072#1085#1085#1086': '
    Layout = tlBottom
  end
  object lProcent: TLabel
    Left = 176
    Top = 138
    Width = 50
    Height = 13
    Caption = #1055#1088#1086#1094#1077#1085#1090': '
    Layout = tlBottom
  end
  object Label3: TLabel
    Left = 80
    Top = 168
    Width = 131
    Height = 13
    Cursor = crHandPoint
    Hint = 'https://github.com/PetrianenkoSvetlana'
    Caption = #1044#1088#1091#1075#1080#1077' '#1080#1075#1088#1099' '#1074' '#1080#1085#1090#1077#1088#1085#1077#1090#1077
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clHotLight
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsUnderline]
    ParentFont = False
    OnClick = Label3Click
  end
  object bExit: TButton
    Left = 12
    Top = 199
    Width = 121
    Height = 25
    Caption = #1042#1099#1093#1086#1076
    TabOrder = 1
    OnClick = bExitClick
  end
  object bNewGame: TButton
    Left = 170
    Top = 199
    Width = 131
    Height = 25
    Caption = #1053#1086#1074#1072#1103' '#1080#1075#1088#1072
    TabOrder = 0
    OnClick = bNewGameClick
  end
end
