unit IntermediateResultForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, MainForm;

type
  TresultOfLVL = class(TForm)
    resultMemo: TMemo;
    saveResult: TButton;
    nextLvl: TButton;
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure saveResultClick(Sender: TObject);
    procedure nextLvlClick(Sender: TObject);
  private
    { Private declarations }
  public
    function GetUserFromWindows: string;
  end;

var
  resultOfLVL: TresultOfLVL;
implementation

{$R *.dfm}

uses SettingsForm;

procedure TresultOfLVL.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
    if gameActive then begin
      CanClose := false;
      resultOfLVL.Hide;
      gameForm.nextLVL();
    end
    else begin
      if saveResult.Enabled <> true then begin
        ShowMessage('До свидания!');
        Application.Terminate;
      end else begin
        CanClose := false;
        gameForm.CloseQuery;
      end;
    end;
end;

procedure TresultOfLVL.FormShow(Sender: TObject);
var
  i: byte;
  tempResult: string;
begin
  if(gameActive <> false) then begin

    for i := 0 to Length(gameStatistics) - 1 do begin
      try
        tempResult := setGameForm.selectLVL.Items[selectLocation] + ': круг #' + IntToStr(gameStatistics[i][0]) + ', попаданий - ' + IntToStr(gameStatistics[i][1]) + ', промахи - ' + IntToStr(gameStatistics[i][2]) + ';';
      except
        tempResult := '---*-Контрольная метка была пропущена-*---';
      end;

      resultMemo.Lines.Add(tempResult);
    end;

    resultMemo.Lines.Add('--------------------------------------------------------------------------------------------' + #13#10);
  end;
end;

procedure TresultOfLVL.nextLvlClick(Sender: TObject);
begin
  resultOfLVL.Close;
end;

procedure TresultOfLVL.saveResultClick(Sender: TObject);
var
  today : TDateTime;
  date, time, save, nikname: string;
  exception: array of string;
  i: byte;
begin
   exception := ['?', '|', '\', '/', ':', '*', '"', '<', '>'];

   today := Now;
   date := 'date-' + DateToStr(today);
   time := 'time-' + StringReplace(TimeToStr(today), ':', '.', [rfReplaceAll, rfIgnoreCase]);
   nikname := nik;

   for i := 0 to Length(exception) - 1 do nikname := StringReplace(nikname, exception[i], '', [rfReplaceAll, rfIgnoreCase]);

   if(Trim(nikname) = '') then
    if(GetUserFromWindows <> 'Unknown') then nikname := GetUserFromWindows else nikname := 'NoName';

   save := dir_results + nikname + ' [' + date +', ' + time + '].result';

   resultMemo.Lines.SaveToFile(save);

   ShowMessage('Результат сохранён в: ../' + save);

   saveResult.Enabled := false;
end;

function TresultOfLVL.GetUserFromWindows: string;
var
  UserName : string;
  UserNameLen : Dword;
begin
  UserNameLen := 255;
  SetLength(userName, UserNameLen);
  if GetUserName(PChar(UserName), UserNameLen) then
    Result := Copy(UserName,1,UserNameLen - 1)
  else
    Result := 'Unknown';
end;

end.
