unit uWin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, SHELLAPI;

type
  TfWin = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    lTime: TLabel;
    lDate: TLabel;
    lBestTime: TLabel;
    lScoreGame: TLabel;
    lWin: TLabel;
    lProcent: TLabel;
    bExit: TButton;
    bNewGame: TButton;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure bNewGameClick(Sender: TObject);
    procedure bExitClick(Sender: TObject);
    procedure Label3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fWin: TfWin;

implementation
uses
  uIniFile, uMainForm;
{$R *.dfm}

procedure Sort(var mas: RComplexity);
var
  indexI, indexJ: Byte;
  temp: RTop;
begin
  for indexI := 0 to 4 do
    for indexJ := 4 downto indexI do
    if ((mas.top[indexJ].time < mas.top[indexJ - 1].time) or (mas.top[indexJ - 1].time = 0)) and (mas.top[indexJ].time <> 0) then
    begin {Обмен элементов}
      temp := mas.top[indexJ];
      mas.top[indexJ] := mas.top[indexJ - 1];
      mas.top[indexJ - 1] := temp;
    end;
end;

procedure TfWin.bExitClick(Sender: TObject);
begin
  Close;
  Application.Terminate;
end;

procedure TfWin.bNewGameClick(Sender: TObject);
begin
  Close;

end;

procedure TfWin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  sec := 0;
  fMainForm.New_Game;
  Action := caFree;
end;

procedure OutputAndCalculationOfStatistics(var complexity: RComplexity);
var
  indexI, indexJ: Byte;
  temp: RTop;
begin
  inc(complexity.stat[1]);
  inc(complexity.count);
  Inc(complexity.total.win);
  complexity.total.lose := 0;
  if complexity.total.win > complexity.stat[2] then
    complexity.stat[2] := complexity.total.win;
  if complexity.top[0].time > sec then
  begin
    fWin.Label2.Visible := true;
    fWin.lBestTime.Caption := 'Лучшее время: ' + IntToStr(sec);
  end
  else
    fWin.lBestTime.Caption := 'Лучшее время: ' + IntToStr(complexity.top[0].time);
  fWin.lScoreGame.Caption := 'Проведенно игр: ' + IntToStr(complexity.stat[0]);
  fWin.lWin.Caption := 'Выигранно: ' + IntToStr(complexity.stat[1]);
  fWin.lProcent.Caption := 'Процент: ' + FloatToStrF(100 * complexity.stat[1] / complexity.stat[0], ffFixed, 100, 2) + '%';
  if (complexity.top[4].time > sec) or (complexity.top[4].time = 0) then
  begin
   complexity.top[4].time := sec;
   complexity.top[4].date := Date;
   for indexI := 0 to 4 do
    for indexJ := 4 downto indexI do
    if ((complexity.top[indexJ].time < complexity.top[indexJ - 1].time) or (complexity.top[indexJ - 1].time = 0)) and (complexity.top[indexJ].time <> 0) then
    begin {Обмен элементов}
      temp := complexity.top[indexJ];
      complexity.top[indexJ] := complexity.top[indexJ - 1];
      complexity.top[indexJ - 1] := temp;
    end;
  end;
end;

procedure TfWin.FormCreate(Sender: TObject);
begin

  lTime.Caption := 'Время: ' + IntToStr(sec);
  lDate.Caption := 'Дата: ' + DateToStr(Date);
  if beginnerParam then OutputAndCalculationOfStatistics(beginner)
  else if amateurParam then OutputAndCalculationOfStatistics(amateur)
  else if professionalParam then OutputAndCalculationOfStatistics(professional)
  else if otherParam then
  begin
    Label2.Visible := false;
    lTime.Visible := false;
    lDate.Visible := false;
    lBestTime.Visible := false;
    lScoreGame.Visible := false;
    lWin.Visible := false;
    lProcent.Visible := false;
    Label1.Top := 90;
  end;
end;

procedure TfWin.Label3Click(Sender: TObject);
begin
If (Sender is TLabel) then
  with (Sender as Tlabel) do
  ShellExecute(Application.Handle,PChar('open'),
  PChar(Hint),
  PChar(0),
  nil,
  SW_NORMAL);
end;

end.
