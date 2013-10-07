unit fmGas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask,
  Vcl.DBCtrls, Data.DB;

type
  TfrmGas = class(TFrame)
    Label1: TLabel;
    edCosts: TDBEdit;
    edCode: TDBEdit;
  public
    constructor Create(AOwner: TComponent; ADataSource: TDataSource); reintroduce;
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

end.
