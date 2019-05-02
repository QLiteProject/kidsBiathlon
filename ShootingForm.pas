unit ShootingForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls, GifImg,
  Vcl.StdCtrls, Vcl.Imaging.jpeg;

type
  TshootForm = class(TForm)
    aim: TImage;
    aimPoint: TTimer;
    target_3: TImage;
    target_5: TImage;
    target_4: TImage;
    targetFrame: TImage;
    target_1: TImage;
    target_2: TImage;
    background: TImage;
    statisticsBox: TGroupBox;
    Label1: TLabel;
    stat: TLabel;
    Label2: TLabel;
    shots: TLabel;
    Label3: TLabel;
    beats: TLabel;
    Label4: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure aimPointTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure aimMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
//    procedure createBackgroundGif();
    procedure addTargetPoints();
  public
    { Public declarations }
  end;

var
  shootForm: TshootForm;
  ListTargetPoint: array[0..4] of TPoint;
  t: double = 0;


implementation

{$R *.dfm}

uses MainForm;


//Движение прицела
procedure TshootForm.aimMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  bufferPoint: TPoint;
  active: byte;
  check: boolean;
  texture: string;
  tempResult: TListInteger;
begin
  check := false;
  bufferPoint := TPoint.Create(aim.Left + aim.Width div 2, aim.Top + aim.Height div 2);

  if StrToInt(shots.Caption) > 0 then begin
     shots.Caption := IntToStr(StrToInt(shots.Caption) - 1);
     active := Length(ListTargetPoint) - StrToInt(shots.Caption);

     if(bufferPoint.X > ListTargetPoint[active - 1].X - 5) and (bufferPoint.X < ListTargetPoint[active - 1].X + 5) then
       if(bufferPoint.Y > ListTargetPoint[active - 1].Y - 5) and (bufferPoint.Y < ListTargetPoint[active - 1].Y + 5) then begin
          beats.Caption := IntToStr(StrToInt(beats.Caption) + 1);
          check := true;
       end;

     if check then texture := (dir_assets + 'target-close.png') else texture := (dir_assets + 'target-miss.png');

     (FindComponent('target_' + IntToStr(active)) as TImage).Enabled := false;
     (FindComponent('target_' + IntToStr(active)) as TImage).Picture.LoadFromFile(texture);

     if(StrToInt(shots.Caption) <> 0) then begin
      (FindComponent('target_' + IntToStr(active + 1)) as TImage).Enabled := true;
      (FindComponent('target_' + IntToStr(active + 1)) as TImage).Picture.LoadFromFile(dir_assets + 'target-active.png');
     end;

  end;

  if(StrToInt(shots.Caption) = 0) then begin
    SetLength(tempResult, 3);

    aimPoint.Enabled := false;
    ShowMessage('Стрельба окончена! Попаданий за сессию: ' + beats.Caption);

    tempResult := [counterLoop + 1, StrToInt(beats.Caption), 5 - StrToInt(beats.Caption)];
    gameStatistics[counterLoop] := tempResult;

    shootForm.Close;
  end;
end;

procedure TshootForm.aimPointTimer(Sender: TObject);
var
  foo, centr: TPoint;
  sp: double;
begin
  sp := 0.095;

  GetCursorPos(foo);
  centr := TPoint.Create((foo.Y - shootForm.Top) - aim.height * 2, (foo.X - shootForm.Left)- aim.width + 3);

  if (GetAsyncKeyState(78) <> 0) and (GetAsyncKeyState(82) <> 0) and (GetAsyncKeyState(90) <> 0) then begin
      sp := 0.03;
      stat.Caption := 'спокоен... ну почти...';
  end else begin
      stat.Caption := 'волнение. - страшно.';
  end;

  with aim do
  begin
    top := centr.X + (round(sin(2 * t) * 20));
    left := centr.Y - (round(cos(t) * 30));
  end;

  if t <= 360 then t := t + sp else t := 0;

end;

//Процедуры на выход
procedure TshootForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  gameForm.stepBot.Enabled := true;
  gameForm.stepCharacter.Enabled := true;
end;

//Общая подгрузка
procedure TshootForm.FormShow(Sender: TObject);
begin
//  createBackgroundGif();
  addTargetPoints();

  target_1.Picture.LoadFromFile(dir_assets + 'target-active.png');
  target_1.Enabled := true;

  shots.Caption := '5';
  beats.Caption := '0';

  aimPoint.Enabled := true;
end;

//Добавляем поинты для мишений
procedure TshootForm.addTargetPoints;
var
  bufferImage: TImage;
var
  i: byte;
begin
  for i := 0 to Length(ListTargetPoint) - 1 do begin

    bufferImage := (FindComponent('target_' + IntToStr(i + 1)) as TImage);
    bufferImage.Picture.LoadFromFile(dir_assets + 'target.png');
    bufferImage.Enabled := false;

    ListTargetPoint[i] := TPoint.Create(bufferImage.Left + 24, bufferImage.Top + 24);
  end;
end;

//Подгрузка заднего фона с снегом
//procedure TshootForm.createBackgroundGif;
//var
//  gif: TGifImage;
//begin
//    gif := TGifImage.Create;
//    gif.LoadFromFile(dir_pack + 'snow.gif');
//    gif.Animate := True;
//    gif.AnimateLoop := glEnabled;
//    gif.Transparent := true;
//
//    background.Picture.Assign(gif);
//end;

end.
