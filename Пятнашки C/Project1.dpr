program Project1;

uses
  Forms,
  uMainForm in 'uMainForm.pas' {fMainForm},
  NClass in 'NClass.pas',
  uStatistic in 'uStatistic.pas' {fStatistics},
  uParameters in 'uParameters.pas' {fParameters},
  uIniFile in 'uIniFile.pas',
  uNewGame in 'uNewGame.pas' {Form2},
  uWin in 'uWin.pas' {fWin},
  uChangeLayout in 'uChangeLayout.pas' {fChangeLayout},
  About in 'About.pas' {Form3};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfMainForm, fMainForm);
  Application.Run;
end.
