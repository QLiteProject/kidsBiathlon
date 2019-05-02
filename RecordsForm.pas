unit RecordsForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Menus;

type
  TtableOfRecords = class(TForm)
    grFiles: TGroupBox;
    grResults: TGroupBox;
    lsFiles: TListBox;
    mResults: TMemo;
    lsMenu: TPopupMenu;
    deleteResult: TMenuItem;
    procedure lsFilesDblClick(Sender: TObject);
    procedure deleteResultClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  tableOfRecords: TtableOfRecords;

implementation

{$R *.dfm}

uses MainForm;

procedure TtableOfRecords.deleteResultClick(Sender: TObject);
begin
  if(lsFiles.ItemIndex <> -1) then
    case MessageBox(Handle, 'Вы действительно хотите удалить файл с результатом?',
    'Попытка удалить рекорд...', MB_YESNO + MB_ICONQUESTION) of
    IDYES:
      begin
          DeleteFile(dir_results + lsFiles.Items[lsFiles.ItemIndex]);
          tableOfRecords.FormShow(tableOfRecords);
      end;
    end;
end;

procedure TtableOfRecords.FormShow(Sender: TObject);
var
  SR: TSearchRec;
  FindRes: Integer;
begin
  lsFiles.Clear;
  mResults.Clear;

  FindRes := FindFirst(dir_results +'*.result', faAnyFile, SR);

  while FindRes = 0 do
  begin
    // если найденный элемент каталог и
    if ((SR.Attr and faDirectory) = faDirectory) and
      // он имеет название "." или "..", тогда:
    ((SR.Name = '.') or (SR.Name = '..')) then
    begin
      FindRes := FindNext(SR); // продолжить поиск
      Continue; // продолжить цикл
    end;
    lsFiles.Items.Add(SR.Name);
    FindRes := FindNext(SR);
  end;

  FindClose(SR);
end;

procedure TtableOfRecords.lsFilesDblClick(Sender: TObject);
begin
  try
    mResults.Clear;
    mResults.Lines.LoadFromFile(dir_results + lsFiles.Items[lsFiles.ItemIndex]);
  except
    showMessage('Ошибка! Файл с результатом отсутвует!');
    tableOfRecords.FormShow(tableOfRecords);
  end;
end;

end.
