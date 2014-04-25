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
    procedure ActionListUpdate(Action: TBasicAction; var Handled: Boolean);
  public
    class function Execute(ADataSet: TDataSet): Boolean;
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

procedure TfrmSelectStation.ActionListUpdate(Action: TBasicAction; var Handled: Boolean);
begin
  acOK.Enabled := (dsSource.State <> dsInactive) and not dsSource.DataSet.IsEmpty;
end;

class function TfrmSelectStation.Execute(ADataSet: TDataSet): Boolean;
var
  Form: TfrmSelectStation;
begin
  Form := TfrmSelectStation.Create(nil);
  try
    Form.dsSource.DataSet := ADataSet;
    Result := Form.ShowModal = mrOk;
    if not Result then
      Form.acClose.Execute;
  finally
    FreeAndNil(Form);
  end;
end;

end.
