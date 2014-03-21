unit fmMasut;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask,
  Vcl.DBCtrls, Data.DB, uPalyvoStations;

type
  TfrmMasut = class(TFrame)
    Label1: TLabel;
    edCode: TDBEdit;
    edIncome: TDBEdit;
    edCosts: TDBEdit;
    edRemains: TDBEdit;
    edOtherOrgRemains: TDBEdit;
  private
    FIsReadOnly: Boolean;
    procedure SetIsReadOnly(const AValue: Boolean);
  public
    constructor Create(AOwner: TComponent; ADataSource: TDataSource; AIsOtherOrgVisible: Boolean); reintroduce;
    property IsReadOnly: Boolean read FIsReadOnly write SetIsReadOnly;
  end;

implementation

{$R *.dfm}

{ TfrmMasut }

constructor TfrmMasut.Create(AOwner: TComponent; ADataSource: TDataSource; AIsOtherOrgVisible: Boolean);
begin
  inherited Create(AOwner);
  edOtherOrgRemains.Visible := AIsOtherOrgVisible;
  edCode.DataSource := ADataSource;
  edIncome.DataSource := ADataSource;
  edCosts.DataSource := ADataSource;
  edRemains.DataSource := ADataSource;
  edOtherOrgRemains.DataSource := ADataSource;
end;

procedure TfrmMasut.SetIsReadOnly(const AValue: Boolean);
begin
  edCode.Color := CtrlColors[AValue];
  edIncome.Color := CtrlColors[AValue];
  edCosts.Color := CtrlColors[AValue];
  edRemains.Color := CtrlColors[AValue];
  edOtherOrgRemains.Color := CtrlColors[AValue];
  FIsReadOnly := AValue;
end;

end.
