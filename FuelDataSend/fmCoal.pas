unit fmCoal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask,
  Vcl.DBCtrls, Data.DB;

type
  TfrmCoal = class(TFrame)
    Label1: TLabel;
    edCode: TDBEdit;
    edIncome: TDBEdit;
    edCosts: TDBEdit;
    edRemains: TDBEdit;
  public
    constructor Create(AOwner: TComponent; ADataSource: TDataSource); reintroduce;
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

end.
