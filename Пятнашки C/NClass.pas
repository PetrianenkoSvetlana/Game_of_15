unit NClass;
interface

uses
  StdCtrls, Dialogs, SysUtils, Controls, ExtCtrls, Windows, Forms;

type
    TNClass = class(TButton)
    private
     procedure obmen(ColumnVisible, RowVisible, ColumnNotVisible, RowNotVisible: byte);
    public
     procedure ButtonClick(Sender: TObject);
     procedure shuffle(Row, Column: byte);
    end;

    var
    masText:array of array of byte;
    Buttons: array of array of TNClass;
    numberRow, numberColumn: byte;
    start: boolean;

implementation

uses uMainForm, uIniFile, uWin;

////////////////////////////////////////////////////////
procedure OnMenuStart;
var
	i, j, k: integer;
	direction: integer;
  Times: integer;
  VoidX: integer;
  VoidY: integer;
  Void: byte;
begin
  VoidX := numberRow - 1;
  VoidY := numberColumn - 1;
  Void := masText[VoidX, VoidY];
  //************************/
  //* Перемешивание поля
  //************************/
	Times := numberRow * 100;
  for k := 0 to  Times do
  begin
    // Направление движения
    direction := random(4);

    if(direction = 0) then // Вверх
    begin
      // Кнопка сверху существует
      if(VoidX - 1 >= 0) then
      begin
        // Поднять пустышку вверх
        masText[VoidX, VoidY] := masText[VoidX - 1, VoidY];
        dec(VoidX);
      end
      else
      begin
        // Поднять весь столбец вверх
        for i := 0 to numberRow - 2 do
          masText[i, VoidY] := masText[i + 1, VoidY];
        VoidX := numberRow - 1;
      end
		end
		else if(direction = 1) then// Вниз
    begin
      // Кнопка снизу существует
      if(VoidX + 1 < numberRow) then
      begin
        masText[VoidX, VoidY] := masText[VoidX + 1, VoidY];
        Inc(VoidX);
      end
      else
      begin
        for i := numberRow - 1 downto 1 do
          masText[i, VoidY] := masText[i - 1, VoidY];
        VoidX := 0;
      end
    end
    else if(direction = 2) then// Влево
    begin
      // Кнопка слева существует
      if(VoidY - 1 >= 0) then
      begin
        masText[VoidX, VoidY] := masText[VoidX, VoidY - 1];
        dec(VoidY);
      end
      else
      begin
        for j := 0 to numberColumn - 2 do
          masText[VoidX, j] := masText[VoidX, j + 1];
        VoidY := numberColumn - 1;
      end
    end
    else // Вправо
    begin
      // Кнопка справа существует
      if(VoidY + 1 < numberColumn) then
      begin
        masText[VoidX, VoidY] := masText[VoidX, VoidY + 1];
        Inc(VoidY);
      end
      else
      begin
        for j := numberColumn - 1 downto 1 do
          masText[VoidX, j] := masText[VoidX, j - 1];
        VoidY := 0;
      end
    end;
    // Новая позиция "пустышки"
    masText[VoidX, VoidY] := Void;
  end;


end;

//////////////////////////////////////////////////////////

procedure TNClass.shuffle(Row, Column: byte);
var
  indexMasTextRow, indexMasTextCol, rn: byte;
  flag:set of Byte;
begin
  { Задаём значения размера полей }
  numberRow := Row;
  numberColumn := Column;
  { Создаём массивы }
  SetLength(masText, numberRow, numberColumn);
  SetLength(Buttons, numberRow, numberColumn);
  { Переменная отвечающая за старт времени}
  start := false;

  for indexMasTextRow := 0 to numberRow - 1 do
    for indexMasTextCol := 0 to numberColumn - 1 do
      masText[indexMasTextRow, indexMasTextCol] := indexMasTextRow * numberColumn + indexMasTextCol + 1;
  OnMenuStart;
end;



procedure TNClass.obmen(ColumnVisible, RowVisible, ColumnNotVisible, RowNotVisible: byte);
var
  indexRow, indexColumn: byte;
  bMessage: boolean;
  tempButton: TNClass;
  tempControl: TControl;
