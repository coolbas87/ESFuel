unit fmGas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask,
  Vcl.DBCtrls, Data.DB, uPalyvoStations;

type
  TfrmGas = class(TFrame)
    Label1: TLabel;
    edCosts: TDBEdit;
    edCode: TDBEdit;
  private
    FIsReadOnly: Boolean;
    procedure SetIsReadOnly(const AValue: Boolean);
  public
    constructor Create(AOwner: TComponent; ADataSource: TDataSource); reintroduce;
    property IsReadOnly: Boolean read FIsReadOnly write SetIsReadOnly;
  end;

implementation

{$R *.dfm}

{ TfrmGas }

constructor TfrmGas.Create(AOwner: TComponent; ADataSource: TDataSource);
begin
  inherited Create(AOwner);
  edCode.DataSource := ADataSource;
  edCosts.DataSource := ADataSource;
end;

procedure TfrmGas.SetIsReadOnly(const AValue: Boolean);
begin
  edCode.Color := CtrlColors[AValue];
  edCosts.Color := CtrlColors[AValue];
  FIsReadOnly := AValue;
end;

end.
