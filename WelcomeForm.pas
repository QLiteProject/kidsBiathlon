unit WelcomeForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls;

type
  TstartForm = class(TForm)
    goToGameForm: TButton;
    goToSetGameForm: TButton;
    about: TButton;
    background: TImage;
    goToTableResults: TButton;
    procedure goToGameFormClick(Sender: TObject);
    procedure goToSetGameFormClick(Sender: TObject);
    procedure aboutClick(Sender: TObject);
    procedure goToTableResultsClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  startForm: TstartForm;

implementation

{$R *.dfm}

uses MainForm, SettingsForm, RecordsForm;

procedure TstartForm.aboutClick(Sender: TObject);
begin
  ShowMessage(
  'Игра: KIDS Biathlon ' +  #13#10 +
  'Автор игры: Нечаев Богдан, ПКС-16/1' +  #13#10 +
  'Дата разработки: 23.04.2019' + #13#10 + #13#10 +
  'Цель игры: приехать к финишу первым и заработать наибольшое количество очков.'+ #13#10 + #13#10 +
  'Управление:' + #13#10 +
  'W: Движение вверх | S: Движение вниз | A: Движение влево | D: Движение в право.'
  );
end;

procedure TstartForm.goToGameFormClick(Sender: TObject);
begin
  gameForm.Show;
  startForm.Hide;
end;

procedure TstartForm.goToSetGameFormClick(Sender: TObject);
begin
  setGameForm.ShowModal;
end;

procedure TstartForm.goToTableResultsClick(Sender: TObject);
begin
  tableOfRecords.ShowModal;
end;

end.
