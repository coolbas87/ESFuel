unit dMain;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient, System.IniFiles,
  msxml, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.UI.Intf,
  FireDAC.VCLUI.Wait, FireDAC.Comp.UI;

type
  TdmMain = class(TDataModule)
    dsStationsRef: TDataSource;
    dsEnObj: TDataSource;
    mtFuelRef: TFDMemTable;
    mtFuelRefCode: TIntegerField;
    mtFuelRefName: TStringField;
    mtFuelRefIsActive: TBooleanField;
    mtFuelRefClone: TFDMemTable;
    IntegerField1: TIntegerField;
    StringField1: TStringField;
    BooleanField1: TBooleanField;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    mtStationsRef: TFDMemTable;
    mtStationsRefstID: TIntegerField;
    mtStationsRefName: TStringField;
    mtEnObj: TFDMemTable;
    mtFuelTypes: TFDMemTable;
    mtStationData: TFDMemTable;
    mtEnObjID: TIntegerField;
    mtEnObjIDEnObj: TIntegerField;
    mtEnObjCipher: TStringField;
    mtEnObjName: TStringField;
    mtEnObjFilename: TStringField;
    mtFuelTypesIDEnObj: TIntegerField;
    mtFuelTypesCode: TIntegerField;
    mtStationDataIDEnObj: TIntegerField;
    mtStationDataCode: TIntegerField;
    mtStationDataCodeName: TStringField;
    mtStationDataIncome: TIntegerField;
    mtStationDataCosts: TIntegerField;
    mtStationDataRemains: TIntegerField;
    mtParams: TFDMemTable;
    mtParamsstID: TIntegerField;
    mtParamsstIDName: TStringField;
    mtParamsLayout: TIntegerField;
    mtParamsDataDate: TDateTimeField;
    mtParamsEmailFrom: TStringField;
    mtParamsEmailTo: TStringField;
    mtParamsEmailSubject: TStringField;
    mtParamsUseSecurityConn: TBooleanField;
    mtParamsMailSrvHost: TStringField;
    mtParamsMailSrvPort: TIntegerField;
    mtParamsMailSrvLogin: TStringField;
    mtParamsMailSrvPaswd: TStringField;
    mtEnObjClone: TFDMemTable;
    mtEnObjCloneID: TIntegerField;
    mtEnObjCloneIDEnObj: TIntegerField;
    mtEnObjCloneCipher: TStringField;
    mtEnObjCloneName: TStringField;
    mtEnObjCloneFilename: TStringField;
    mtStationDataClone: TFDMemTable;
    mtStationDataCloneIDEnObj: TIntegerField;
    mtStationDataCloneEnObjName: TStringField;
    mtStationDataCloneCode: TIntegerField;
    mtStationDataCloneCodeName: TStringField;
    mtStationDataCloneIncome: TIntegerField;
    mtStationDataCloneCosts: TIntegerField;
    mtStationDataCloneRemains: TIntegerField;
    procedure DataModuleCreate(Sender: TObject);
    procedure mtFuelTypesNewRecord(DataSet: TDataSet);
    procedure mtStationDataNewRecord(DataSet: TDataSet);
    procedure mtParamsLayoutChange(Sender: TField);
    procedure mtParamsDataDateChange(Sender: TField);
    procedure mtParamsDataDateValidate(Sender: TField);
    procedure mtParamsUseSecurityConnChange(Sender: TField);
  private
    FDateChanging: Boolean;
    procedure GetFuelList(AXMLDoc: DOMDocument);
    procedure GetStationsList(AXMLDoc: DOMDocument);
    function GetSubNodeValue(ANode: IXMLDOMElement; const ANodeName: String): Variant;
    procedure LoadSettings;
  public
    procedure GetLayout(ALayout: TStringList);
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
  mtParams.CreateDataSet;
  mtParams.Edit;
  mtParamsDataDate.AsDateTime := Trunc(Yesterday);
  mtParamsLayout.AsInteger := DailyLayout;
  LoadSettings;
  mtParams.CheckBrowseMode;
