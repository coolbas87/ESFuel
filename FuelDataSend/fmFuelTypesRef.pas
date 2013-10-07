unit fmFuelTypesRef;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids,
  Vcl.DBGrids, Data.DB;

type
  TfrmFuelTypesRef = class(TForm)
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    bClose: TButton;
    dsFuelRef: TDataSource;
  public
    class procedure Execute(AFuelRefDataSet: TDataSet);
  end;

var
  frmFuelTypesRef: TfrmFuelTypesRef;

implementation

{$R *.dfm}

{ TfrmFuelTypesRef }

class procedure TfrmFuelTypesRef.Execute(AFuelRefDataSet: TDataSet);
var
  Form: TfrmFuelTypesRef;
begin
  if Assigned(AFuelRefDataSet) then begin
    Form := TfrmFuelTypesRef.Create(Application);
    try
      Form.dsFuelRef.DataSet := AFuelRefDataSet;
      Form.ShowModal;
    finally
      FreeAndNil(Form);
    end;
  end;
end;

end.
