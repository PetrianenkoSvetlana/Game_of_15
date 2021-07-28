unit uIniFile;

interface

uses
  IniFiles, Windows, SysUtils, Forms;

type
    TIniFile2 = class
    public
     procedure WriteStatistic;
     procedure ReadStatistic;
     procedure WriteParameters;
     procedure ReadParameters;
    end;

    { Таблица Top-5 счёт }
    RTop = record
      time: Cardinal;
      date: TDateTime;
    end;

    { Таблица Результат }
    RTotal = record
      win: Cardinal;
      lose: Cardinal;
    end;

    { Таблица сложности }
    RComplexity = record
      stat: array [0..3] of Cardinal;// = (
      //0,    //Проведено игр
      //0,    //Выиграно
      //0,    //Выигрышей подряд
      //0)    //Проигрышей подряд
      total: RTotal;
      top: array [0..4] of RTop;
      count: integer;
      save: boolean;
      //time: Cardinal;
    end;

var
  beginner: RComplexity;
  amateur: RComplexity;
  professional: RComplexity;
  /////////////////////////////////
  beginnerParam: boolean = true;
  amateurParam: boolean = false;
  professionalParam: boolean = false;
  otherParam: boolean = false;
  otherParamEditW: integer = 2;
  otherParamEditH: integer = 2;
  //////////////////////////////////
  arraySave: array of array of Cardinal;
  timeSave: Cardinal;
  soundSave, continueGameSave,saveGameSave: boolean;
  imageFon: string;
implementation
uses
  UMainForm;
procedure WriteStatisticComplexity(iniFile: TIniFile; inscription: string; complexity: RComplexity);
var
  index: byte;
  indexRow, indexColumn: Cardinal;
begin
  iniFile.WriteInteger(inscription, 'Проведено игр', complexity.stat[0]);
  iniFile.WriteInteger(inscription, 'Выиграно', complexity.stat[1]);
  iniFile.WriteInteger(inscription, 'Выигрышей подрядMax', complexity.stat[2]);
  iniFile.WriteInteger(inscription, 'Проигрышей подрядMax', complexity.stat[3]);
  iniFile.WriteInteger(inscription, 'Выигрышей подряд', complexity.total.win);
  iniFile.WriteInteger(inscription, 'Проигрышей подряд', complexity.total.lose);
  iniFile.WriteBool(inscription, 'Сохранение', complexity.save);
  if complexity.save then
  begin
    iniFile.WriteInteger(inscription, 'Длина по ширине', numberColumn);
    iniFile.WriteInteger(inscription, 'Длина по высоте', numberRow);
    for indexRow := 0 to numberRow - 1 do
      for indexColumn := 0 to numberColumn - 1 do
      begin
        iniFile.WriteInteger(inscription, 'ArraySave[' + IntToStr(indexRow) + ', ' + IntToStr(indexColumn) + ']', arraySave[indexRow, indexColumn]);
      end;
    iniFile.WriteInteger('Общие данные', 'Время', timeSave);
  end;
  for index := 0 to 4 do
   begin
     iniFile.WriteInteger(inscription, IntToStr(index + 1) + 'местоВремя', complexity.top[index].time);
     iniFile.WriteDate(inscription, IntToStr(index + 1) + 'местоДата', complexity.top[index].date);
   end;
end;

procedure ReadStatisticComplexity(iniFile: TIniFile; inscription: string; var complexity: RComplexity);
var
  index: byte;
  indexRow, indexColumn: Cardinal;
begin
  complexity.stat[0] := iniFile.ReadInteger(inscription, 'Проведено игр', 0);
  complexity.stat[1] := iniFile.ReadInteger(inscription, 'Выиграно', 0);
  complexity.stat[2] := iniFile.ReadInteger(inscription, 'Выигрышей подрядMax', 0);
  complexity.stat[3] := iniFile.ReadInteger(inscription, 'Проигрышей подрядMax', 0);
  complexity.total.win := iniFile.ReadInteger(inscription, 'Выигрышей подряд', 0);
  complexity.total.lose := iniFile.ReadInteger(inscription, 'Проигрышей подряд', 0);
  complexity.save := iniFile.ReadBool(inscription, 'Сохранение', false);
  if complexity.save then
  begin
    //complexity.save := false;
    numberColumn := iniFile.ReadInteger(inscription, 'Длина по ширине', 0);
    numberRow := iniFile.ReadInteger(inscription, 'Длина по высоте', 0);
    SetLength(arraySave, numberRow, numberColumn);
    for indexRow := 0 to numberRow - 1 do
      for indexColumn := 0 to numberColumn - 1 do
      begin
        arraySave[indexRow, indexColumn] := iniFile.ReadInteger(inscription, 'ArraySave[' + IntToStr(indexRow) + ', ' + IntToStr(indexColumn) + ']', 0);
      end;
    timeSave := iniFile.ReadInteger('Общие данные', 'Время', 0);
  end;
  for index := 0 to 4 do
  begin
   complexity.top[index].time := iniFile.ReadInteger(inscription, IntToStr(index + 1) + 'местоВремя', 0);
   complexity.top[index].date := iniFile.ReadDate(inscription, IntToStr(index + 1) + 'местоДата', 0);
  end;
