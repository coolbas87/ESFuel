unit dMain;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient, System.IniFiles,
  msxml;

type
  TdmMain = class(TDataModule)
    cdsStationsRef: TClientDataSet;
    cdsFuelRef: TClientDataSet;
    cdsParams: TClientDataSet;
    cdsStationsRefstID: TIntegerField;
    cdsStationsRefName: TStringField;
    cdsFuelRefCode: TIntegerField;
    cdsFuelRefName: TStringField;
    cdsParamsstID: TIntegerField;
    cdsParamsstIDName: TStringField;
    cdsEnObj: TClientDataSet;
    cdsEnObjID: TIntegerField;
    cdsEnObjIDEnObj: TIntegerField;
    cdsEnObjCipher: TStringField;
    cdsEnObjName: TStringField;
    cdsEnObjFilename: TStringField;
    dsStationsRef: TDataSource;
    cdsParamsLayout: TIntegerField;
    cdsParamsDataDate: TDateTimeField;
    cdsParamsEmailFrom: TStringField;
    cdsParamsEmailTo: TStringField;
    cdsParamsEmailSubject: TStringField;
    cdsParamsUseSecurityConn: TBooleanField;
    cdsParamsMailSrvHost: TStringField;
    cdsParamsMailSrvPort: TIntegerField;
    cdsParamsMailSrvLogin: TStringField;
    cdsParamsMailSrvPaswd: TStringField;
    cdsStationData: TClientDataSet;
    cdsStationDataCode: TIntegerField;
    cdsStationDataIncome: TIntegerField;
    cdsStationDataCosts: TIntegerField;
    cdsStationDataRemains: TIntegerField;
    cdsStationDataCodeName: TStringField;
    cdsFuelRefIsActive: TBooleanField;
    cdsFuelRefClone: TClientDataSet;
    cdsStationDataIDEnObj: TIntegerField;
    cdsFuelTypes: TClientDataSet;
    dsEnObj: TDataSource;
    cdsFuelTypesCode: TIntegerField;
    cdsFuelTypesIDEnObj: TIntegerField;
    procedure DataModuleCreate(Sender: TObject);
    procedure cdsParamsLayoutChange(Sender: TField);
    procedure cdsParamsDataDateValidate(Sender: TField);
    procedure cdsParamsDataDateChange(Sender: TField);
    procedure cdsParamsUseSecurityConnChange(Sender: TField);
    procedure cdsStationDataNewRecord(DataSet: TDataSet);
    procedure cdsFuelTypesNewRecord(DataSet: TDataSet);
  private
    FDateChanging: Boolean;
    procedure GetFuelList(AXMLDoc: DOMDocument);
    procedure GetStationsList(AXMLDoc: DOMDocument);
    function GetSubNodeValue(ANode: IXMLDOMElement; const ANodeName: String): Variant;
    procedure LoadSettings;
  public
    function GetLayoutDate(const ADateFormat: String): String;
    function GetLayoutFileExt: String;
    function GetLayoutType: String;
    procedure FillStationData;
    procedure SaveSettings(AOnlyStationID: Boolean = False);
    procedure SetDataDate(AValue: TDateTime);
    procedure SynchronizeDataDate;
  end;

var
  dmMain: TdmMain;

implementation

uses
  System.IOUtils, System.Variants, System.DateUtils, fmMain,
  uPalyvoStations;

{$R *.dfm}

procedure TdmMain.cdsFuelTypesNewRecord(DataSet: TDataSet);
begin
  cdsFuelTypesIDEnObj.AsInteger := cdsEnObjIDEnObj.AsInteger;
end;

procedure TdmMain.cdsParamsDataDateChange(Sender: TField);
begin
  SynchronizeDataDate;
end;

procedure TdmMain.cdsParamsDataDateValidate(Sender: TField);
begin
  if (cdsParamsLayout.AsInteger = DailyLayout) and (Sender.AsDateTime >= Trunc(Now)) then
    raise Exception.Create(SDateMoreThenToday);
end;

procedure TdmMain.cdsParamsLayoutChange(Sender: TField);
begin
  cdsParamsDataDate.ReadOnly := False;
  if Sender.AsInteger = DailyLayout then
    cdsParamsDataDate.AsDateTime := Trunc(Yesterday)
  else if Sender.AsInteger = MonthLayout then begin
    cdsParamsDataDate.AsDateTime := Trunc(EndOfTheMonth(IncMonth(Now, -1)));
    cdsParamsDataDate.ReadOnly := True;
  end else
    cdsParamsDataDate.Clear;
end;

procedure TdmMain.cdsParamsUseSecurityConnChange(Sender: TField);
begin
  if Sender.AsBoolean then
    cdsParamsMailSrvPort.AsInteger := SMTPTLSPort
  else
    cdsParamsMailSrvPort.AsInteger := SMTPStandPort;
end;

procedure TdmMain.cdsStationDataNewRecord(DataSet: TDataSet);
begin
  cdsStationDataIDEnObj.AsInteger := cdsEnObjIDEnObj.AsInteger;
end;

