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
    cdsEnObjCoal: TBooleanField;
    cdsEnObjMasut: TBooleanField;
    cdsEnObjGas: TBooleanField;
    cdsEnObjOtherOrg: TBooleanField;
    cdsEnObjFilename: TStringField;
    dsStationsRef: TDataSource;
    cdsEnObjCoalCode: TIntegerField;
    cdsEnObjMasutCode: TIntegerField;
    cdsEnObjGasCode: TIntegerField;
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
    procedure DataModuleCreate(Sender: TObject);
    procedure cdsParamsLayoutChange(Sender: TField);
    procedure cdsParamsDataDateValidate(Sender: TField);
    procedure cdsParamsDataDateChange(Sender: TField);
    procedure cdsParamsUseSecurityConnChange(Sender: TField);
  private
    FDateChanging: Boolean;
    procedure GetFuelList(AXMLDoc: DOMDocument);
    procedure GetStationsList(AXMLDoc: DOMDocument);
    function GetSubNodeAttrib(ANode: IXMLDOMNode; const ANodeName, AAttrName: String): Variant;
    function GetSubNodeValue(ANode: IXMLDOMNode; const ANodeName: String): Variant;
    procedure LoadSettings;
  public
    function GetLayoutDate(const ADateFormat: String): String;
    function GetLayoutFileExt: String;
    function GetLayoutType: String;
    procedure SaveSettings(AOnlyStationID: Boolean = False);
    procedure SetDataDate(AValue: TDateTime);
    procedure SynchronizeDataDate;
  end;

var
  dmMain: TdmMain;

implementation

uses
  System.IOUtils, System.Variants, System.DateUtils, fmMain, fmBaseStationFrame,
  uPalyvoStations;

{$R *.dfm}

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
      cdsFuelRef.Post;
    end;
    cdsFuelRef.First;
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
  StationList, EnObjList: IXMLDOMNodeList;
  i, StationID: Integer;
  Elem: IXMLDOMElement;
  Node: IXMLDOMNode;
  j: Integer;
begin
  if Assigned(AXMLDoc) then begin
    cdsStationsRef.Close;
    cdsStationsRef.CreateDataSet;
    cdsEnObj.Close;
    cdsEnObj.CreateDataSet;
    cdsEnObj.MasterSource := dsStationsRef;
    cdsEnObj.MasterFields := SFldstID;
    StationList := AXMLDoc.selectNodes(SPidprPath);
    if Assigned(StationList) and (StationList.length > 0) then
      for i := 0 to Pred(StationList.length) do begin
        Elem := StationList.item[i] as IXMLDOMElement;
        StationID := Elem.getAttribute(SFldID);
        cdsStationsRef.Insert;
        cdsStationsRefstID.AsVariant := StationID;
        cdsStationsRefName.AsVariant := Elem.getAttribute(SName);
        cdsStationsRef.Post;
        EnObjList := Elem.getElementsByTagName(SEnObj);
        if Assigned(EnObjList) and (EnObjList.length > 0)then
          for j := 0 to Pred(EnObjList.length) do begin
            Node := EnObjList.item[j] as IXMLDOMElement;
            cdsEnObj.Insert;
            cdsEnObjID.AsInteger := StationID;
            cdsEnObjIDEnObj.AsVariant := GetSubNodeValue(Node, SFldIDEnObj);
            cdsEnObjCipher.AsVariant := GetSubNodeValue(Node, SFldCipher);
            cdsEnObjName.AsVariant := GetSubNodeValue(Node, SFldEnObjName);
            cdsEnObjCoal.AsVariant := GetSubNodeValue(Node, SFldCoal);
            cdsEnObjCoalCode.AsVariant := GetSubNodeAttrib(Node, SFldCoal, SCode);
            cdsEnObjMasut.AsVariant := GetSubNodeValue(Node, SFldMasut);
            cdsEnObjMasutCode.AsVariant := GetSubNodeAttrib(Node, SFldMasut, SCode);
            cdsEnObjGas.AsVariant := GetSubNodeValue(Node, SFldGas);
            cdsEnObjGasCode.AsVariant := GetSubNodeAttrib(Node, SFldGas, SCode);
            cdsEnObjOtherOrg.AsVariant := GetSubNodeValue(Node, SFldOtherOrg);
            cdsEnObjFilename.AsVariant := GetSubNodeValue(Node, SFldFilename);
            cdsEnObj.Post;
          end;
      end;
  end;
end;

function TdmMain.GetSubNodeAttrib(ANode: IXMLDOMNode; const ANodeName, AAttrName: String): Variant;
var
  Node: IXMLDOMNode;
begin
  Result := Null;
  if Assigned(ANode) then begin
    Node := ANode.selectSingleNode(ANodeName);
    if Assigned(Node) then
      Result := (Node as IXMLDOMElement).getAttribute(AAttrName)
  end;
end;

function TdmMain.GetSubNodeValue(ANode: IXMLDOMNode; const ANodeName: String): Variant;
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
