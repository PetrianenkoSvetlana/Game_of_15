unit uMainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, NClass, Vcl.Menus, uIniFile, Math, GraphUtil,
  Vcl.Imaging.jpeg, Vcl.MPlayer, SHELLAPI;

type
  TfMainForm = class(TForm)
    MainMenu1: TMainMenu;
    Game: TMenuItem;
    NewGame: TMenuItem;
    Line1: TMenuItem;
    Help: TMenuItem;
    Statistics: TMenuItem;
    Parameters: TMenuItem;
    Decor: TMenuItem;
    Line2: TMenuItem;
    MainExit: TMenuItem;
    ViewHelp: TMenuItem;
    Line3: TMenuItem;
    About: TMenuItem;
    Line4: TMenuItem;
    OtherGames: TMenuItem;
    lTime: TLabel;
    Timer1: TTimer;
    GridPanel1: TGridPanel;
    Panel1: TPanel;
    GridPanel2: TGridPanel;
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
    procedure StatisticsClick(Sender: TObject);
    procedure ParametersClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure MainExitClick(Sender: TObject);
    procedure NewGameClick(Sender: TObject);
    procedure New_Game;
    procedure DecParam;
    procedure DecorClick(Sender: TObject);
    procedure ViewHelpClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormActivate(Sender: TObject);
    procedure OtherGamesClick(Sender: TObject);
    procedure AboutClick(Sender: TObject);
  private
    procedure WMSizing(var Message: TMessage); message WM_SIZING;

    { Private declarations }
  public
    { Public declarations }
  end;

var
  fMainForm: TfMainForm;
  FAspectRatio: Double;
  C:TNClass;
  sec: Cardinal;
  { ������ ���� }
  numberRow, numberColumn: integer;

  retry: Boolean = false;
  { ������ ��� ���������� ������� ������ }
  tempMasText: array of array of byte;
  //���������� ���������� �� �������� ������
  iniFile: TIniFile2;
implementation
uses
 uStatistic, uParameters, uNewGame, uWin, uChangeLayout, About;
{$R *.dfm}

procedure TfMainForm.DecParam;
begin
  if beginnerParam then
  begin
    dec(beginner.count);
    Inc(beginner.total.lose);
    beginner.total.win := 0;
    if beginner.total.lose > beginner.stat[3] then
      beginner.stat[3] := beginner.total.lose;
  end
  else if amateurParam then
  begin
    dec(amateur.count);
    Inc(amateur.total.lose);
    amateur.total.win := 0;
    if amateur.total.lose > amateur.stat[3] then
      amateur.stat[3] := amateur.total.lose;
  end
  else if professionalParam then
  begin
    dec(professional.count);
    Inc(professional.total.lose);
    professional.total.win := 0;
    if professional.total.lose > professional.stat[3] then
      professional.stat[3] := professional.total.lose;
  end;
  start := false;
end;

procedure LoadingArray(var complexity: RComplexity);
var
  indexRow, indexColumn: byte;
begin
  if (complexity.save) then
  begin
    retry := true;
    complexity.save := false;
    for indexRow := 0 to numberRow - 1 do
    for indexColumn := 0 to numberColumn - 1 do
      begin
        tempMasText[indexRow, indexColumn] := arraySave[indexRow, indexColumn];
        //Buttons[indexRow, indexColumn].Caption := IntToStr(tempMasText[indexRow, indexColumn]);
        //(fMainForm.GridPanel2.ControlCollection.ControlItems[indexColumn, indexRow].Control as TNClass).Caption := IntToStr(arraySave[indexRow, indexColumn]);
      end;

    //sec := complexity.time;
    fMainForm.New_Game;
    start := true;
    fMainForm.Timer1.Enabled := true;
    retry := false;
  end;

end;

procedure TfMainForm.NewGameClick(Sender: TObject);
begin
  if start then
  begin
    with TTaskDialog.Create(self) do
      try
        Caption := '����� ����';
        Title := '������� ���� �� ���������. ��� ����� �������?';
        CommonButtons := [];
        with TTaskDialogButtonItem(Buttons.Add) do
        begin
          Caption := '������� � ������ ����� ����';
          CommandLinkHint := '� ���������� ��� ����������� ��� ���������.';
          ModalResult := mrClose;
        end;
        with TTaskDialogButtonItem(Buttons.Add) do
        begin
          Caption := '������������� ��� ����';
          CommandLinkHint := '� ���������� ��� ����������� ��� ���������.';
          ModalResult := mrRetry;
        end;
        with TTaskDialogButtonItem(Buttons.Add) do
        begin
          Caption := '���������� ����';
          ModalResult := mrNone;
        end;
        Flags := [tfUseCommandLinks, tfAllowDialogCancellation];
        MainIcon := tdiNone;
        if Execute then
          if ModalResult = mrClose then
          begin
            DecParam;
            sec := 0;
            New_Game;

          end
          else if ModalResult = mrRetry then
          begin
            DecParam;
            sec := 0;
            retry := true;
            New_Game;
            retry := false;

          end
      finally
        Free;
      end;
  end
  else
  begin
    New_Game;
  end;