procedure TdmMain.DataModuleCreate(Sender: TObject);
var
  XMLDoc: DOMDocument;
begin
  XMLDoc := CoDOMDocument.Create;
  if not TFile.Exists(SStationsFile) then
    raise Exception.CreateFmt(SFileNotFound, [SStationsFile]);
  if not XMLDoc.load(SStationsFile) then
    raise Exception.Create(XMLDoc.parseError.reason);
  GetStationsList(XMLDoc);
  if XMLDoc.load(SPalyvoFile) then
    GetFuelList(XMLDoc);
  cdsParams.CreateDataSet;
  cdsParams.Edit;
  cdsParamsDataDate.AsDateTime := Trunc(Yesterday);
  cdsParamsLayout.AsInteger := DailyLayout;
  LoadSettings;
  cdsParams.CheckBrowseMode;
end;

procedure TdmMain.FillStationData;
begin
  cdsStationData.Close;
  cdsStationData.CreateDataSet;
  cdsStationData.DisableControls;
  try
    cdsEnObj.First;
    while not cdsEnObj.Eof do begin
      cdsFuelTypes.First;
      while not cdsFuelTypes.Eof do begin
        cdsStationData.Insert;
        cdsStationDataCode.AsInteger := cdsFuelTypesCode.AsInteger;
        cdsStationData.CheckBrowseMode;
        cdsFuelTypes.Next;
      end;
      cdsEnObj.Next;
    end;
  finally
    cdsStationData.EnableControls;
  end;
  cdsStationData.MasterSource := dsEnObj;
  cdsStationData.MasterFields := SFldIDEnObj;
  cdsEnObj.First;
  cdsStationData.First;
end;

procedure TdmMain.GetFuelList(AXMLDoc: DOMDocument);
var
  List: IXMLDOMNodeList;
  i: Integer;
  Node: IXMLDOMElement;
begin
  cdsFuelRef.Close;
  cdsFuelRef.CreateDataSet;
  if Assigned(AXMLDoc) then begin
    List := AXMLDoc.selectNodes(SFuelPath);
    for i := 0 to Pred(List.length) do begin
      Node := List.item[i] as IXMLDOMElement;
      cdsFuelRef.Insert;
      cdsFuelRefCode.AsVariant := Node.getAttribute(SCode);
      cdsFuelRefName.AsVariant := Node.getAttribute(SName);
      cdsFuelRefIsActive.AsVariant := Node.getAttribute(SFldIsActive);
      cdsFuelRef.Post;
    end;
    cdsFuelRef.First;
    cdsFuelRefClone.CloneCursor(cdsFuelRef, True, False);
    cdsFuelRefClone.Filter := SFldIsActive;
    cdsFuelRefClone.Filtered := True;
  end;
end;

function TdmMain.GetLayoutDate(const ADateFormat: String): String;
begin
  Result := FormatDateTime(ADateFormat, cdsParamsDataDate.AsDateTime);
end;

function TdmMain.GetLayoutFileExt: String;
begin
  Result := LayoutExt[cdsParamsLayout.AsInteger];
end;

function TdmMain.GetLayoutType: String;
begin
  Result := LayoutType[cdsParamsLayout.AsInteger];
end;

procedure TdmMain.GetStationsList(AXMLDoc: DOMDocument);
var
  StationList, EnObjList, FuelList: IXMLDOMNodeList;
  I, J, K, StationID: Integer;
  Elem, Node, FuelNode: IXMLDOMElement;
begin
  if Assigned(AXMLDoc) then begin
    cdsStationsRef.Close;
    cdsStationsRef.CreateDataSet;
    cdsEnObj.Close;
    cdsEnObj.CreateDataSet;
    cdsEnObj.MasterSource := dsStationsRef;
    cdsEnObj.MasterFields := SFldstID;
    cdsFuelTypes.Close;
    cdsFuelTypes.CreateDataSet;
    StationList := AXMLDoc.selectNodes(SPidprPath);
    if Assigned(StationList) and (StationList.length > 0) then
      for I := 0 to Pred(StationList.length) do begin
        Elem := StationList.item[I] as IXMLDOMElement;
        StationID := Elem.getAttribute(SFldID);
        cdsStationsRef.Insert;
        cdsStationsRefstID.AsVariant := StationID;
        cdsStationsRefName.AsVariant := Elem.getAttribute(SName);
        cdsStationsRef.Post;
        EnObjList := Elem.getElementsByTagName(SEnObj);
        if Assigned(EnObjList) and (EnObjList.length > 0) then
          for J := 0 to Pred(EnObjList.length) do begin
            Node := EnObjList.item[J] as IXMLDOMElement;
            cdsEnObj.Append;
            cdsEnObjID.AsInteger := StationID;
            cdsEnObjIDEnObj.AsVariant := GetSubNodeValue(Node, SFldIDEnObj);
            cdsEnObjCipher.AsVariant := GetSubNodeValue(Node, SFldCipher);
            cdsEnObjName.AsVariant := GetSubNodeValue(Node, SFldEnObjName);
            cdsEnObjFilename.AsVariant := GetSubNodeValue(Node, SFldFilename);
            FuelList := Node.getElementsByTagName(SFuel);
            if Assigned(FuelList) and (FuelList.length > 0) then
              for K := 0 to Pred(FuelList.length) do begin
                FuelNode := FuelList.item[K] as IXMLDOMElement;
                cdsFuelTypes.Append;
                cdsFuelTypesCode.AsVariant := FuelNode.getAttribute(SCode);
                cdsFuelTypes.CheckBrowseMode;
              end;
            cdsEnObj.CheckBrowseMode;
          end;
      end;
  end;
