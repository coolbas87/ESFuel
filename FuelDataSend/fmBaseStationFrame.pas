unit fmBaseStationFrame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.DBCtrls,
  Vcl.ExtCtrls, Data.DB, Datasnap.DBClient, System.Actions, Vcl.ActnList, fmCoal,
  fmGas, fmMasut;

type
  TfrmBaseStationFrame = class(TFrame)
    lblStationName: TLabel;
    Bevel1: TBevel;
    pnlLabels: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    lblOtherOrgs: TLabel;
    chbSendData: TDBCheckBox;
    cdsStationData: TClientDataSet;
    dsStationData: TDataSource;
    cdsStationDataCoalCode: TIntegerField;
    cdsStationDataCoalIncome: TIntegerField;
    cdsStationDataCoalCosts: TIntegerField;
    cdsStationDataCoalRemains: TIntegerField;
    cdsStationDataMasutCode: TIntegerField;
    cdsStationDataMasutIncome: TIntegerField;
    cdsStationDataMasutCosts: TIntegerField;
    cdsStationDataMasutRemains: TIntegerField;
    cdsStationDataMasutOtherOrgsRemains: TIntegerField;
    cdsStationDataGasCode: TIntegerField;
    cdsStationDataGasCosts: TIntegerField;
    cdsStationDataIsSendData: TBooleanField;
    Actions: TActionList;
    acToggleSendData: TAction;
    procedure acToggleSendDataExecute(Sender: TObject);
    procedure cdsStationDataIsSendDataChange(Sender: TField);
  private
    FCoalFrame: TfrmCoal;
    FGasFrame: TfrmGas;
    FMasutFrame: TfrmMasut;
    FHasCoal: Boolean;
    FHasGas: Boolean;
    FHasMasut: Boolean;
    FHasOtherOrgs: Boolean;
    function GetLowestBorder: Integer;
    function GetIsNeedSend: Boolean;
    procedure SetReadOnly(AValue: Boolean);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure GetLayout(ALayout: TStringList);
    property IsNeedSend: Boolean read GetIsNeedSend;
  end;

implementation

uses
  dMain, uPalyvoStations;

{$R *.dfm}

{ TfrmBaseStationFrame }

procedure TfrmBaseStationFrame.acToggleSendDataExecute(Sender: TObject);
begin
  if cdsStationData.State in dsEditModes then
    PostMessage(chbSendData.Handle, CM_EXIT, 0, 0);
end;

procedure TfrmBaseStationFrame.cdsStationDataIsSendDataChange(Sender: TField);
begin
  SetReadOnly(not Sender.AsBoolean);
  if Assigned(FCoalFrame) then
    FCoalFrame.IsReadOnly := Sender.AsBoolean;
  if Assigned(FGasFrame) then
    FGasFrame.IsReadOnly := Sender.AsBoolean;
  if Assigned(FMasutFrame) then
    FMasutFrame.IsReadOnly := Sender.AsBoolean;
end;

constructor TfrmBaseStationFrame.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  if Assigned(dmMain) then begin
    cdsStationData.CreateDataSet;
    cdsStationData.Insert;
    cdsStationDataCoalCode.AsInteger := dmMain.cdsEnObjCoalCode.AsInteger;
    cdsStationDataMasutCode.AsInteger := dmMain.cdsEnObjMasutCode.AsInteger;
    cdsStationDataGasCode.AsInteger := dmMain.cdsEnObjGasCode.AsInteger;
    FHasCoal := dmMain.cdsEnObjCoal.AsBoolean;
    FHasGas := dmMain.cdsEnObjGas.AsBoolean;
    FHasMasut := dmMain.cdsEnObjMasut.AsBoolean;
    FHasOtherOrgs := dmMain.cdsEnObjOtherOrg.AsBoolean;
    lblOtherOrgs.Visible := FHasOtherOrgs;
    if FHasCoal then begin
      FCoalFrame := TfrmCoal.Create(Self, dsStationData);
      FCoalFrame.Parent := Self;
      FCoalFrame.Top := GetLowestBorder;
      FCoalFrame.Align := alTop;
    end;
    if FHasMasut then begin
      FMasutFrame := TfrmMasut.Create(Self, dsStationData, FHasOtherOrgs);
      FMasutFrame.Parent := Self;
      FMasutFrame.Top := GetLowestBorder;
      FMasutFrame.Align := alTop;
    end;
    if FHasGas then begin
      FGasFrame := TfrmGas.Create(Self, dsStationData);
      FGasFrame.Parent := Self;
      FGasFrame.Top := GetLowestBorder;
      FGasFrame.Align := alTop;
    end;
    lblStationName.Caption := dmMain.cdsEnObjName.AsString;
  end;
  Height := GetLowestBorder + 12;
