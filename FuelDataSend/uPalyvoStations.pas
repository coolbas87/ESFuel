unit uPalyvoStations;

interface

uses
  Winapi.Windows, System.SysUtils, Vcl.Forms, Vcl.Graphics;

resourcestring
  SDateMoreThenToday = '���� �� ���� ���� ����� �� ��������';
  SCloseApp = '������� ��������?';
  SCantCreateDirectory = '�� ������� �������� ����� ''%s''. ������� ����������� ���� ��� ������ � �����';
  SFileNotSended = '���� ''%s'' �� �������';

const
  SStationsFile = 'Stations.xml';
  SPalyvoFile = 'Palyvo.xml';
  SPidprPath = '//root//Org';
  SFuelPath = '//root//Fuel';
  SEnObj = 'EnObj';
  SFldIDEnObj = 'IDEnObj';
  SFldCipher = 'Cipher';
  SFldEnObjName = 'EnObjName';
  SFldCoal = 'Coal';
  SFldMasut = 'Masut';
  SFldGas = 'Gas';
  SFldOtherOrg = 'OtherOrg';
  SFldFilename = 'Filename';
  SFldstID = 'stID';
  SName = 'Name';
  SFldID = 'ID';
  SCode = 'Code';
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

  DailyLayout = 0;
  MonthLayout = 1;
  LayoutType: array[DailyLayout..MonthLayout] of String = ('001', '102');
  LayoutExt: array[DailyLayout..MonthLayout] of String = ('.txt', '.102');
  CtrlColors: array[Boolean] of TColor = (clInfoBk, clWindow);

  SBaseFrameNameFmt = '%s%d';

  IncomeValueIndex = 1;
  CostsValueIndex = 2;
  RemainsValueIndex = 3;
  OtherOrgsValueIndex = 4;

  SMTPStandPort = 25;
  SMTPTLSPort = 465;

function GetUniqueMesID(const AEmail: String): String;
function MsgBox(const AText, ACaption: String; AFlags: Integer): Integer;

implementation

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

end.
