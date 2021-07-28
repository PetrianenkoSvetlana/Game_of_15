unit uNewGame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ButtonGroup, Vcl.ExtCtrls, VCLTee.TeCanvas, Vcl.ToolWin, Vcl.ComCtrls;

type
  TForm2 = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    Button1: TButton;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


var
  Form2: TForm2;


implementation

{$R *.dfm}

var capt:string;
procedure KickBitBtn(frag:TBitBtn; clr:TColor; board:integer);overload;
var bmp:Tbitmap;
begin
  if (frag.Caption<>'') then capt:=frag.Caption;
  frag.Caption:='';
  if board>0 then board:=board+1 else board:=-1;
  with bmp do
    begin
      bmp:=TBitmap.Create;
      Height:=frag.Height-2*board;
      Width:=frag.Width-2*board;
      with Canvas do
      begin
        Brush.Color:=clr;
        FillRect(Rect(0, 0,Width-1, Height-1));
        TextOut((Width div 2)-(TextWidth(Capt)div 2 ),(Height div 2)-(TextHeight(Capt) div 2),Capt);
      end;
      frag.Glyph:=bmp;
    end;
end;

procedure TForm2.BitBtn1Click(Sender: TObject);
begin
  KickBitBtn(BitBtn1, clYellow, 2);
end;

end.
