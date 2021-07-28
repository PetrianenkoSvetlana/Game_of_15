unit uStatistic;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Math, uIniFile;

type
  TfStatistics = class(TForm)
    ListBox1: TListBox;
    GroupBox1: TGroupBox;
    lTime1: TLabel;
    lDateTime1: TLabel;
    lTime2: TLabel;
    lDateTime2: TLabel;
    lTime3: TLabel;
    lDateTime3: TLabel;
    lTime4: TLabel;
    lDateTime4: TLabel;
    lTime5: TLabel;
    lDateTime5: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    bClose: TButton;
    Reset: TButton;
    procedure bCloseClick(Sender: TObject);
    procedure Statistic;
    procedure FormCreate(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ResetClick(Sender: TObject);
    procedure ItemIndexes(complexity: RComplexity);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fStatistics: TfStatistics;

implementation

uses
  uMainForm;
{$R *.dfm}

procedure TfStatistics.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure ResetEnable;
begin
  if (beginner.stat[0] = 0) and (amateur.stat[0] = 0) and (professional.stat[0] = 0) then
    fStatistics.Reset.Enabled := false
    else
      fStatistics.Reset.Enabled := true;
end;

procedure TfStatistics.FormCreate(Sender: TObject);
begin
  if beginnerParam then
    ListBox1.ItemIndex := 0
  else if amateurParam then
    ListBox1.ItemIndex := 1
  else if professionalParam then
    ListBox1.ItemIndex := 2;
  ResetEnable;
  Statistic;
end;

procedure TfStatistics.ListBox1Click(Sender: TObject);
begin
  Statistic;
end;

procedure TfStatistics.ResetClick(Sender: TObject);
var
  I, buttonSelected: Integer;
begin
  with TTaskDialog.Create(Self) do
  try
    Caption := 'Сброс статистики';
    Title := 'Обнулить всю статистику?';
    //Text := 'Do you want to continue even though [...]?';
    CommonButtons := [tcbYes, tcbNo];
    DefaultButton := tcbYes;
    MainIcon := tdiNone;
    if Execute then
      if ModalResult = mrYes then
      begin
        for I := 0 to Length(beginner.stat) - 1 do
        begin
          beginner.stat[I] := 0;
          amateur.stat[I] := 0;
          professional.stat[I] := 0;
        end;
        ResetEnable;
        Statistic;
      end;
  finally
    Free;
  end;

end;

procedure TfStatistics.ItemIndexes(complexity: RComplexity);
var
  index: byte;
begin
  Label1.Caption := 'Проведено игр: ' + IntToStr(complexity.stat[0]);
  Label2.Caption := 'Выиграно: ' + IntToStr(complexity.stat[1]);
  if complexity.stat[0] <> 0 then
    Label3.Caption := 'Процент проигрышей: ' + FloatToStrF(100 * complexity.stat[1] / complexity.stat[0], ffFixed, 100, 2) + '%'
  else
    Label3.Caption := 'Процент проигрышей: 0%';
  Label4.Caption := 'Выигрышей подряд: ' + IntToStr(complexity.stat[2]);
  Label5.Caption := 'Проигрышей подряд: ' + IntToStr(complexity.stat[3]);
  Label6.Caption := 'В текущем сеансе: ' + IntToStr(complexity.count);
  for index := 0 to 4 do
    begin
      if complexity.top[index].time <> 0 then
      begin
        (FindComponent('lTime'+ IntToStr(index + 1)) as TLabel).Visible := true;
        (FindComponent('lDateTime'+ IntToStr(index + 1)) as TLabel).Visible := true;
        (FindComponent('lTime'+ IntToStr(index + 1)) as TLabel).Caption := IntToStr(complexity.top[index].time);
        (FindComponent('lDateTime'+ IntToStr(index + 1)) as TLabel).Caption := DateToStr(complexity.top[index].date);
      end
      else
      begin
        (FindComponent('lTime'+ IntToStr(index + 1)) as TLabel).Visible := false;
        (FindComponent('lDateTime'+ IntToStr(index + 1)) as TLabel).Visible := false;
      end;
    end;
end;

procedure TfStatistics.Statistic;
begin
  case ListBox1.ItemIndex of
    0: ItemIndexes(beginner);
    1: ItemIndexes(amateur);
    2: ItemIndexes(professional);
  end;
end;

procedure TfStatistics.bCloseClick(Sender: TObject);
begin
  Close;
end;

end.