end;

procedure TIniFile2.WriteStatistic;
// Запись в iniFile
var
   iniFile: TIniFile;
begin
   { создаём объект TIniFile }
   //if not FileExists('Statistic.ini') then
    iniFile := TIniFile.Create(ExtractFilePath(Application.ExeName) + '\Statistic.ini');

   { записываем значение }
   WriteStatisticComplexity(iniFile, 'Beginner', beginner);
   WriteStatisticComplexity(iniFile, 'Amateur', amateur);
   WriteStatisticComplexity(iniFile, 'Professional', professional);

   iniFile.Free;
end;


procedure TIniFile2.ReadStatistic;
// Чтение из iniFile
var
  iniFile: TIniFile;
  index: byte;
begin
  { Если файл есть, то считываем }
  if FileExists('Statistic.ini') then
  begin
    iniFile := TIniFile.Create(ExtractFilePath(Application.ExeName) + '\Statistic.ini');
   { записываем значение }
    ReadStatisticComplexity(iniFile, 'Beginner', beginner);
    ReadStatisticComplexity(iniFile, 'Amateur', amateur);
    ReadStatisticComplexity(iniFile, 'Professional', professional);


  end
  else
    iniFile := TIniFile.Create(ExtractFilePath(Application.ExeName) + '\Statistic.ini');

  iniFile.Free;
end;

procedure TIniFile2.WriteParameters;
var
   iniFile: TIniFile;
begin
  iniFile := TIniFile.Create(ExtractFilePath(Application.ExeName) + '\Parameters.ini');
  iniFile.WriteBool('Beginner', 'Выбрано', beginnerParam);
  iniFile.WriteBool('Amateur', 'Выбрано', amateurParam);
  iniFile.WriteBool('Professional', 'Выбрано', professionalParam);
  iniFile.WriteBool('Other', 'Выбрано', otherParam);
  iniFile.WriteInteger('Other', 'Высота', otherParamEditW);
  iniFile.WriteInteger('Other', 'Ширина', otherParamEditH);
  iniFile.WriteBool('Общие данные', 'Звуковое сопровождение', soundSave);
  iniFile.WriteBool('Общие данные', 'Всегда продолжать сохраненую игру', continueGameSave);
  iniFile.WriteBool('Общие данные', 'Всегда сохранять игру при выходе', saveGameSave);
  iniFile.WriteString('Общие данные', 'Картинка', imageFon);

  iniFile.Free;
end;

procedure TIniFile2.ReadParameters;
var
   iniFile: TIniFile;
begin
  iniFile := TIniFile.Create(ExtractFilePath(Application.ExeName) + '\Parameters.ini');
  beginnerParam := iniFile.ReadBool('Beginner', 'Выбрано', true);
  amateurParam := iniFile.ReadBool('Amateur', 'Выбрано', true);
  professionalParam := iniFile.ReadBool('Professional', 'Выбрано', true);
  otherParam := iniFile.ReadBool('Other', 'Выбрано', true);
  otherParamEditW := iniFile.ReadInteger('Other', 'Высота', 2);
  otherParamEditH := iniFile.ReadInteger('Other', 'Ширина', 2);
  soundSave := iniFile.ReadBool('Общие данные', 'Звуковое сопровождение', false);
  continueGameSave := iniFile.ReadBool('Общие данные', 'Всегда продолжать сохраненую игру', false);
  saveGameSave := iniFile.ReadBool('Общие данные', 'Всегда сохранять игру при выходе', false);
  imageFon := iniFile.ReadString('Общие данные', 'Картинка', 'Фон 1');
  iniFile.Free;
end;
end.