end;

function TdmMain.GetSubNodeValue(ANode: IXMLDOMElement; const ANodeName: String): Variant;
var
  Node: IXMLDOMNode;
begin
  Result := Null;
  if Assigned(ANode) then begin
    Node := ANode.selectSingleNode(ANodeName);
    if Assigned(Node) then
       Result := Node.text;
  end;
end;

procedure TdmMain.LoadSettings;
var
  Settings: TIniFile;
begin
  Settings := TIniFile.Create(IncludeTrailingPathDelimiter(ExtractFileDir(ParamStr(0))) + SSetingsFileName);
  try
    cdsParamsstID.AsInteger := Settings.ReadInteger(SProgramSngsSection, SStationID, 0);
    cdsParamsEmailFrom.AsString := Settings.ReadString(SEmailSngsSection, SEmailFromSngs,
      cdsParamsEmailFrom.AsString);
    cdsParamsEmailTo.AsString := Settings.ReadString(SEmailSngsSection, SEmailToSngs,
      cdsParamsEmailTo.AsString);
    cdsParamsEmailSubject.AsString := Settings.ReadString(SEmailSngsSection, SEmailSubjectSngs,
      cdsParamsEmailSubject.AsString);
    cdsParamsMailSrvHost.AsString := Settings.ReadString(SMailSrvSection, SMailSrvHostSngs,
      cdsParamsMailSrvHost.AsString);
    cdsParamsUseSecurityConn.AsBoolean := Settings.ReadBool(SMailSrvSection, SUseSecurityConnSngs,
      cdsParamsUseSecurityConn.AsBoolean);
    cdsParamsMailSrvPort.AsInteger := Settings.ReadInteger(SMailSrvSection, SMailSrvPortSngs,
      cdsParamsMailSrvPort.AsInteger);
    cdsParamsMailSrvLogin.AsString := Settings.ReadString(SMailSrvSection, SMailSrvLoginSngs,
      cdsParamsMailSrvLogin.AsString);
    cdsParamsMailSrvPaswd.AsString := Settings.ReadString(SMailSrvSection, SMailSrvPaswdSngs,
      cdsParamsMailSrvPaswd.AsString);
  finally
    FreeAndNil(Settings);
  end;
end;

procedure TdmMain.SaveSettings(AOnlyStationID: Boolean);
var
  Settings: TIniFile;
begin
  Settings := TIniFile.Create(IncludeTrailingPathDelimiter(ExtractFileDir(ParamStr(0))) + SSetingsFileName);
  try
    Settings.WriteInteger(SProgramSngsSection, SStationID, cdsParamsstID.AsInteger);
    if not AOnlyStationID then begin
      Settings.WriteString(SEmailSngsSection, SEmailFromSngs, cdsParamsEmailFrom.AsString);
      Settings.WriteString(SEmailSngsSection, SEmailToSngs, cdsParamsEmailTo.AsString);
      Settings.WriteString(SEmailSngsSection, SEmailSubjectSngs, cdsParamsEmailSubject.AsString);
      Settings.WriteString(SMailSrvSection, SMailSrvHostSngs, cdsParamsMailSrvHost.AsString);
      Settings.WriteInteger(SMailSrvSection, SMailSrvPortSngs, cdsParamsMailSrvPort.AsInteger);
      Settings.WriteBool(SMailSrvSection, SUseSecurityConnSngs, cdsParamsUseSecurityConn.AsBoolean);
      Settings.WriteString(SMailSrvSection, SMailSrvLoginSngs, cdsParamsMailSrvLogin.AsString);
      Settings.WriteString(SMailSrvSection, SMailSrvPaswdSngs, cdsParamsMailSrvPaswd.AsString);
    end;
  finally
    FreeAndNil(Settings);
  end;
end;

procedure TdmMain.SetDataDate(AValue: TDateTime);
begin
  // Нет стадартного DB-компонента для редактирования даты, делаем через прцоедуру
  if not FDateChanging then begin
    FDateChanging := True;
    try
      cdsParams.Edit;
      cdsParamsDataDate.AsDateTime := AValue;
      cdsParams.Post;
    finally
      FDateChanging := False;
    end;
  end;
end;

procedure TdmMain.SynchronizeDataDate;
begin
  if not FDateChanging then begin
    FDateChanging := True;
    try
      if Assigned(frmMain) then
        frmMain.dtpDate.DateTime := cdsParamsDataDate.AsDateTime;
    finally
      FDateChanging := False;
    end;
  end;
end;

end.
