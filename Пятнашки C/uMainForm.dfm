object fMainForm: TfMainForm
  Left = 473
  Top = 153
  Caption = #1055#1103#1090#1085#1072#1096#1082#1080
  ClientHeight = 301
  ClientWidth = 301
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  OnActivate = FormActivate
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 0
    Top = 0
    Width = 301
    Height = 301
    Align = alClient
    AutoSize = True
    Center = True
    ExplicitWidth = 640
    ExplicitHeight = 856
  end
  object GridPanel1: TGridPanel
    Left = 0
    Top = 0
    Width = 301
    Height = 301
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    Align = alClient
    BevelOuter = bvNone
    ColumnCollection = <
      item
        Value = 8.000000000000002000
      end
      item
        Value = 84.000000000000000000
      end
      item
        Value = 8.000000000000000000
      end>
    ControlCollection = <
      item
        Column = 1
        Control = Panel1
        Row = 1
      end
      item
        Column = 1
        Control = lTime
        Row = 2
      end>
    RowCollection = <
      item
        Value = 9.000000000000000000
      end
      item
        Value = 84.000000000000000000
      end
      item
        Value = 6.999999999999998000
      end>
    TabOrder = 0
    object Panel1: TPanel
      Left = 24
      Top = 27
      Width = 252
      Height = 252
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alClient
      BevelOuter = bvNone
      BiDiMode = bdLeftToRight
      ParentBiDiMode = False
      TabOrder = 0
      object GridPanel2: TGridPanel
        Left = 0
        Top = 0
        Width = 252
        Height = 252
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alClient
        BevelOuter = bvNone
        ColumnCollection = <
          item
            Value = 50.000000000000000000
          end
          item
            Value = 50.000000000000000000
          end>
        ControlCollection = <>
        RowCollection = <
          item
            Value = 50.000000000000000000
          end
          item
            Value = 50.000000000000000000
          end>
        TabOrder = 0
      end
    end
    object lTime: TLabel
      Left = 24
      Top = 279
      Width = 252
      Height = 22
      Align = alClient
      Alignment = taCenter
      Caption = 'lTime'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
      ExplicitWidth = 46
    end
  end
  object MainMenu1: TMainMenu
    Left = 8
    Top = 8
    object Game: TMenuItem
      Caption = '&'#1048#1075#1088#1072
      object NewGame: TMenuItem
        Caption = '&'#1053#1086#1074#1072#1103' '#1080#1075#1088#1072
        ShortCut = 113
        OnClick = NewGameClick
      end
      object Line1: TMenuItem
        Caption = '-'
      end
      object Statistics: TMenuItem
        Caption = #1057'&'#1090#1072#1090#1080#1089#1090#1080#1082#1072
        ShortCut = 115
        OnClick = StatisticsClick
      end
      object Parameters: TMenuItem
        Caption = #1055'&'#1072#1088#1072#1084#1077#1090#1088#1099
        ShortCut = 116
        OnClick = ParametersClick
      end
      object Decor: TMenuItem
        Caption = '&'#1048#1079#1084#1077#1085#1080#1090#1100' '#1086#1092#1086#1088#1084#1083#1077#1085#1080#1077
        ShortCut = 118
        OnClick = DecorClick
      end
      object Line2: TMenuItem
        Caption = '-'
      end
      object MainExit: TMenuItem
        Caption = '&'#1042#1099#1093#1086#1076
        OnClick = MainExitClick
      end
    end
    object Help: TMenuItem
      Caption = '&'#1057#1087#1088#1072#1074#1082#1072
      object ViewHelp: TMenuItem
        Caption = #1055#1088#1086#1089'&'#1084#1086#1090#1088#1077#1090#1100' '#1089#1087#1088#1072#1074#1082#1091
        ShortCut = 112
        OnClick = ViewHelpClick
      end
      object Line3: TMenuItem
        Caption = '-'
      end
      object About: TMenuItem
        Caption = '&'#1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
        OnClick = AboutClick
      end
      object Line4: TMenuItem
        Caption = '-'
      end
      object OtherGames: TMenuItem
        Caption = #1044#1088#1091'&'#1075#1080#1077' '#1080#1075#1088#1099
        OnClick = OtherGamesClick
      end
    end
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 48
    Top = 8
  end
end
