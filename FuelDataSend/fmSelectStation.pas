unit fmSelectStation;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Data.DB, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.DBCtrls, Vcl.ExtCtrls, Vcl.Mask, Vcl.ActnList, System.Actions;

type
  TfrmSelectStation = class(TForm)
    Label1: TLabel;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    dsSource: TDataSource;
    lcbStation: TDBLookupComboBox;
    ActionList: TActionList;
    acClose: TAction;
    acOK: TAction;
    procedure acOKExecute(Sender: TObject);
    procedure acCloseExecute(Sender: TObject);
  public
    class procedure Execute(ADataSet: TDataSet);
  end;

var
  frmSelectStation: TfrmSelectStation;

implementation

{$R *.dfm}

uses
  uPalyvoStations;

{ TfrmSelectStation }

procedure TfrmSelectStation.acCloseExecute(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmSelectStation.acOKExecute(Sender: TObject);
begin
  dsSource.DataSet.CheckBrowseMode;
  ModalResult := mrOk;
end;

class procedure TfrmSelectStation.Execute(ADataSet: TDataSet);
var
  Form: TfrmSelectStation;
begin
  Form := TfrmSelectStation.Create(nil);
  try
    Form.dsSource.DataSet := ADataSet;
    if Form.ShowModal <> mrOk then
      Form.acClose.Execute;
  finally
    FreeAndNil(Form);
  end;
end;

end.
