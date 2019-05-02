program KidsBiathlon;

uses
  Vcl.Forms,
  WelcomeForm in 'WelcomeForm.pas' {startForm},
  MainForm in 'MainForm.pas' {gameForm},
  ShootingForm in 'ShootingForm.pas' {shootForm},
  SettingsForm in 'SettingsForm.pas' {setGameForm},
  IntermediateResultForm in 'IntermediateResultForm.pas' {resultOfLVL},
  RecordsForm in 'RecordsForm.pas' {tableOfRecords},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := False;
  Application.CreateForm(TstartForm, startForm);
  Application.CreateForm(TgameForm, gameForm);
  Application.CreateForm(TshootForm, shootForm);
  Application.CreateForm(TsetGameForm, setGameForm);
  Application.CreateForm(TresultOfLVL, resultOfLVL);
  Application.CreateForm(TtableOfRecords, tableOfRecords);
  Application.Run;
end.