end;

procedure TdmMain.mtStationDataNewRecord(DataSet: TDataSet);
begin
  mtStationDataIDEnObj.AsInteger := mtEnObjIDEnObj.AsInteger;
end;

procedure TdmMain.FillStationData;
begin
  mtStationData.Close;
  mtStationData.CreateDataSet;
  mtStationData.DisableControls;
  try
    mtEnObj.First;
    while not mtEnObj.Eof do begin
      mtFuelTypes.First;
      while not mtFuelTypes.Eof do begin
        mtStationData.Insert;
        mtStationDataCode.AsInteger := mtFuelTypesCode.AsInteger;
        mtStationData.CheckBrowseMode;
        mtFuelTypes.Next;
      end;
      mtEnObj.Next;
    end;
  finally
    mtStationData.EnableControls;
  end;
  mtEnObj.First;
  mtStationData.First;
  mtStationDataClone.CloneCursor(mtStationData, True);
end;

procedure TdmMain.GetFuelList(AXMLDoc: DOMDocument);
var
  List: IXMLDOMNodeList;
  i: Integer;
  Node: IXMLDOMElement;
begin
  mtFuelRef.Close;
  mtFuelRef.CreateDataSet;
  if Assigned(AXMLDoc) then begin
    List := AXMLDoc.selectNodes(SFuelPath);
    for i := 0 to Pred(List.length) do begin
      Node := List.item[i] as IXMLDOMElement;
      mtFuelRef.Insert;
      mtFuelRefCode.AsVariant := Node.getAttribute(SCode);
      mtFuelRefName.AsVariant := Node.getAttribute(SName);
      mtFuelRefIsActive.AsVariant := Node.getAttribute(SFldIsActive);
      mtFuelRef.Post;
    end;
    mtFuelRef.First;
    mtFuelRefClone.CloneCursor(mtFuelRef, True, False);
    mtFuelRefClone.Filter := SFldIsActive;
    mtFuelRefClone.Filtered := True;
  end;
end;

procedure TdmMain.GetLayout(ALayout: TStringList);
begin
  if Assigned(ALayout) then begin
//    if FHasCoal then begin
//      ALayout.Add(Format(SLayoutLineFmt, [cdsStationDataCoalCode.AsInteger, IncomeValueIndex,
//        cdsStationDataCoalIncome.AsInteger]));
//      ALayout.Add(Format(SLayoutLineFmt, [cdsStationDataCoalCode.AsInteger, CostsValueIndex,
//        cdsStationDataCoalCosts.AsInteger]));
//      ALayout.Add(Format(SLayoutLineFmt, [cdsStationDataCoalCode.AsInteger, RemainsValueIndex,
//        cdsStationDataCoalRemains.AsInteger]));
//    end;
//    if FHasMasut then begin
//      ALayout.Add(Format(SLayoutLineFmt, [cdsStationDataMasutCode.AsInteger, IncomeValueIndex,
//        cdsStationDataMasutIncome.AsInteger]));
//      ALayout.Add(Format(SLayoutLineFmt, [cdsStationDataMasutCode.AsInteger, CostsValueIndex,
//        cdsStationDataMasutCosts.AsInteger]));
//      ALayout.Add(Format(SLayoutLineFmt, [cdsStationDataMasutCode.AsInteger, RemainsValueIndex,
//        cdsStationDataMasutRemains.AsInteger]));
//      if FHasOtherOrgs then
//        ALayout.Add(Format(SLayoutLineFmt, [cdsStationDataMasutCode.AsInteger, OtherOrgsValueIndex,
//          cdsStationDataMasutOtherOrgsRemains.AsInteger]));
//    end;
//    if FHasGas then
//      ALayout.Add(Format(SLayoutLineFmt, [cdsStationDataGasCode.AsInteger, RemainsValueIndex,
//        cdsStationDataGasCosts.AsInteger]));
  end;
