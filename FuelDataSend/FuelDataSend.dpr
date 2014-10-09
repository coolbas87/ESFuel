program FuelDataSend;

{$R 'Manifest.res' 'Manifest.rc'}
{$R 'MainIcon.res' 'MainIcon.rc'}
{$R 'Version.res' 'Version.rc'}

uses
  Vcl.Forms,
  Midas,
  fmMain in 'fmMain.pas' {frmMain},
  dMain in 'dMain.pas' {dmMain: TDataModule},
  uPalyvoStations in 'uPalyvoStations.pas',
  fmSelectStation in 'fmSelectStation.pas' {frmSelectStation},
  fmSettings in 'fmSettings.pas' {frmSettings},
  fmFuelTypesRef in 'fmFuelTypesRef.pas' {frmFuelTypesRef},
  Data.DBConsts in 'Data.DBConsts.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Передача даних палива у ЦЕС';
  Application.CreateForm(TdmMain, dmMain);
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
