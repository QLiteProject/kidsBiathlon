unit MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, System.Generics.Collections, PNGImage;

type
  TListInteger = array of integer;
  TListArrayInteger = array of TListInteger;
  TListString = array of string;

type
  TgameForm = class(TForm)
    renderingBlock: TImage;
    stepBot: TTimer;
    stepCharacter: TTimer;
    startGame: TTimer;
    timePanel: TPanel;
    timeOut: TLabel;
    textTimeOut: TLabel;
    procedure stepBotTimer(Sender: TObject);
    procedure stepCharacterTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure startGameTimer(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    procedure initMap();
    procedure createPlayer();
    procedure createCharacter();
    procedure checkFinish(laps: integer; count: integer; nikName: string);
    procedure clearGame();

    function countRowsInFile(fileName: string): Integer;
    function detectedRoute(tempRoute: TListInteger): Boolean;
    function randomStep(nPlayer: integer): TListInteger;
    function fillArray(nPlayer: integer; n: integer): TListInteger;
    function loadTextureUnit(dr: integer; texture: TListString): string;
    function checkPoint(tempPosition: TListInteger; controlPosition: TListInteger): Boolean;
  public
    procedure nextLVL();

    function resizeBmp(bitmp: TBitMap; wid, hei: Integer): Boolean;
  end;

var
  gameForm: TgameForm;

  sizeBlock: byte = 40;
  startTimeOut: byte = 3;
  gameActive: boolean = true;
  dir_results: string = 'results/';

  playerCount: byte = 2;
  playerArray: array of TImage;
  playerTexturePack: TListString = ['player-one-r.png', 'player-one-l.png', 'player-one-t.png', 'player-one-b.png'];

  routeBlock: TListArrayInteger;
  startPosition: TListInteger;
  shotPosition: TListInteger;

  dir_assets: string = 'textures/';
  texturePack: array of string = ['snow.bmp', 'flag.bmp', 'flag-yellow.bmp', 'point.bmp', 'fence-bottom.bmp'
                                 ,'fence-top.bmp', 'fence-top-line.bmp', 'fence-bottom-line.bmp', 'fence-bottom-corner.bmp'
                                 ,'fence-top-corner.bmp', 'fence-vertical-line.bmp', 'target-three.bmp', 'fur-tree.bmp'];
  mapFile: TextFile;
  map: array of string;
  dir_map: string = 'maps/';
  Locations: array of string = ['map_one.data', 'map_two.data', 'map_three.data', 'map_four.data', 'map_five.data'];
  selectLocation: byte = 0;

  priorityDerectBot: TListInteger;
  skipFrameBot: TListInteger;
  countFrameBot: TListInteger;
  loopBot: TListInteger;
  counterLoopBot: TListInteger;
  nikNameBot: array of string;
  randomSkipFrame, frameGlobal: integer;

  nik: string = 'Эдик';
  character: TImage;
  characterTexturePack: TListString = ['character-one-r.png', 'character-one-l.png', 'player-one-t.png', 'player-one-b.png'];

  activateShot: boolean;
  gameStatistics: TListArrayInteger;

  derect: byte = 1;
  loop: byte = 2;
  counterLoop: byte = 0;

implementation

{$R *.dfm}

uses ShootingForm, IntermediateResultForm, SettingsForm;

//Инициализация
procedure TgameForm.initMap();
var
    sizeX, sizeY, x, y, a: byte;
    texture: TBitMap;
    position: TListInteger;
begin
  sizeX := Length(map[0]);
  sizeY := Length(map);

  renderingBlock.Width := sizeX * sizeBlock;
  renderingBlock.Height := sizeY * sizeBlock;

  texture := TBitMap.Create;
  texture.SetSize(sizeBlock, sizeBlock);

  with renderingBlock do begin
    transparent := True;
    width  := sizeBlock * sizeX;
    height := sizeBlock * sizeY;
    top  := 0;
    left := 0;
  end;

  for y := 0 to sizeY - 1 do
  for x := 1 to sizeX do begin
    if(map[y][x] = ' ') then continue;

    case map[y][x] of
      '#': texture.LoadFromFile(dir_assets + texturePack[0]);
      '|': texture.LoadFromFile(dir_assets + texturePack[1]);
      '!': texture.LoadFromFile(dir_assets + texturePack[2]);
      '(': texture.LoadFromFile(dir_assets + texturePack[4]);
      '{': texture.LoadFromFile(dir_assets + texturePack[5]);
      '=': texture.LoadFromFile(dir_assets + texturePack[6]);
      '-': texture.LoadFromFile(dir_assets + texturePack[7]);
      ')': texture.LoadFromFile(dir_assets + texturePack[8]);
      '}': texture.LoadFromFile(dir_assets + texturePack[9]);
      ']': texture.LoadFromFile(dir_assets + texturePack[10]);
      '*': texture.LoadFromFile(dir_assets + texturePack[11]);
      '^': texture.LoadFromFile(dir_assets + texturePack[12]);

      '.', '1', '+': texture.LoadFromFile(dir_assets + texturePack[3]);
    end;

    position := [(x - 1) * sizeBlock + sizeBlock, y * sizeBlock + sizeBlock];

    if map[y][x] in['.', '1', '+'] then begin
      a := Length(routeBlock) + 1;
      SetLength(routeBlock, a);
      routeBlock[a - 1] := position;
    end;

    if map[y][x] = '1' then startPosition := position;
    if map[y][x] = '+' then shotPosition := position;

    resizeBmp(texture, sizeBlock, sizeBlock);
    renderingBlock.Canvas.Draw((x - 1) * sizeBlock, y * sizeBlock, texture);
  end;

end;

//Создание ботов
procedure TgameForm.createPlayer();
var
  i: integer;
  player: TImage;
begin
  SetLength(playerArray, playerCount);
  SetLength(priorityDerectBot, playerCount);
  SetLength(skipFrameBot, playerCount);
  SetLength(countFrameBot, playerCount);
  SetLength(loopBot, playerCount);
  SetLength(counterLoopBot, playerCount);
  SetLength(nikNameBot, playerCount);

  for i := 0 to playerCount - 1 do begin
    player := TImage.Create(self);

    with player do begin
      top := startPosition[1] - sizeBlock;
      left := startPosition[0] - sizeBlock;
      height := sizeBlock;
      width := sizeBlock;
      Picture.LoadFromFile(loadTextureUnit(derect, playerTexturePack));
      Transparent := true;
      Stretch := true;
      Parent := self;
    end;

    nikNameBot[i] := 'Бот #' + IntToStr(i + 1);
    playerArray[i] := player;
  end;

    counterLoopBot := fillArray(playerCount, 0);
    loopBot := fillArray(playerCount, loop);
    countFrameBot := fillArray(playerCount, 0);
    priorityDerectBot := fillArray(playerCount, derect);
    skipFrameBot := randomStep(playerCount);
end;

//Создание игрока
procedure TgameForm.createCharacter();
begin
  character := TImage.Create(self);

  with character do
  begin
      top := startPosition[1] - sizeBlock;
      left := startPosition[0] - sizeBlock;
      height := sizeBlock;
      width := sizeBlock;
      Picture.LoadFromFile(loadTextureUnit(derect, characterTexturePack));
      Transparent := true;
      Stretch := true;
      Parent := self;
  end;
end;

//Запрос на закрытие приложения
procedure TgameForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin

  stepBot.Enabled := false;
  stepCharacter.Enabled := false;

  case MessageBox(Handle, 'Вы действительно хотите покинуть игру? Все на сохранённые результаты буду потеряны!',
  'Попытка закрыть приложение...', MB_YESNO + MB_ICONQUESTION) of
  IDYES:
    begin
      CanClose:=True;
      Application.Terminate;
    end;
  IDNO:
    begin
      CanClose:=False;

      if gameActive <> false then begin
        stepBot.Enabled := true;
        stepCharacter.Enabled := true;
      end;
    end;
  end;

end;

//Подгрузка
procedure TgameForm.FormShow(Sender: TObject);
var
  buffer: string;
  countRows, i: integer;
begin Randomize;
  gameForm.Caption := setGameForm.selectLVL.Items[selectLocation] + ' | Круг: #' + IntToStr(counterLoop + 1);

  gameActive := false;
  activateShot := true;

  SetLength(gameStatistics, loop);
  randomSkipFrame := random(60) + playerCount;
  frameGlobal := 0;

  countRows := countRowsInFile(dir_map + Locations[selectLocation]);
  SetLength(map, countRows);

  AssignFile(mapFile, dir_map + Locations[selectLocation]); Reset(mapFile);

  for i := 0 to countRows - 1 do begin
    readln(mapFile, buffer);
    map[i] := buffer;
  end;

  CloseFile(mapFile);

  initMap();

  if(startPosition <> nil) and (playerCount <> 0) then
  begin
     createPlayer();
     createCharacter();

     gameForm.AutoSize := true;

     timeOut.Caption := IntToStr(startTimeOut);
     timePanel.Top := gameForm.Height div 2 - timePanel.Height div 2;
     timePanel.Left := gameForm.Width div 2 - timePanel.Width div 2;
     timePanel.Visible := true;

     startGame.Enabled := true;
  end else ShowMessage('Ошибка компиляции карты!');
end;

//Движение игрока
procedure TgameForm.stepCharacterTimer(Sender: TObject);
var
   lockDirect: boolean;
   bufferPosition, characterPostion: TListInteger;
begin
  checkFinish(loop, counterLoop, nik);
  lockDirect := false;

  characterPostion := [character.Left + sizeBlock, character.Top + sizeBlock];

  if(GetAsyncKeyState(68) <> 0) and (lockDirect = false) then begin
    bufferPosition := [characterPostion[0] + sizeBlock, characterPostion[1]];
    lockDirect := true;

    if(detectedRoute(bufferPosition)) then begin
      character.Left := character.Left + sizeBlock;
      character.Picture.LoadFromFile(loadTextureUnit(1, characterTexturePack));
    end else lockDirect := false;
  end;

  if(GetAsyncKeyState(65) <> 0) and (lockDirect = false) then begin
    bufferPosition := [characterPostion[0] - sizeBlock, characterPostion[1]];
    lockDirect := true;

    if(detectedRoute(bufferPosition)) then begin
      character.Left := character.Left - sizeBlock;
      character.Picture.LoadFromFile(loadTextureUnit(3, characterTexturePack));
    end else lockDirect := false;
  end;

  if(GetAsyncKeyState(83) <> 0) and (lockDirect = false) then begin
    bufferPosition := [characterPostion[0], characterPostion[1] + sizeBlock];
    lockDirect := true;

    if(detectedRoute(bufferPosition)) then begin
      character.Top := character.Top + sizeBlock;
      character.Picture.LoadFromFile(loadTextureUnit(4, characterTexturePack));
    end else lockDirect := false;
  end;

  if(GetAsyncKeyState(87) <> 0) and (lockDirect = false) then begin
   bufferPosition := [characterPostion[0], characterPostion[1] - sizeBlock];
   lockDirect := true;

   if(detectedRoute(bufferPosition)) then begin
      character.Top := character.Top - sizeBlock;
      character.Picture.LoadFromFile(loadTextureUnit(2, characterTexturePack));
    end else lockDirect := false;
  end;

  if ((GetAsyncKeyState(87) <> 0) or (GetAsyncKeyState(83) <> 0) or (GetAsyncKeyState(65) <> 0) or (GetAsyncKeyState(68) <> 0)) then begin


    if checkPoint(bufferPosition, shotPosition) and (activateShot <> false) then begin
      stepBot.Enabled := false;
      stepCharacter.Enabled := false;
      activateShot := false;

      ShootForm.Show;
    end;

    if checkPoint(bufferPosition, startPosition) and (activateShot <> true) then begin
      counterLoop := counterLoop + 1;
      activateShot := true;

      gameForm.Caption := setGameForm.selectLVL.Items[selectLocation] + ' | Круг: #' + IntToStr(counterLoop + 1);
    end;
  end;

end;

//Отсчёт до начала игры
procedure TgameForm.startGameTimer(Sender: TObject);
begin
  if StrToInt(timeOut.Caption)  > 0 then
     timeOut.Caption := IntToStr( StrToInt(timeOut.Caption) - 1 )
  else begin
     stepCharacter.Enabled := true;
     stepBot.Enabled := true;

     startGame.Enabled := false;
     timePanel.Visible := false;

     gameActive := true;
  end;

end;

//Движение ботов
procedure TgameForm.stepBotTimer(Sender: TObject);
var
  i: integer;
  bufferPosition, playerPostion: TListInteger;
begin
    if(frameGlobal <> randomSkipFrame) then frameGlobal := frameGlobal + 1 else
    begin
      frameGlobal := 0;

      skipFrameBot := randomStep(playerCount);
      countFrameBot := fillArray(playerCount, 0);
    end;

    for i := 0 to playerCount - 1 do begin
      if(countFrameBot[i] <> skipFrameBot[i]) then begin countFrameBot[i] := countFrameBot[i] + 1; continue; end;

      checkFinish(loopBot[i], counterLoopBot[i], nikNameBot[i]);

      playerPostion := [playerArray[i].Left + sizeBlock, playerArray[i].Top + sizeBlock];

      case priorityDerectBot[i] of
           1: begin
            bufferPosition := [playerPostion[0] + sizeBlock, playerPostion[1]];

            if(detectedRoute(bufferPosition)) then begin

              with playerArray[i] do begin
                left := left + sizeBlock;
                Picture.LoadFromFile(loadTextureUnit(1, playerTexturePack));
              end;

              playerPostion := bufferPosition;
            end;

            if bufferPosition <> playerPostion then priorityDerectBot[i] := 2 else priorityDerectBot[i] := 4;
           end;

           2: begin
            bufferPosition := [playerPostion[0], playerPostion[1] - sizeBlock];

            if(detectedRoute(bufferPosition)) then begin

              with playerArray[i] do begin
                top := top - sizeBlock;
                Picture.LoadFromFile(loadTextureUnit(2, playerTexturePack));
              end;

              playerPostion := bufferPosition;
            end;

            if bufferPosition <> playerPostion then priorityDerectBot[i] := 3 else priorityDerectBot[i] := 1;
           end;

           3: begin
            bufferPosition := [playerPostion[0] - sizeBlock,  playerPostion[1]];

            if(detectedRoute(bufferPosition)) then begin

              with playerArray[i] do begin
                left := left - sizeBlock;
                Picture.LoadFromFile(loadTextureUnit(3, playerTexturePack));
              end;

              playerPostion := bufferPosition;
            end;

            if bufferPosition <> playerPostion then priorityDerectBot[i] := 4 else priorityDerectBot[i] := 2;
           end;

           4: begin
            bufferPosition := [playerPostion[0], playerPostion[1] + sizeBlock];

            if(detectedRoute(bufferPosition)) then begin

              with playerArray[i] do begin
                top := top + sizeBlock;
                Picture.LoadFromFile(loadTextureUnit(4, playerTexturePack));
              end;

              playerPostion := bufferPosition;
            end;

            if bufferPosition <> playerPostion then priorityDerectBot[i] := 1 else priorityDerectBot[i] := 3;
           end;
      end;

      countFrameBot[i] := 0;

      if checkPoint(bufferPosition, startPosition) then counterLoopBot[i] := counterLoopBot[i] + 1;
    end;
end;

//Проверка окончания игры
procedure TgameForm.checkFinish(laps: integer; count: integer; nikName: string);
var
  i: byte;
begin
  if count = laps then begin
      stepBot.Enabled := false;
      stepCharacter.Enabled := false;

      gameForm.Caption := setGameForm.selectLVL.Items[selectLocation] + ' | Игра окончена!';
      ShowMessage('Игра окончена! Победил: ' + nikName + '. В следующем окне будет выведен ваш результат за уровень.');

      resultOfLVL.Show;
  end;
end;

//Следующий LVL
procedure TgameForm.nextLVL();
begin
  if selectLocation + 1 < Length(Locations) then begin
    ShowMessage('Сейчас начнётся новый уровень!');
    selectLocation := selectLocation + 1;

    clearGame();
    FormShow(gameForm);
  end else begin
    case MessageBox(Handle, 'Вот и всё, игра окончена! Спасибо за прохождение!' + #13#10 + #13#10 +'Хотити выйти из приложения? Если вы нажмёте "Нет", то будут показаны результаты за всю игру.', 'Конец игры...' ,MB_YESNO + MB_ICONQUESTION) of
       IDNO: begin
         gameActive := false;

         resultOfLVL.saveResult.Enabled := true;
         resultOfLVL.nextLvl.Enabled := false;
         resultOfLVL.Caption := 'Результаты за игру. Можете их сохранить...';
         resultOfLVL.Show;

         gameForm.Hide;
       end;
       IDYES: begin
         Application.Terminate;
       end;
    end;
  end;
end;

//Отчистка игрового поля + переменных
procedure TgameForm.clearGame();
var
  i: byte;
begin
  renderingBlock.Canvas.FillRect(renderingBlock.Canvas.ClipRect);

  startPosition  := nil;
  shotPosition   := nil;

  timeOut.Caption := IntToStr(startTimeOut);
  counterLoop := 0;

  for i := 0 to Length(playerArray) - 1 do begin
    playerArray[i].DisposeOf;
  end;

  playerArray    := nil;
  routeBlock     := nil;
  counterLoopBot := nil;

  character.DisposeOf;
  character := nil;
  gameStatistics := nil;
end;

//Ресайз Bmp
function TgameForm.resizeBmp(bitmp: TBitMap; wid: Integer; hei: Integer): Boolean;
var
    TmpBmp: TBitMap;
    ARect: TRect;
begin
  Result := False;
  try
    TmpBmp := TBitMap.Create;
    try
      TmpBmp.Width  := wid;
      TmpBmp.Height := hei;
      ARect := Rect(0,0, wid, hei);
      TmpBmp.Canvas.StretchDraw(ARect, Bitmp);
      TmpBmp.Transparent := true;
      bitmp.Assign(TmpBmp);
    finally
      TmpBmp.Free;
    end;
    Result := True;
  except
    Result := False;
  end;
end;

//Запонение массива конкретным числом
function TgameForm.fillArray(nPlayer: integer; n: integer): TListInteger;
var
  i: integer;
  returnArray: TListInteger;
begin
  SetLength(returnArray, nPlayer);

  for i := 0 to nPlayer - 1 do
     returnArray[i] := n;

  fillArray := returnArray;
end;

//Рандомный скип кадров
function TgameForm.randomStep(nPlayer: integer): TListInteger;
label
  goBack;
var
  frame: integer;
  randomSkip, returnArray: TListInteger;
  i, j: integer;
begin
  SetLength(randomSkip, nPlayer);
  SetLength(returnArray, nPlayer);

  for i := 0 to nPlayer - 1 do begin
    goBack:
      Randomize;
      frame := random(nPlayer) + 1;

    for j := 0 to Length(randomSkip) - 1 do
      if (frame = randomSkip[j]) then goto goBack;

    randomSkip[i] := frame;
    returnArray[i] := randomSkip[i];
  end;

  randomStep := returnArray;
end;

//Подсчёт строк в файле карты
function TgameForm.countRowsInFile(fileName: string): Integer;
var
  i: integer;
  openFile: TextFile;
begin
  i := 0;

  AssignFile(openFile, fileName); Reset(openFile);

  while not EOF(openFile) do
    begin
      readln(openFile);
      i := i + 1;
    end;

  CloseFile(openFile);

  countRowsInFile := i;
end;

//Закрузка текстур для юнитов
function TgameForm.loadTextureUnit(dr: integer; texture: TListString): string;
begin
  case dr of
    1: loadTextureUnit := dir_assets + texture[0];
    2: loadTextureUnit := dir_assets + texture[2];
    3: loadTextureUnit := dir_assets + texture[1];
    4: loadTextureUnit := dir_assets + texture[3];
  end;
end;

//Проверка валидности хода
function TgameForm.detectedRoute(tempRoute: TListInteger): Boolean;
var
  y: integer;
begin
  for y := 0 to Length(routeBlock) - 1 do if(routeBlock[y][0] = tempRoute[0]) and (routeBlock[y][1] = tempRoute[1]) then detectedRoute := true;
end;

//Провекра чеков
function TgameForm.checkPoint(tempPosition: TListInteger; controlPosition: TListInteger): Boolean;
begin
  if(tempPosition[0] = controlPosition[0]) and (tempPosition[1] = controlPosition[1]) then CheckPoint := true else CheckPoint := false;
end;

end.
