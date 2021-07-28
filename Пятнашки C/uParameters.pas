unit uParameters;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Samples.Spin;

type
  TfParameters = class(TForm)
    GroupBox1: TGroupBox;
    rbBeginner: TRadioButton;
    rbAmateur: TRadioButton;
    rbProfessional: TRadioButton;
    rbOther: TRadioButton;
    lHeight: TLabel;
    lWidth: TLabel;
    eHeight: TEdit;
    eWidth: TEdit;
    bOk: TButton;
    bCancel: TButton;
    cbSound: TCheckBox;
    cbContinueGame: TCheckBox;
    cbSaveGame: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure rbOtherClick(Sender: TObject);
    procedure rbBeginnerClick(Sender: TObject);
    procedure bCancelClick(Sender: TObject);
    procedure eHeightExit(Sender: TObject);
    procedure eHeightKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure bOkClick(Sender: TObject);
    procedure SaveAndNew;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fParameters: TfParameters;
  beginnerChecked, amateurChecked, professionalChecked, otherChecked: boolean;

implementation
uses
  uIniFile, uMainForm, NClass;
{$R *.dfm}

procedure TfParameters.bCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfParameters.SaveAndNew;
begin
  if rbBeginner.Checked then
    begin
      beginnerParam := true;
      amateurParam := false;
      professionalParam := false;
      otherParam := false;
    end
    else if rbAmateur.Checked then
    begin
      beginnerParam := false;
      amateurParam := true;
      professionalParam := false;
      otherParam := false;
    end
    else if rbProfessional.Checked then
    begin
      beginnerParam := false;
      amateurParam := false;
      professionalParam := true;
      otherParam := false;
    end
    else if rbOther.Checked then
    begin
      beginnerParam := false;
      amateurParam := false;
      professionalParam := false;
      otherParam := true;
    end;
    otherParamEditW := StrToInt(eWidth.Text);
    otherParamEditH := StrToInt(eHeight.Text);
    Close;

end;

procedure TfParameters.bOkClick(Sender: TObject);
begin

    if start then
    begin
      if (rbBeginner.Checked <> beginnerChecked) or (rbAmateur.Checked <> amateurChecked) or
      (rbProfessional.Checked <> professionalChecked) or (rbOther.Checked <> otherChecked) then
      begin
      with TTaskDialog.Create(self) do
          try
            Caption := 'Изменение настроек игры';
            Title := 'Эти параместры нельзя применить в ходе игры. Выберите нужное действие.';
            CommonButtons := [];
            with TTaskDialogButtonItem(Buttons.Add) do
            begin
              Caption := 'Закрыть и начать новую игру с новыми параметрами';
              CommandLinkHint := 'В статистике это засчитается как поражение.';
              ModalResult := mrClose;
            end;
            with TTaskDialogButtonItem(Buttons.Add) do
            begin
              Caption := 'Закончить игру';
              CommandLinkHint := 'Новые параметры будут применены в следующей игре.';
              ModalResult := mrYes;
            end;
            Flags := [tfUseCommandLinks, tfAllowDialogCancellation];
            MainIcon := tdiNone;
            if Execute then
              if ModalResult = mrClose then
              begin
                fMainForm.DecParam;
                SaveAndNew;
                fMainForm.New_Game;
              end
              else if ModalResult = mrYes then
              begin
                //fMainForm.DecParam;
                SaveAndNew;
                Close;
                //fMainForm.New_Game;

              end

          finally
            Free;
          end;

      end;
    end
    else
    begin
      SaveAndNew;
      fMainForm.New_Game;
    end;
  soundSave := cbSound.Checked;
  continueGameSave := cbContinueGame.Checked;
  saveGameSave := cbSaveGame.Checked;
  Close;
end;

procedure TfParameters.eHeightExit(Sender: TObject);
  type
  PEditBalloonTip = ^TEditBalloonTip;
  EDITBALLOONTIP = record
    cbStruct: DWORD;
    pszTitle: PWChar;
    pszText: PWChar;
    ttiIcon: Integer;
  end;
  TEditBalloonTip = EDITBALLOONTIP;

const
  EM_SHOWBALLOONTIP = $1503;
  EM_HIDEBALLOONTIP = $1504;
  TTI_NONE    = 0;
  TTI_INFO    = 1;
  TTI_WARNING = 2;
  TTI_ERROR   = 3;

var
  BaloonTip: TEditBalloonTip;
begin
  if StrToInt((Sender as TEdit).Text) < 2 then
  begin
    eHeight.Text := '2';
    BaloonTip.cbStruct := SizeOf(TEditBalloonTip);
    BaloonTip.pszTitle := 'Значение за пределами допустимого диапазона';
    BaloonTip.pszText := 'Указано слишком маленькое значение.';
    BaloonTip.ttiIcon := TTI_INFO;
    SendMessage((Sender as TEdit).Handle, EM_SHOWBALLOONTIP, 0, Integer(@BaloonTip));
  end
  else if StrToInt((Sender as TEdit).Text) > 10 then
  begin
    eHeight.Text := '10';
    BaloonTip.cbStruct := SizeOf(TEditBalloonTip);
    BaloonTip.pszTitle := 'Значение за пределами допустимого диапазона';
    BaloonTip.pszText := 'Указано слишком большое значение.';
    BaloonTip.ttiIcon := TTI_INFO;
    SendMessage((Sender as TEdit).Handle, EM_SHOWBALLOONTIP, 0, Integer(@BaloonTip));
  end;
end;

procedure TfParameters.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfParameters.FormCreate(Sender: TObject);
begin
  rbBeginner.Checked := beginnerParam;
  beginnerChecked := beginnerParam;
  rbAmateur.Checked := amateurParam;
  amateurChecked := amateurParam;
  rbProfessional.Checked := professionalParam;
  professionalChecked := professionalParam;
  if otherParam then
    begin
     rbOther.Checked := true;
     rbOtherClick(nil);
    end;
  otherChecked := otherParam;
  eHeight.Text := IntToStr(otherParamEditH);
  eWidth.Text := IntToStr(otherParamEditW);
  rbBeginner.Caption := 'Новичок'+#13#10+'поле 4x4 ячеек';
  rbAmateur.Caption := 'Любитель'+#13#10+'поле 5x5 ячеек';
  rbProfessional.Caption := 'Профессионал'+#13#10+'поле 6x6 ячеек';

  SetWindowLongPtr(eHeight.Handle, GWL_STYLE, GetWindowLongPtr(eHeight.Handle, GWL_STYLE) or ES_NUMBER);
  SetWindowLongPtr(eWidth.Handle, GWL_STYLE, GetWindowLongPtr(eWidth.Handle, GWL_STYLE) or ES_NUMBER);

  cbSound.Checked := soundSave;
  cbContinueGame.Checked := continueGameSave;
  cbSaveGame.Checked := saveGameSave;
end;

procedure TfParameters.rbBeginnerClick(Sender: TObject);
begin
  lHeight.Enabled := false;
  lWidth.Enabled := false;
  eHeight.Enabled := false;
  eWidth.Enabled := false;
end;

procedure TfParameters.rbOtherClick(Sender: TObject);
begin
  lHeight.Enabled := true;
  lWidth.Enabled := true;
  eHeight.Enabled := true;
  eWidth.Enabled := true;
end;

procedure TfParameters.eHeightKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then eHeightExit(nil);
end;

end.