end;

function TdmMain.GetLayoutDate(const ADateFormat: String): String;
begin
  Result := FormatDateTime(ADateFormat, mtParamsDataDate.AsDateTime);
end;

function TdmMain.GetLayoutFileExt: String;
begin
  Result := LayoutExt[mtParamsLayout.AsInteger];
end;

function TdmMain.GetLayoutType: String;
begin
  Result := LayoutType[mtParamsLayout.AsInteger];
end;

procedure TdmMain.GetStationsList(AXMLDoc: DOMDocument);
var
  StationList, EnObjList, FuelList: IXMLDOMNodeList;
  I, J, K, StationID: Integer;
  Elem, Node, FuelNode: IXMLDOMElement;
begin
  if Assigned(AXMLDoc) then begin
    mtStationsRef.Close;
    mtStationsRef.CreateDataSet;
    mtEnObj.Close;
    mtEnObj.CreateDataSet;
    mtFuelTypes.Close;
    mtFuelTypes.CreateDataSet;
    StationList := AXMLDoc.selectNodes(SPidprPath);
    if Assigned(StationList) and (StationList.length > 0) then
      for I := 0 to Pred(StationList.length) do begin
        Elem := StationList.item[I] as IXMLDOMElement;
        StationID := Elem.getAttribute(SFldID);
        mtStationsRef.Insert;
        mtStationsRefstID.AsVariant := StationID;
        mtStationsRefName.AsVariant := Elem.getAttribute(SName);
        mtStationsRef.Post;
        EnObjList := Elem.getElementsByTagName(SEnObj);
        if Assigned(EnObjList) and (EnObjList.length > 0) then
          for J := 0 to Pred(EnObjList.length) do begin
            Node := EnObjList.item[J] as IXMLDOMElement;
            mtEnObj.Append;
            mtEnObjID.AsInteger := StationID;
            mtEnObjIDEnObj.AsVariant := GetSubNodeValue(Node, SFldIDEnObj);
            mtEnObjCipher.AsVariant := GetSubNodeValue(Node, SFldCipher);
            mtEnObjName.AsVariant := GetSubNodeValue(Node, SFldEnObjName);
            mtEnObjFilename.AsVariant := GetSubNodeValue(Node, SFldFilename);
            FuelList := Node.getElementsByTagName(SFuel);
            if Assigned(FuelList) and (FuelList.length > 0) then
              for K := 0 to Pred(FuelList.length) do begin
                FuelNode := FuelList.item[K] as IXMLDOMElement;
                mtFuelTypes.Append;
                mtFuelTypesCode.AsVariant := FuelNode.getAttribute(SCode);
                mtFuelTypes.CheckBrowseMode;
              end;
            mtEnObj.CheckBrowseMode;
          end;
      end;
      mtEnObjClone.CloneCursor(mtEnObj, True, False);
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
    mtParamsstID.AsInteger := Settings.ReadInteger(SProgramSngsSection, SStationID, 0);
    mtParamsEmailFrom.AsString := Settings.ReadString(SEmailSngsSection, SEmailFromSngs,
      mtParamsEmailFrom.AsString);
    mtParamsEmailTo.AsString := Settings.ReadString(SEmailSngsSection, SEmailToSngs,
      mtParamsEmailTo.AsString);
    mtParamsEmailSubject.AsString := Settings.ReadString(SEmailSngsSection, SEmailSubjectSngs,
      mtParamsEmailSubject.AsString);
    mtParamsMailSrvHost.AsString := Settings.ReadString(SMailSrvSection, SMailSrvHostSngs,
      mtParamsMailSrvHost.AsString);
    mtParamsUseSecurityConn.AsBoolean := Settings.ReadBool(SMailSrvSection, SUseSecurityConnSngs,
      mtParamsUseSecurityConn.AsBoolean);
    mtParamsMailSrvPort.AsInteger := Settings.ReadInteger(SMailSrvSection, SMailSrvPortSngs,
      mtParamsMailSrvPort.AsInteger);
    mtParamsMailSrvLogin.AsString := Settings.ReadString(SMailSrvSection, SMailSrvLoginSngs,
      mtParamsMailSrvLogin.AsString);
    mtParamsMailSrvPaswd.AsString := Settings.ReadString(SMailSrvSection, SMailSrvPaswdSngs,
      mtParamsMailSrvPaswd.AsString);
  finally
    FreeAndNil(Settings);
  end;