end;

procedure TfMainForm.New_Game;
var
  indexRow, indexColumn: integer;
begin

  { �������� ���������� ��� ������� }
  sec := 0;
  lTime.Caption := IntToStr(sec);
  if Timer1.Enabled then
    Timer1.Enabled := false;
  { ��������� ������ ������� ������� ���� }
  if beginnerParam then
  begin
    numberRow := 4;
    numberColumn := 4;
  end
  else if amateurParam then
  begin
    numberRow := 5;
    numberColumn := 5;
  end
  else if professionalParam then
  begin
    numberRow := 6;
    numberColumn := 6;
  end
  else if otherParam then
  begin
    numberRow := otherParamEditH;
    numberColumn := otherParamEditW;
  end;

  ClientWidth := numberColumn * 100 + 1;
  ClientHeight := numberRow * 100 + 1;

  Constraints.MinHeight := Height * 2 div 3;
  Constraints.MinWidth := Width * 2 div 3;
    { ����������� ��������� ������}
  FAspectRatio := Width / Height;

  GridPanel2.RowCollection.BeginUpdate;
  GridPanel2.ColumnCollection.BeginUpdate;

  if Buttons <> nil then
    for indexRow := 0 to Length(Buttons) - 1 do
      for indexColumn := 0 to Length(Buttons[0]) - 1 do
        Buttons[indexRow, indexColumn].Destroy;

  { ������� ����� �� ���������� �������� }
  GridPanel2.RowCollection.Clear;
  GridPanel2.ColumnCollection.Clear;
  { ������ ����� }
  for indexRow := 1 to numberRow do
    with GridPanel2.RowCollection.Add do
    begin
      SizeStyle := ssPercent; // ������������� �����
      Value := 100 / numberRow;  // ������� ��������
    end;
  for indexColumn := 1 to numberColumn do
    with GridPanel2.ColumnCollection.Add do
    begin
      SizeStyle := ssPercent;
      Value := 100 / numberColumn;
    end;
  { ������ ��������� ��� ������� ������}
  C.shuffle(numberRow, numberColumn);
  SetLength(tempMasText, numberRow, numberColumn);
  { ������ ������ }
  for indexRow := 0 to numberRow - 1 do
    for indexColumn := 0 to numberColumn - 1 do
   begin
     Buttons[indexRow, indexColumn]:=TNClass.Create(nil);
     with Buttons[indexRow, indexColumn] do
     begin
      Parent := GridPanel2;
      Align := alClient;
      Font.Size := 84 div 3;
      //Font.Size := Trunc(Buttons[indexRow, indexColumn].Height / 3);
      Font.Name := 'Times New Roman';
      if retry then
      begin
        Caption := IntToStr(tempMasText[indexRow, indexColumn]);
        if tempMasText[indexRow, indexColumn] = numberRow * numberColumn then
          Visible:=false;
      end
      else
      begin
        Caption:=IntToStr(masText[indexRow, indexColumn]);
        tempMasText[indexRow, indexColumn] := masText[indexRow, indexColumn];
        if masText[indexRow, indexColumn] = numberRow * numberColumn then
          Visible:=false;
      end;
      //ActiveControl := nil;

      OnClick:=ButtonClick;

     end;
   end;
  GridPanel2.RowCollection.EndUpdate;
  GridPanel2.ColumnCollection.EndUpdate;
end;

procedure TfMainForm.OtherGamesClick(Sender: TObject);
begin
  ShellExecute(Application.Handle,PChar('open'),
  PChar('https://github.com/PetrianenkoSvetlana'),
  PChar(0),
  nil,
  SW_NORMAL);

end;

procedure TfMainForm.WMSizing(var Message: TMessage);
var
  indexRow, indexColumn: integer;
begin
  case Message.wParam of
    WMSZ_LEFT, WMSZ_RIGHT, WMSZ_BOTTOMLEFT:
      with PRect(Message.LParam)^ do
        Bottom := Top + Round((Right-Left)/FAspectRatio);
    WMSZ_TOP, WMSZ_BOTTOM, WMSZ_TOPRIGHT, WMSZ_BOTTOMRIGHT:
      with PRect(Message.LParam)^ do
        Right := Left + Round((Bottom-Top)*FAspectRatio);
    WMSZ_TOPLEFT:
      with PRect(Message.LParam)^ do
        Top := Bottom - Round((Right-Left)/FAspectRatio);
  end;
  for indexRow := 0 to Length(Buttons) - 1 do
      for indexColumn := 0 to Length(Buttons[0]) - 1 do
        Buttons[indexRow, indexColumn].Font.Size := Buttons[indexRow, indexColumn].Height div 3;
  lTime.Font.Size := lTime.Height * 2 div 3;
  inherited;
end;

procedure TfMainForm.AboutClick(Sender: TObject);
begin
  Application.CreateForm(TForm3, Form3);
  Form3.ShowModal;
