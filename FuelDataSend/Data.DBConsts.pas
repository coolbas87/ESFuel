{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2010 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Data.DBConsts;

interface

resourcestring
  SInvalidFieldSize = '������� ����� ����';
  SInvalidFieldKind = '������� FieldKind';
  SInvalidFieldRegistration = '������ ��������� ����';
  SUnknownFieldType = '��� ���� "%s" ��������';
  SFieldNameMissing = '³����� ��''� ����';
  SDuplicateFieldName = '������� ���� ���� "%s"';
  SFieldNotFound = '���� "%s" �� ��������';
  SFieldAccessError = '�� ������� �������� ������ �� ���� "%s" �� ���� %s';
  SFieldValueError = '������ �������� ��� ���� "%s"';
  SFieldRangeError = '"%g" - ������ �������� ��� ���� "%s". ���������� ������� - �� %g �� %g';
  SBcdFieldRangeError = '"%s" - ������ �������� ��� ���� "%s". ���������� ������� - �� %s �� %s';
  SInvalidIntegerValue = '"%s" - ������ ���� �������� ��� ���� "%s"';
  SInvalidBoolValue = '"%s" - ������ ������ �������� ��� ���� "%s"';
  SInvalidFloatValue = '"%s" - ������ ������� �������� ��� ���� "%s"';
  SFieldTypeMismatch = '������� ��� ���� "%s", ���������: %s, �����������: %s';
  SFieldSizeMismatch = '������� ����� ��� ���� "%s", ���������: %d, �����������: %d';
  SInvalidVarByteArray = '������� ��������� ��� ��� ����� ���� "%s"';
  SFieldOutOfRange = '�������� ���� "%s" ������ �� ���';
//  SBCDOverflow = '(������������)';
  SCantAdjustPrecision = '������� ������������ ������ BCD';
  SFieldRequired = '���� "%s" ������� ���� ��������';
  SDataSetMissing = '���� "%s" �� �� ������ ����� (dataset)';
  SInvalidCalcType = '���� "%s" �� ���� ���� ������������ ��� ��������� �����';
  SFieldReadOnly = '���� "%s" �� ���� ���� ������';
  SFieldIndexError = '������ ���� ������ �� ���';
  SNoFieldIndexes = '���� ��������� �������';
  SNotIndexField = '���� "%s" �� ����������� � �� ���� ���� ������';
  SIndexFieldMissing = '�� ������� �������� ������ �� ���������� ���� "%s"';
  SDuplicateIndexName = '������� ���� ������� "%s"';
  SNoIndexForFields = '���� ������� ��� ���� "%s"';
  SIndexNotFound = '������ "%s" �� ��������';
  SDBDuplicateName = '������� ����� "%s" � %s';
  SCircularDataLink = '������ ��''���� ����� �� ��������';
  SLookupInfoError = '���������� ������ (lookup) ��� ���� "%s" - �������';
  SNewLookupFieldCaption = '���� �������� (lookup) ����';
  SDataSourceChange = 'DataSource �� ���� ���� �������';
  SNoNestedMasterSource = '������� ������� �� ������ ���� MasterSource';
  SDataSetOpen = '�� ������� �������� �� �������� ��� ��������� ������ ����� (dataset)';
  SNotEditing = '���� ����� (Dataset) �� � ����� ����������� ��� �������';
  SDataSetClosed = '�� ������� �������� �� �������� ��� ��������� ������ ����� (dataset)';
  SDataSetEmpty = '�� ������� �������� �� �������� ��� ���������� ������ ����� (dataset)';
  SDataSetReadOnly = '�� ������������ �������� ���� ����� "����� ��� �������" (read-only dataset)';
  SNestedDataSetClass = '��������� ���� ����� �������� ��������������� �� %s';
  SExprTermination = '��������� ������� ���������� ���������';
  SExprNameError = '����������� ��''� ����';
  SExprStringError = '����������� �������� ���������';
  SExprInvalidChar = '������� ������ � ����� �������: "%s"';
  SExprNoLParen = '��������� "(", ��� �������� %s';
  SExprNoRParen = '��������� ")", ��� �������� %s';
  SExprNoRParenOrComma = '��������� ")" ��� ",", ��� �������� %s';
  SExprExpected = '��������� �����, ��� �������� %s';
  SExprBadField = '���� "%s" �� ���� ����������������� � ����� �������';
  SExprBadNullTest = 'NULL ��������� ���� � "=" �� "<>"';
  SExprRangeError = '��������� ������ �� ���';
  SExprNotBoolean = '���� "%s" - �� �������� ����';
  SExprIncorrect = '���������� ����������� ����� �������';
  SExprNothing = '�����';
  SExprTypeMis = '����������� ���� � �����';
  SExprBadScope = '� �������� �� ����� �������� �������� �������� � ���������� ����';
  SExprNoArith = '���������� � ����� ������� �� �����������';
  SExprNotAgg = '����� �� � ����������';
  SExprBadConst = '��������� �������� ���� %s';
  SExprNoAggFilter = '�������� ������ �� ������������ � ��������';
  SExprEmptyInList = '������ IN ������� �� ���� ���� ������';
  SInvalidKeywordUse = '������ ������������ ��������� �����';
  STextFalse = 'False';
  STextTrue = 'True';
  SParameterNotFound = '�������� "%s" �� ��������';
  SInvalidVersion = '��������� ����������� ��������� ����''����';
  SParamTooBig = '�������� "%s", �� ����� �������� ��� ����� %d ����';
  SBadFieldType = '��� ���� "%s" �� �����������';
  SAggActive = '���������� �� ���� ���� ������, ���� aggregate �������';
  SProviderSQLNotSupported = 'SQL �� �����������: %s';
  SProviderExecuteNotSupported = '��������� �� �����������: %s';
  SExprNoAggOnCalcs = '���� "%s" �������� ���� ��� ������������ ���� � aggregate, �������������� internalcalc';
  SRecordChanged = '����� ������� ����� ������������';
  SDataSetUnidirectional = '�������� �� ����������� �� ���������������� ����� ����� (dataset)';
  SUnassignedVar = 'Unassigned �������� �������';
  SRecordNotFound = '����� �� ��������';
  SFileNameBlank = '���������� FileName �� ���� ���� ���������';
  SFieldNameTooLarge = '��''� ���� %s ����������� %d �������';

{ For FMTBcd }

  SBcdOverflow = '������������ BCD';
  SInvalidBcdValue = '%s - ������ BCD ��������';
  SInvalidFormatType = '������� ��� ������� ��� BCD';

{ For SqlTimSt }

  SCouldNotParseTimeStamp = '�� ������� �������� SQL TimeStamp ������';
  SInvalidSqlTimeStamp = '����� �������� SQL ����/����';
  SCalendarTimeCannotBeRepresented = '��������� ���������� ����������� ���';

  SDeleteRecordQuestion = '�������� �����?';
  SDeleteMultipleRecordsQuestion = '�������� �� ����� ������?';
  STooManyColumns = '������� (Grid) �� ���� ������ ���� 256 �������';

  { For reconcile error }
  SSkip = '����������';
  SAbort = '���������';
  SMerge = '��''�����';
  SCorrect = 'Correct';
  SCancel  = '³����';
  SRefresh = '��������';
  SModified = '������';
  SInserted = '���������';
  SDeleted  = '��������';
  SCaption = '������� ������� - %s';
  SUnchanged = '<�� ������>';  
  SBinary = '(��������)';                              
  SAdt = '(ADT)';   
  SArray = '(�����)'; 
  SFieldName = '��''� ����'; 
  SOriginal = '������� ��������'; 
  SConflict = '����������� ��������';  
  SValue = ' ��������';   
  SNoData = '<���� ������>';
  SNew = '���.';    

implementation

end.
