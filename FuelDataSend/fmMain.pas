unit fmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  System.Generics.Collections, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fmSelectStation, dMain, IdBaseComponent,
  IdComponent, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL,
  IdSSLOpenSSL, Vcl.Menus, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.ComCtrls,
  Data.DB, Vcl.ActnList, Vcl.StdActns, System.Actions, IdTCPConnection, IdTCPClient,
  IdExplicitTLSClientServerBase, IdMessageClient,
  IdSMTPBase, IdSMTP, IdAttachmentFile, IdMessage, Vcl.Grids, Vcl.DBGrids;

type
  TDBRadioGroupCrack = class(TDBRadioGroup); // так делать нехорошо, но если очень надо...

  TfrmMain = class(TForm)
    mmMain: TMainMenu;
    miDovPalyvo: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    Panel1: TPanel;
    bExit: TButton;
    bSend: TButton;
    bSetings: TButton;
    Panel2: TPanel;
    lblDaniCaption: TLabel;
    dtpDate: TDateTimePicker;
    dsParams: TDataSource;
    rgLayoutType: TDBRadioGroup;
    ActionList: TActionList;
    acClose: TAction;
    acSendInfo: TAction;
    IdSMTP: TIdSMTP;
    IdMessage: TIdMessage;
    acOpenSettings: TAction;
    acShowFuelRefBook: TAction;
    DBGrid1: TDBGrid;
    dsStationData: TDataSource;
    dsEnObj: TDataSource;
    DBGrid2: TDBGrid;
    Splitter1: TSplitter;
    procedure FormCreate(Sender: TObject);
    procedure dtpDateChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure acCloseExecute(Sender: TObject);
    procedure rgLayoutTypeChange(Sender: TObject);
    procedure acSendInfoExecute(Sender: TObject);
    procedure acOpenSettingsExecute(Sender: TObject);
    procedure acShowFuelRefBookExecute(Sender: TObject);
  private
    function GetLayoutFile: String;
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
  if dmMain.cdsParams.State in dsEditModes then begin
    TDBRadioGroupCrack(rgLayoutType).DataLink.Modified;
    dmMain.cdsParams.UpdateRecord;
  end;
end;

procedure TfrmMain.acOpenSettingsExecute(Sender: TObject);
begin
  if Assigned(dmMain) then begin
    TfrmSettings.Execute(dmMain.cdsParams);
    dmMain.SaveSettings;
  end;
end;

procedure TfrmMain.acSendInfoExecute(Sender: TObject);
var
  Filename, MsgID, From: String;
  Attach: TIdAttachmentFile;
begin
  if Assigned(dmMain) then begin
    dmMain.cdsEnObj.First;
    while not dmMain.cdsEnObj.Eof do begin
      Filename := GetLayoutFile;
      if FileExists(Filename) then begin
        Attach := TIdAttachmentFile.Create(IdMessage.MessageParts, Filename);
        try
          From := dmMain.cdsParamsEmailFrom.AsString;
          IdMessage.Body.Add(ExtractFileName(Filename));
          IdMessage.From.Text := From;
          IdMessage.Recipients.EMailAddresses := dmMain.cdsParamsEmailTo.AsString;
          IdMessage.Subject := dmMain.cdsParamsEmailSubject.AsString;
          IdMessage.Priority := TIdMessagePriority(mpNormal);
          MsgID := GetUniqueMesID(From);
          IdMessage.MsgId := MsgID;
          IdMessage.ExtraHeaders.Add(Format(SMsgIDHeaderFmt, [MsgID]));
          IdSMTP.Username := dmMain.cdsParamsMailSrvLogin.AsString;
          IdSMTP.Password := dmMain.cdsParamsMailSrvPaswd.AsString;
          IdSMTP.Host := dmMain.cdsParamsMailSrvHost.AsString;
          if dmMain.cdsParamsUseSecurityConn.AsBoolean then
            IdSMTP.UseTLS:=utUseImplicitTLS
          else
            IdSMTP.UseTLS:=utNoTLSSupport;
          IdSMTP.Port := dmMain.cdsParamsMailSrvPort.AsInteger;
          try
            IdSMTP.Connect;
            try
              IdSMTP.Send(IdMessage);
            finally
              IdSMTP.Disconnect;
            end;
          except
            raise Exception.CreateFmt(SFileNotSended, [Filename]);
          end;
        finally
          FreeAndNil(Attach);
        end;
      end;
      dmMain.cdsEnObj.Next;
    end;
  end;
end;

procedure TfrmMain.acShowFuelRefBookExecute(Sender: TObject);
begin
  if Assigned(dmMain) then
    TfrmFuelTypesRef.Execute(dmMain.cdsFuelRef);
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
    if (dmMain.cdsParamsstID.AsInteger <= 0) or not dmMain.cdsStationsRef.Locate(SFldstID,
      dmMain.cdsParamsstID.AsInteger, []) then begin
      UserCanceled := not TfrmSelectStation.Execute(dmMain.cdsParams);
      dmMain.SaveSettings(True);
    end;
    if not UserCanceled then begin
      dmMain.FillStationData;
      dmMain.SynchronizeDataDate;
    end;
  end;
end;

function TfrmMain.GetLayoutFile: String;
var
  Layout: TStringList;
  Filename: String;
//  CurFrame: TfrmBaseStationFrame;
begin
  Filename := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) + SSendedFilesFolder;
//  CurFrame := FBaseFrames.Items[dmMain.cdsEnObjIDEnObj.AsInteger];
  if not DirectoryExists(Filename) then
    if not CreateDir(Filename) then
      raise Exception.CreateFmt(SCantCreateDirectory, [Filename]);
  Filename := IncludeTrailingPathDelimiter(Filename) + Format(SConcatFmt, [dmMain.cdsEnObjFilename.AsString,
    dmMain.GetLayoutDate(SDateFmtLayoutFname)]);
  Layout := TStringList.Create;
  try
    Layout.Add(Format(SFmtLayoutHeader, [dmMain.GetLayoutType, dmMain.GetLayoutDate(SFmtLayoutDate),
      dmMain.cdsEnObjCipher.AsString]));
//    CurFrame.GetLayout(Layout);
    Layout.Add(SLayoutEnd);
    Filename := ChangeFileExt(Filename, dmMain.GetLayoutFileExt);
    Layout.SaveToFile(Filename);
    Result := Filename;
  finally
    FreeAndNil(Layout);
  end;
end;

end.