end;

procedure TfMainForm.DecorClick(Sender: TObject);
begin
  Application.CreateForm(TfChangeLayout, fChangeLayout);
  fChangeLayout.ShowModal;
  //ShowWindow(MainWnd,SW_SHOW);
end;

procedure ArraysSave(var complexity: RComplexity);
var
  indexRow, indexColumn: Cardinal;
begin
  complexity.save := true;
  timeSave := sec;
  SetLength(arraySave, numberRow, numberColumn);
  for indexRow := 0 to numberRow - 1 do
    for indexColumn := 0 to numberColumn - 1 do
      begin
        arraySave[indexRow, indexColumn] := StrToInt((fMainForm.GridPanel2.ControlCollection.ControlItems[indexColumn, indexRow].Control as TNClass).Caption);
      end;
end;

procedure TfMainForm.FormActivate(Sender: TObject);
begin
  if not continueGameSave then
  begin
    if (beginner.save) or (amateur.save) or (professional.save) then
      with TTaskDialog.Create(self) do
      try
        Caption := '����������� ���������� ����';
        Title := '���������� ����������� ����?';
        //Text := 'This is a really tough one...';
        CommonButtons := [tcbYes, tcbNo];
        MainIcon := tdiNone;
        VerificationText := '������ ���������� ����������� ����';
        if Execute then
          if ModalResult = mrYes then
          begin
              SetLength(tempMasText, numberRow, numberColumn);
              LoadingArray(beginner);
              LoadingArray(amateur);
              LoadingArray(professional);
              sec := timeSave;
              lTime.Caption := IntToStr(sec);
          end
          else if ModalResult = mrNo then
           begin
             beginner.save := false;
             amateur.save := false;
             professional.save := false;
           end;
      finally
        Free;
      end;
  end
  else
  begin
    SetLength(tempMasText, numberRow, numberColumn);
    LoadingArray(beginner);
    LoadingArray(amateur);
    LoadingArray(professional);

    sec := timeSave;
    lTime.Caption := IntToStr(sec);
  end;
end;

procedure TfMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  indexRow, indexColumn: Cardinal;
begin
  if start then
  begin
    if not saveGameSave then
    begin
      with TTaskDialog.Create(self) do
      try
        Caption := '����� �� ����';
        Title := '������� ���� �� ���������. ��� ����� �������?';
        CommonButtons := [];
        with TTaskDialogButtonItem(Buttons.Add) do
        begin
          Caption := '���������';
          ModalResult := mrYes;
        end;
        with TTaskDialogButtonItem(Buttons.Add) do
        begin
          Caption := '�� ���������';
          ModalResult := mrNo;
        end;
        with TTaskDialogButtonItem(Buttons.Add) do
        begin
          Caption := '������';
          ModalResult := mrCancel;
        end;
        MainIcon := tdiNone;
        if Execute then
          if ModalResult = mrYes then
          begin
            if beginnerParam then ArraysSave(beginner)
            else if amateurParam then ArraysSave(amateur)
            else if professionalParam then ArraysSave(professional);
          end
          else if ModalResult = mrNo then
          begin
            start := false;
            Close;
          end
          else if ModalResult = mrCancel then
               CanClose := false;
      finally
        Free;
      end;
    end
    else
    begin
      if beginnerParam then ArraysSave(beginner)
      else if amateurParam then ArraysSave(amateur)
      else if professionalParam then ArraysSave(professional)
    end;
  end
  else
  begin
    for indexRow := 0 to numberRow - 1 do
    for indexColumn := 0 to numberColumn - 1 do
      Buttons[indexRow, indexColumn].Destroy;
  end;
end;

procedure TfMainForm.ParametersClick(Sender: TObject);
begin
  Application.CreateForm(TfParameters, fParameters);
  fParameters.ShowModal;
end;

procedure TfMainForm.StatisticsClick(Sender: TObject);
begin
  Application.CreateForm(TfStatistics, fStatistics);
  fStatistics.ShowModal;
end;

procedure TfMainForm.Timer1Timer(Sender: TObject);
begin
  sec := sec + 1;
  lTime.Caption := IntToStr(sec);
end;

procedure TfMainForm.ViewHelpClick(Sender: TObject);
begin
  HtmlHelp(handle,'help.chm',HH_DISPLAY_TOPIC,0);
end;



procedure TfMainForm.FormCreate(Sender: TObject);
var
  indexRow, indexColumn: integer;
begin
  { ������ ���������� � ���������� }
  iniFile.ReadStatistic;
  iniFile.ReadParameters;
  New_Game;
      lTime.Font.Size := ClientHeight * 14 div 300;
  if not (imageFon = 'None') then
    Image1.Picture.LoadFromFile('���/' + imageFon + '.jpg');

end;

procedure TfMainForm.FormDestroy(Sender: TObject);
begin
  iniFile.WriteStatistic;
  iniFile.WriteParameters;
end;

procedure TfMainForm.MainExitClick(Sender: TObject);
begin
  Close;
end;

end.
