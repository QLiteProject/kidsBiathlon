unit SettingsForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TsetGameForm = class(TForm)
    Label1: TLabel;
    Label3: TLabel;
    countBots: TEdit;
    countLoop: TEdit;
    setCustomSettings: TButton;
    setDefaultSettings: TButton;
    Label2: TLabel;
    selectLVL: TComboBox;
    Label5: TLabel;
    nikName: TEdit;
    Label4: TLabel;
    timeOut: TEdit;
    procedure setDefaultSettingsClick(Sender: TObject);
    procedure setCustomSettingsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  setGameForm: TsetGameForm;
  defCountBot, defLoop, defSelectLVL, defTimeOut: byte;
  defNikName: string;

implementation

{$R *.dfm}

uses MainForm;

procedure TsetGameForm.FormCreate(Sender: TObject);
begin
   defCountBot := playerCount;
   defLoop := loop;
   defSelectLVL := selectLocation;
   defNikName := nik;
   defTimeOut := startTimeOut;

   countBots.Text := IntToStr(defCountBot);
   countLoop.Text := IntToStr(defLoop);
   selectLVL.ItemIndex := defSelectLVL;
   nikName.Text := defNikName;
   startTimeOut := defTimeOut;
end;

procedure TsetGameForm.setCustomSettingsClick(Sender: TObject);
begin
  if (Trim(countBots.Text) = '') OR (Trim(countLoop.Text) = '') OR (Trim(nikName.Text) = '') OR (Trim(timeOut.Text) = '')
      OR
     (StrToInt(countBots.Text) <= 0) OR (StrToInt(countLoop.Text) > 4)
      OR
     (StrToInt(countBots.Text) <= 0) OR (StrToInt(countLoop.Text) > 4)
      OR
     (StrToInt(timeOut.Text) <= 0) OR (StrToInt(timeOut.Text) > 3)
  then
      ShowMessage('Ошибка, одно из полей заполненно не корректно.')
  else begin
    playerCount := StrToInt(countBots.Text);
    loop := StrToInt(countLoop.Text);
    selectLocation := selectLVL.ItemIndex;
    nik := Trim(nikName.Text);
    startTimeOut := StrToInt(timeOut.Text);

    ShowMessage('Пользовательские настройки применены!');

    setGameForm.Close;
  end;

end;

procedure TsetGameForm.setDefaultSettingsClick(Sender: TObject);
begin
  countBots.Text := IntToStr(defCountBot);
  countLoop.Text := IntToStr(defLoop);
  selectLVL.ItemIndex := defSelectLVL;
  nikName.Text := defNikName;
  timeOut.Text := IntToStr(defTimeOut);

  countBots.Text := IntToStr(defCountBot);
  countLoop.Text := IntToStr(defLoop);
  selectLVL.ItemIndex := defSelectLVL;
  nikName.Text := defNikName;
  startTimeOut := defTimeOut;

  ShowMessage('Настройки поумолчанию применены!');

  setGameForm.Close;
end;

end.
