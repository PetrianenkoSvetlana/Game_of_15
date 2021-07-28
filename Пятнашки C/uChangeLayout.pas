unit uChangeLayout;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.ImageList, Vcl.ImgList,
  Vcl.ComCtrls, Vcl.StdCtrls;

type
  TfChangeLayout = class(TForm)
    ListView1: TListView;
    ImageList1: TImageList;
    Label1: TLabel;
    bOk: TButton;
    bCancel: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure bOkClick(Sender: TObject);
    procedure bCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fChangeLayout: TfChangeLayout;

implementation
uses
  uIniFile, uMainForm;
{$R *.dfm}

procedure TfChangeLayout.bCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfChangeLayout.bOkClick(Sender: TObject);
begin
  imageFon := ListView1.Items[ListView1.Selected.Index].Caption;
  if imageFon = 'None' then
  fMainForm.Image1.Picture := nil
  else
    fMainForm.Image1.Picture.LoadFromFile('фон/' + imageFon + '.jpg');
  Close;
end;

procedure TfChangeLayout.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
