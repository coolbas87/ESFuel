unit fmMasut;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask,
  Vcl.DBCtrls, Data.DB;

type
  TfrmMasut = class(TFrame)
    Label1: TLabel;
    edCode: TDBEdit;
    edIncome: TDBEdit;
    edCosts: TDBEdit;
    edRemains: TDBEdit;
    edOtherOrgRemains: TDBEdit;
  public
    constructor Create(AOwner: TComponent; ADataSource: TDataSource; AIsOtherOrgVisible: Boolean); reintroduce;
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

end.
