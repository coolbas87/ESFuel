unit uPalyvoStations;

interface

uses
  Winapi.Windows, System.SysUtils, Data.DB, Vcl.Forms, Vcl.Graphics;

resourcestring
  SDateMoreThenToday = '���� �� ���� ���� ����� �� ��������';
  SCloseApp = '������� ��������?';
  SCantCreateDirectory = '�� ������� �������� ����� ''%s''. ������� ����������� ���� ��� ������ � �����';
  SFileNotSended = '���� ''%s'' �� �������' + sLineBreak + '�������: %s';
  SFileNotFound = '���� ''%s'' �� ��������';
  SFuelPresent = '��� ������ "%s" ��� ���� � �������';
  SFuelForStationPresent = '��� ������� "%s" ��� ���� ��� ������ "%s"';

const
  SStationsFile = 'Stations.xml';
  SPalyvoFile = 'Palyvo.xml';
  SPidprPath = '//root//Org';
  SFuelPath = '//root//Fuel';
  SEnObj = 'EnObj';
  SFldIDEnObj = 'IDEnObj';
  SFldCipher = 'Cipher';
  SFldEnObjName = 'EnObjName';
  SFldFilename = 'Filename';
  SFldstID = 'stID';
  SFldIsActive = 'IsActive';
  SName = 'Name';
  SFldID = 'ID';
  SFldCode = 'Code';
  SFmtLayoutDate = 'ddmmyy';
  SDateFmtLayoutFname = 'ddmm';
  SFmtLayoutHeader = '((//%s:%s:%s:++';
  SLayoutEnd = '==))';
  SSendedFilesFolder = 'SendedFiles';
  SMsgIDHeaderFmt = 'Message-ID: %s';
  SLayoutLineFmt = '(%.3d%d):%d:';
  SMsgIDFmt = '%d.%s@%s';
  SMsgIDDateFmt = 'yyyymmddhhnnss';
  SConcatFmt = '%s%s';
  SSetingsFileName = 'Setings.ini';
  SStationID = 'StationID';
  SEmailFromSngs = 'EmailFrom';
  SEmailToSngs = 'EmailTo';
  SEmailSubjectSngs = 'EmailSubject';
  SUseSecurityConnSngs = 'UseSecurityConn';
  SMailSrvHostSngs = 'MailSrvHost';
  SMailSrvPortSngs = 'MailSrvPort';
  SMailSrvLoginSngs = 'MailSrvLogin';
  SMailSrvPaswdSngs = 'MailSrvPaswd';
  SProgramSngsSection = 'ProgramSettings';
  SEmailSngsSection = 'EmailSettings';
  SMailSrvSection = 'MailServerSettings';
  SFuel = 'Fuel';
  ItemDelimiter = ';';
  SExtViewCheckDoublets = 'Code;IDEnObj';

  DailyLayout = 0;
  MonthLayout = 1;
  LayoutType: array[DailyLayout..MonthLayout] of String = ('001', '102');
  LayoutExt: array[DailyLayout..MonthLayout] of String = ('.txt', '.102');

  IncomeValueIndex = 1;
  CostsValueIndex = 2;
  RemainsValueIndex = 3;

  SMTPStandPort = 25;
  SMTPTLSPort = 465;

function GetFieldsValues(ADataSet: TDataSet; const AFieldNames: String): Variant;
function GetUniqueMesID(const AEmail: String): String;
function MsgBox(const AText, ACaption: String; AFlags: Integer): Integer;

implementation

uses
  System.Variants, System.Generics.Collections;

function GetUniqueMesID(const AEmail: String): String;
var
  SenderServer: String;
begin
  Randomize;
  SenderServer := Copy(AEmail, Pos('@', AEmail), Length(AEmail));
  Result := Format(SMsgIDFmt, [Random(999999999), FormatDateTime(SMsgIDDateFmt, Now),
    SenderServer]);
end;

function MsgBox(const AText, ACaption: String; AFlags: Integer): Integer;
begin
  Result := MessageBox(Application.Handle, PWideChar(AText), PWideChar(ACaption), AFlags);
end;

function GetFieldsValues(ADataSet: TDataSet; const AFieldNames: String): Variant;
var
  I: Integer;
  Fields: TList<TField>;
begin
  if AFieldNames.Contains(ItemDelimiter) then begin
    Fields := TList<TField>.Create;
    try
      ADataSet.GetFieldList(Fields, AFieldNames);
      Result := VarArrayCreate([0, Fields.Count - 1], varVariant);
      for I := 0 to Pred(Fields.Count) do
        Result[I] := Fields[I].AsVariant;
    finally
      FreeAndNil(Fields);
    end;
  end else
    Result := ADataSet.FieldByName(AFieldNames).AsVariant;
end;

end.
