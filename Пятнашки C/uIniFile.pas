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

    { ������� Top-5 ���� }
    RTop = record
      time: Cardinal;
      date: TDateTime;
    end;

    { ������� ��������� }
    RTotal = record
      win: Cardinal;
      lose: Cardinal;
    end;

    { ������� ��������� }
    RComplexity = record
      stat: array [0..3] of Cardinal;// = (
      //0,    //��������� ���
      //0,    //��������
      //0,    //��������� ������
      //0)    //���������� ������
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
  iniFile.WriteInteger(inscription, '��������� ���', complexity.stat[0]);
  iniFile.WriteInteger(inscription, '��������', complexity.stat[1]);
  iniFile.WriteInteger(inscription, '��������� ������Max', complexity.stat[2]);
  iniFile.WriteInteger(inscription, '���������� ������Max', complexity.stat[3]);
  iniFile.WriteInteger(inscription, '��������� ������', complexity.total.win);
  iniFile.WriteInteger(inscription, '���������� ������', complexity.total.lose);
  iniFile.WriteBool(inscription, '����������', complexity.save);
  if complexity.save then
  begin
    iniFile.WriteInteger(inscription, '����� �� ������', numberColumn);
    iniFile.WriteInteger(inscription, '����� �� ������', numberRow);
    for indexRow := 0 to numberRow - 1 do
      for indexColumn := 0 to numberColumn - 1 do
      begin
        iniFile.WriteInteger(inscription, 'ArraySave[' + IntToStr(indexRow) + ', ' + IntToStr(indexColumn) + ']', arraySave[indexRow, indexColumn]);
      end;
    iniFile.WriteInteger('����� ������', '�����', timeSave);
  end;
  for index := 0 to 4 do
   begin
     iniFile.WriteInteger(inscription, IntToStr(index + 1) + '����������', complexity.top[index].time);
     iniFile.WriteDate(inscription, IntToStr(index + 1) + '���������', complexity.top[index].date);
   end;
end;

procedure ReadStatisticComplexity(iniFile: TIniFile; inscription: string; var complexity: RComplexity);
var
  index: byte;
  indexRow, indexColumn: Cardinal;
begin
  complexity.stat[0] := iniFile.ReadInteger(inscription, '��������� ���', 0);
  complexity.stat[1] := iniFile.ReadInteger(inscription, '��������', 0);
  complexity.stat[2] := iniFile.ReadInteger(inscription, '��������� ������Max', 0);
  complexity.stat[3] := iniFile.ReadInteger(inscription, '���������� ������Max', 0);
  complexity.total.win := iniFile.ReadInteger(inscription, '��������� ������', 0);
  complexity.total.lose := iniFile.ReadInteger(inscription, '���������� ������', 0);
  complexity.save := iniFile.ReadBool(inscription, '����������', false);
  if complexity.save then
  begin
    //complexity.save := false;
    numberColumn := iniFile.ReadInteger(inscription, '����� �� ������', 0);
    numberRow := iniFile.ReadInteger(inscription, '����� �� ������', 0);
    SetLength(arraySave, numberRow, numberColumn);
    for indexRow := 0 to numberRow - 1 do
      for indexColumn := 0 to numberColumn - 1 do
      begin
        arraySave[indexRow, indexColumn] := iniFile.ReadInteger(inscription, 'ArraySave[' + IntToStr(indexRow) + ', ' + IntToStr(indexColumn) + ']', 0);
      end;
    timeSave := iniFile.ReadInteger('����� ������', '�����', 0);
  end;
  for index := 0 to 4 do
  begin
   complexity.top[index].time := iniFile.ReadInteger(inscription, IntToStr(index + 1) + '����������', 0);
   complexity.top[index].date := iniFile.ReadDate(inscription, IntToStr(index + 1) + '���������', 0);
  end;
end;

procedure TIniFile2.WriteStatistic;
// ������ � iniFile
var
   iniFile: TIniFile;
begin
   { ������ ������ TIniFile }
   //if not FileExists('Statistic.ini') then
    iniFile := TIniFile.Create(ExtractFilePath(Application.ExeName) + '\Statistic.ini');

   { ���������� �������� }
   WriteStatisticComplexity(iniFile, 'Beginner', beginner);
   WriteStatisticComplexity(iniFile, 'Amateur', amateur);
   WriteStatisticComplexity(iniFile, 'Professional', professional);

   iniFile.Free;
end;


procedure TIniFile2.ReadStatistic;
// ������ �� iniFile
var
  iniFile: TIniFile;
  index: byte;
begin
  { ���� ���� ����, �� ��������� }
  if FileExists('Statistic.ini') then
  begin
    iniFile := TIniFile.Create(ExtractFilePath(Application.ExeName) + '\Statistic.ini');
   { ���������� �������� }
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
  iniFile.WriteBool('Beginner', '�������', beginnerParam);
  iniFile.WriteBool('Amateur', '�������', amateurParam);
  iniFile.WriteBool('Professional', '�������', professionalParam);
  iniFile.WriteBool('Other', '�������', otherParam);
  iniFile.WriteInteger('Other', '������', otherParamEditW);
  iniFile.WriteInteger('Other', '������', otherParamEditH);
  iniFile.WriteBool('����� ������', '�������� �������������', soundSave);
  iniFile.WriteBool('����� ������', '������ ���������� ���������� ����', continueGameSave);
  iniFile.WriteBool('����� ������', '������ ��������� ���� ��� ������', saveGameSave);
  iniFile.WriteString('����� ������', '��������', imageFon);

  iniFile.Free;
end;

procedure TIniFile2.ReadParameters;
var
   iniFile: TIniFile;
begin
  iniFile := TIniFile.Create(ExtractFilePath(Application.ExeName) + '\Parameters.ini');
  beginnerParam := iniFile.ReadBool('Beginner', '�������', true);
  amateurParam := iniFile.ReadBool('Amateur', '�������', true);
  professionalParam := iniFile.ReadBool('Professional', '�������', true);
  otherParam := iniFile.ReadBool('Other', '�������', true);
  otherParamEditW := iniFile.ReadInteger('Other', '������', 2);
  otherParamEditH := iniFile.ReadInteger('Other', '������', 2);
  soundSave := iniFile.ReadBool('����� ������', '�������� �������������', false);
  continueGameSave := iniFile.ReadBool('����� ������', '������ ���������� ���������� ����', false);
  saveGameSave := iniFile.ReadBool('����� ������', '������ ��������� ���� ��� ������', false);
  imageFon := iniFile.ReadString('����� ������', '��������', '��� 1');
  iniFile.Free;
end;
end.