end;

destructor TfrmBaseStationFrame.Destroy;
begin
  FreeAndNil(FCoalFrame);
  FreeAndNil(FGasFrame);
  FreeAndNil(FMasutFrame);
  inherited Destroy;
end;

function TfrmBaseStationFrame.GetIsNeedSend: Boolean;
begin
  Result := cdsStationDataIsSendData.AsBoolean;
end;

procedure TfrmBaseStationFrame.GetLayout(ALayout: TStringList);
begin
  if Assigned(ALayout) then begin
    if FHasCoal then begin
      ALayout.Add(Format(SLayoutLineFmt, [cdsStationDataCoalCode.AsInteger, IncomeValueIndex,
        cdsStationDataCoalIncome.AsInteger]));
      ALayout.Add(Format(SLayoutLineFmt, [cdsStationDataCoalCode.AsInteger, CostsValueIndex,
        cdsStationDataCoalCosts.AsInteger]));
      ALayout.Add(Format(SLayoutLineFmt, [cdsStationDataCoalCode.AsInteger, RemainsValueIndex,
        cdsStationDataCoalRemains.AsInteger]));
    end;
    if FHasMasut then begin
      ALayout.Add(Format(SLayoutLineFmt, [cdsStationDataMasutCode.AsInteger, IncomeValueIndex,
        cdsStationDataMasutIncome.AsInteger]));
      ALayout.Add(Format(SLayoutLineFmt, [cdsStationDataMasutCode.AsInteger, CostsValueIndex,
        cdsStationDataMasutCosts.AsInteger]));
      ALayout.Add(Format(SLayoutLineFmt, [cdsStationDataMasutCode.AsInteger, RemainsValueIndex,
        cdsStationDataMasutRemains.AsInteger]));
      if FHasOtherOrgs then
        ALayout.Add(Format(SLayoutLineFmt, [cdsStationDataMasutCode.AsInteger, OtherOrgsValueIndex,
          cdsStationDataMasutOtherOrgsRemains.AsInteger]));
    end;
    if FHasGas then
      ALayout.Add(Format(SLayoutLineFmt, [cdsStationDataGasCode.AsInteger, RemainsValueIndex,
        cdsStationDataGasCosts.AsInteger]));
  end;
end;

function TfrmBaseStationFrame.GetLowestBorder: Integer;
var
  i: Integer;
  CurentValue: Integer;
begin
  Result := 0;
  for i := 0 to Pred(ControlCount) do begin
    CurentValue := Controls[i].Top + Controls[i].Height;
    if Result < CurentValue then
      Result := CurentValue;
  end;
end;

procedure TfrmBaseStationFrame.SetReadOnly(AValue: Boolean);
begin
  cdsStationDataCoalCode.ReadOnly := AValue;
  cdsStationDataCoalIncome.ReadOnly := AValue;
  cdsStationDataCoalCosts.ReadOnly := AValue;
  cdsStationDataCoalRemains.ReadOnly := AValue;
  cdsStationDataMasutCode.ReadOnly := AValue;
  cdsStationDataMasutIncome.ReadOnly := AValue;
  cdsStationDataMasutCosts.ReadOnly := AValue;
  cdsStationDataMasutRemains.ReadOnly := AValue;
  cdsStationDataMasutOtherOrgsRemains.ReadOnly := AValue;
  cdsStationDataGasCode.ReadOnly := AValue;
  cdsStationDataGasCosts.ReadOnly := AValue;
end;

end.
