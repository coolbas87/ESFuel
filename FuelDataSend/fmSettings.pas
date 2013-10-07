unit fmSettings;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Data.DB, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.DBCtrls, Vcl.Mask, Vcl.Samples.Spin, Vcl.ExtCtrls;

type
  TfrmSettings = class(TForm)
    dsParams: TDataSource;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label4: TLabel;
    edPort: TDBEdit;
    chbUseScureConnection: TDBCheckBox;
    edHost: TDBEdit;
    Label5: TLabel;
    Label6: TLabel;
    edLogin: TDBEdit;
    edPassword: TDBEdit;
    Label7: TLabel;
    edSenderEmail: TDBEdit;
    Label8: TLabel;
    edRecipientEmail: TDBEdit;
    Label9: TLabel;
    edSubject: TDBEdit;
    btCancel: TButton;
    btOK: TButton;
  public
    class procedure Execute(AParamsDataSet: TDataSet);
  end;

var
  frmSettings: TfrmSettings;

implementation

{$R *.dfm}

{ TfrmSettings }

class procedure TfrmSettings.Execute(AParamsDataSet: TDataSet);
var
  Form: TfrmSettings;
begin
  if Assigned(AParamsDataSet) then begin
    Form := TfrmSettings.Create(Application);
    try
      Form.dsParams.DataSet := AParamsDataSet;
      Form.ShowModal;
      if Form.ModalResult = mrOk then
        Form.dsParams.DataSet.CheckBrowseMode
      else
        Form.dsParams.DataSet.Cancel;
    finally
      FreeAndNil(Form);
    end;
  end;
end;

end.