Begin

  if not start then
  begin
    if beginnerParam then
    begin
      inc(beginner.stat[0]);
    end
    else if amateurParam then
    begin
      inc(amateur.stat[0]);
    end
    else if professionalParam then
    begin
      inc(professional.stat[0]);
    end;
    start := true;
  end;
  { Меняем местами кнопки в сетке}
  tempControl := fMainForm.GridPanel2.ControlCollection.ControlItems[ColumnVisible, RowVisible].Control;
  fMainForm.GridPanel2.ControlCollection.ControlItems[ColumnVisible, RowVisible].Control := fMainForm.GridPanel2.ControlCollection.ControlItems[ColumnNotVisible, RowNotVisible].Control;
  fMainForm.GridPanel2.ControlCollection.ControlItems[ColumnNotVisible, RowNotVisible].Control := tempControl;
  { Меняем местами массив кнопок }
  tempButton := Buttons[RowVisible, ColumnVisible];
  Buttons[RowVisible, ColumnVisible] := Buttons[RowNotVisible, ColumnNotVisible];
  Buttons[RowNotVisible, ColumnNotVisible] := tempButton;

  { Проверяем выиграл ли пользователь }
  bMessage := true;
  for indexRow := 0 to numberRow - 1 do
    for indexColumn := 0 to numberColumn - 1 do
      if StrToInt((fMainForm.GridPanel2.ControlCollection.ControlItems[indexColumn, indexRow].Control as TNClass).Caption) <> indexRow * numberColumn + indexColumn + 1 then
      begin
        //ShowMessage((fMainForm.GridPanel2.ControlCollection.ControlItems[indexColumn, indexRow].Control as TNClass).Caption + ' ' + IntToStr(indexColumn) + ' ' + IntToStr(indexRow) + ' ' + IntToStr(indexRow + numberColumn * indexColumn + 1));
        bMessage := false;
        break;
      end;
      //fMainForm.MediaPlayer1.Play;
  if soundSave then
      Windows.Beep(400,50);
  { Если выиграл, то выводим сообщение }
  if bMessage then
  begin
    fMainForm.Timer1.Enabled := false;
    if beginnerParam then
    begin

    end
    else if amateurParam then
    begin

    end
    else if professionalParam then
    begin
      
    end;
    start := false;
    Application.CreateForm(TfWin, fWin);
    fWin.ShowModal;
  end;
  //fMainForm.MediaPlayer1.Stop;

End;

procedure TNClass.ButtonClick(Sender: TObject);
var
  RowVisible, ColumnVisible, RowNotVisible, ColumnNotVisible: integer;
  indexColumn, indexRow : Integer;
Begin
  fMainForm.Timer1.Enabled := true;

  { Определение координат нажатой кнопки }
  for indexColumn := 0 to fMainForm.GridPanel2.ColumnCollection.Count - 1 do
    for indexRow := 0 to fMainForm.GridPanel2.RowCollection.Count - 1 do
      if fMainForm.GridPanel2.ControlCollection.ControlItems[indexColumn, indexRow].Control = (Sender as TNClass) then
      begin
        RowVisible := indexRow;
        ColumnVisible := indexColumn;
        break;
      end;

  { Координаты скрытой кнопки }
  for indexColumn := 0 to fMainForm.GridPanel2.ColumnCollection.Count - 1 do
    for indexRow := 0 to fMainForm.GridPanel2.RowCollection.Count - 1 do
      if Buttons[indexRow, indexColumn].Visible=False  then
      begin
        RowNotVisible := indexRow;
        ColumnNotVisible := indexColumn;
        break;
      end;

  { Если соседи по столбцу, то обмен }
  If (ColumnNotVisible = ColumnVisible) and (abs(RowNotVisible - RowVisible) = 1) Then
    obmen(ColumnVisible, RowVisible, ColumnNotVisible, RowNotVisible);

  { Если соседи по строке, то обмен }
  If (RowNotVisible = RowVisible) and (abs(ColumnVisible - ColumnNotVisible) = 1) Then
   obmen(ColumnVisible, RowVisible, ColumnNotVisible, RowNotVisible);

End;

end.
