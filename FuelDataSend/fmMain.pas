unit fmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  System.Generics.Collections, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fmSelectStation, dMain,
  Vcl.Menus, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.ComCtrls,
  Data.DB, Vcl.ActnList, Vcl.StdActns, System.Actions, Vcl.Grids, Vcl.DBGrids,
  Vcl.ToolWin, Vcl.ImgList;

type
  TDBRadioGroupCrack = class(TDBRadioGroup); // так делать нехорошо, но если очень надо...

  TfrmMain = class(TForm)
    mmMain: TMainMenu;
    miDovPalyvo: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    Panel1: TPanel;
    bExit: TButton;
    bSend: TButton;
    Panel2: TPanel;
    lblDaniCaption: TLabel;
    dtpDate: TDateTimePicker;
    dsParams: TDataSource;
    rgLayoutType: TDBRadioGroup;
    ActionList: TActionList;
    acClose: TAction;
    acSendInfo: TAction;
    acOpenSettings: TAction;
    acShowFuelRefBook: TAction;
    dsStationData: TDataSource;
    dsEnObj: TDataSource;
    PageControl1: TPageControl;
    tsStandartView: TTabSheet;
    tsExtView: TTabSheet;
    DBGrid2: TDBGrid;
    Splitter1: TSplitter;
    DBGrid1: TDBGrid;
    grdStationDataClone: TDBGrid;
    dsStationDataClone: TDataSource;
    N3: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure dtpDateChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure acCloseExecute(Sender: TObject);
    procedure rgLayoutTypeChange(Sender: TObject);
    procedure acSendInfoExecute(Sender: TObject);
    procedure acOpenSettingsExecute(Sender: TObject);
    procedure acShowFuelRefBookExecute(Sender: TObject);
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses
  fmSettings, fmFuelTypesRef, uPalyvoStations;

procedure TfrmMain.acCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TfrmMain.rgLayoutTypeChange(Sender: TObject);
begin
  if dmMain.mtParams.State in dsEditModes then begin
    TDBRadioGroupCrack(rgLayoutType).DataLink.Modified;
    dmMain.mtParams.UpdateRecord;
  end;
end;

procedure TfrmMain.acOpenSettingsExecute(Sender: TObject);
begin
  if Assigned(dmMain) then begin
    TfrmSettings.Execute(dmMain.mtParams);
    dmMain.SaveSettings;
  end;
end;

procedure TfrmMain.acSendInfoExecute(Sender: TObject);
begin
  if Assigned(dmMain) then
    dmMain.SendEmail;
end;

procedure TfrmMain.acShowFuelRefBookExecute(Sender: TObject);
begin
  if Assigned(dmMain) then
    TfrmFuelTypesRef.Execute(dmMain.mtFuelRef);
end;

procedure TfrmMain.dtpDateChange(Sender: TObject);
begin
  dmMain.SetDataDate(dtpDate.DateTime);
end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if MsgBox(SCloseApp, Caption, MB_YESNO or MB_ICONQUESTION) = ID_NO then
    CanClose := False;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
  UserCanceled: Boolean;
begin
  UserCanceled := False;
  if Assigned(dmMain) then begin
    if (dmMain.mtParamsstID.AsInteger <= 0) or not dmMain.mtStationsRef.Locate(SFldstID,
      dmMain.mtParamsstID.AsInteger, []) then begin
      UserCanceled := not TfrmSelectStation.Execute(dmMain.mtParams);
      dmMain.SaveSettings(True);
    end;
    if not UserCanceled then begin
      dmMain.FillStationData;
      dmMain.SynchronizeDataDate;
    end;
  end;
end;

end.