end;

procedure TdmMain.mtFuelTypesNewRecord(DataSet: TDataSet);
begin
  mtFuelTypesIDEnObj.AsInteger := mtEnObjIDEnObj.AsInteger;
end;

procedure TdmMain.mtParamsDataDateChange(Sender: TField);
begin
  SynchronizeDataDate;
end;

procedure TdmMain.mtParamsDataDateValidate(Sender: TField);
begin
  if (mtParamsLayout.AsInteger = DailyLayout) and (Sender.AsDateTime >= Trunc(Now)) then
    raise Exception.Create(SDateMoreThenToday);
end;

procedure TdmMain.mtParamsLayoutChange(Sender: TField);
begin
  mtParamsDataDate.ReadOnly := False;
  if Sender.AsInteger = DailyLayout then
    mtParamsDataDate.AsDateTime := Trunc(Yesterday)
  else if Sender.AsInteger = MonthLayout then begin
    mtParamsDataDate.AsDateTime := Trunc(EndOfTheMonth(IncMonth(Now, -1)));
    mtParamsDataDate.ReadOnly := True;
  end else
    mtParamsDataDate.Clear;
end;

procedure TdmMain.mtParamsUseSecurityConnChange(Sender: TField);
begin
  if Sender.AsBoolean then
    mtParamsMailSrvPort.AsInteger := SMTPTLSPort
  else
    mtParamsMailSrvPort.AsInteger := SMTPStandPort;
end;

procedure TdmMain.SaveSettings(AOnlyStationID: Boolean);
var
  Settings: TIniFile;
begin
  Settings := TIniFile.Create(IncludeTrailingPathDelimiter(ExtractFileDir(ParamStr(0))) + SSetingsFileName);
  try
    Settings.WriteInteger(SProgramSngsSection, SStationID, mtParamsstID.AsInteger);
    if not AOnlyStationID then begin
      Settings.WriteString(SEmailSngsSection, SEmailFromSngs, mtParamsEmailFrom.AsString);
      Settings.WriteString(SEmailSngsSection, SEmailToSngs, mtParamsEmailTo.AsString);
      Settings.WriteString(SEmailSngsSection, SEmailSubjectSngs, mtParamsEmailSubject.AsString);
      Settings.WriteString(SMailSrvSection, SMailSrvHostSngs, mtParamsMailSrvHost.AsString);
      Settings.WriteInteger(SMailSrvSection, SMailSrvPortSngs, mtParamsMailSrvPort.AsInteger);
      Settings.WriteBool(SMailSrvSection, SUseSecurityConnSngs, mtParamsUseSecurityConn.AsBoolean);
      Settings.WriteString(SMailSrvSection, SMailSrvLoginSngs, mtParamsMailSrvLogin.AsString);
      Settings.WriteString(SMailSrvSection, SMailSrvPaswdSngs, mtParamsMailSrvPaswd.AsString);
    end;
  finally
    FreeAndNil(Settings);
  end;
end;

procedure TdmMain.SetDataDate(AValue: TDateTime);
begin
  // ��� ����������� DB-���������� ��� �������������� ����, ������ ����� ���������
  if not FDateChanging then begin
    FDateChanging := True;
    try
      mtParams.Edit;
      mtParamsDataDate.AsDateTime := AValue;
      mtParams.Post;
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
        frmMain.dtpDate.DateTime := mtParamsDataDate.AsDateTime;
    finally
      FDateChanging := False;
    end;
  end;
end;

end.
