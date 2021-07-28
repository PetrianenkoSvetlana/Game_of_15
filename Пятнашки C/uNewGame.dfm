object Form2: TForm2
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Form2'
  ClientHeight = 212
  ClientWidth = 384
  Color = clBtnHighlight
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object BitBtn1: TBitBtn
    Left = 72
    Top = 24
    Width = 75
    Height = 25
    Caption = 'BitBtn1'
    Style = bsWin31
    TabOrder = 0
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 72
    Top = 64
    Width = 75
    Height = 25
    Caption = 'BitBtn1'
    Style = bsNew
    TabOrder = 1
  end
  object BitBtn3: TBitBtn
    Left = 72
    Top = 104
    Width = 75
    Height = 25
    Caption = '&Yes'
    Default = True
    ModalResult = 6
    NumGlyphs = 2
    TabOrder = 2
  end
  object Button1: TButton
    Left = 216
    Top = 48
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 3
  end
end
