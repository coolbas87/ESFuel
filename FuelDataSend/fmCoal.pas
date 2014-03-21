unit fmCoal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask,
  Vcl.DBCtrls, Data.DB, uPalyvoStations;

type
  TfrmCoal = class(TFrame)
    Label1: TLabel;
    edCode: TDBEdit;
    edIncome: TDBEdit;
    edCosts: TDBEdit;
    edRemains: TDBEdit;
  private
    FIsReadOnly: Boolean;
    procedure SetIsReadOnly(const AValue: Boolean);
  public
    constructor Create(AOwner: TComponent; ADataSource: TDataSource); reintroduce;
    property IsReadOnly: Boolean read FIsReadOnly write SetIsReadOnly;
  end;

implementation

{$R *.dfm}

{ TfrmCoal }

constructor TfrmCoal.Create(AOwner: TComponent; ADataSource: TDataSource);
begin
  inherited Create(AOwner);
  edCode.DataSource := ADataSource;
  edIncome.DataSource := ADataSource;
  edCosts.DataSource := ADataSource;
  edRemains.DataSource := ADataSource;
end;

procedure TfrmCoal.SetIsReadOnly(const AValue: Boolean);
begin
  edCode.Color := CtrlColors[AValue];
  edIncome.Color := CtrlColors[AValue];
  edCosts.Color := CtrlColors[AValue];
  edRemains.Color := CtrlColors[AValue];
  FIsReadOnly := AValue;
end;

end.
