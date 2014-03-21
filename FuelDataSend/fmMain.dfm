object frmMain: TfrmMain
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Передача даних палива у ЦЕС'
  ClientHeight = 180
  ClientWidth = 659
  Color = clBtnFace
  Constraints.MinHeight = 228
  Constraints.MinWidth = 665
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = mmMain
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 140
    Width = 659
    Height = 40
    Align = alTop
    TabOrder = 0
    DesignSize = (
      659
      40)
    object bExit: TButton
      Left = 578
      Top = 6
      Width = 75
      Height = 27
      Action = acClose
      Anchors = [akTop, akRight]
      Cancel = True
      TabOrder = 1
    end
    object bSend: TButton
      Left = 452
      Top = 6
      Width = 125
      Height = 27
      Action = acSendInfo
      Anchors = [akTop, akRight]
      Default = True
      TabOrder = 0
    end
    object bSetings: TButton
      Left = 6
      Top = 6
      Width = 30
      Height = 27
      Action = acOpenSettings
      Font.Charset = SYMBOL_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Webdings'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
  end
  object Panel2: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 653
    Height = 21
    Align = alTop
    AutoSize = True
    BevelOuter = bvNone
    TabOrder = 3
    object lblDaniCaption: TLabel
      Left = 6
      Top = 4
      Width = 36
      Height = 13
      Caption = 'Дані за'
    end
    object dtpDate: TDateTimePicker
      Left = 45
      Top = 0
      Width = 105
      Height = 21
      Date = 41412.000000000000000000
      Time = 41412.000000000000000000
      TabOrder = 0
      OnChange = dtpDateChange
    end
  end
  object pnlBase: TPanel
    Left = 0
    Top = 71
    Width = 659
    Height = 69
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
  end
  object rgLayoutType: TDBRadioGroup
    AlignWithMargins = True
    Left = 6
    Top = 29
    Width = 647
    Height = 42
    Margins.Left = 6
    Margins.Top = 2
    Margins.Right = 6
    Margins.Bottom = 0
    Align = alTop
    Caption = 'Тип макету'
    Columns = 2
    DataField = 'Layout'
    DataSource = dsParams
    Items.Strings = (
      'Паливо за добу (макет 001)'
      'Корекція наростаючих (макет 102)')
    TabOrder = 1
    Values.Strings = (
      '0'
      '1')
    OnChange = rgLayoutTypeChange
  end
  object mmMain: TMainMenu
    Left = 160
    Top = 86
    object miDovPalyvo: TMenuItem
      Action = acShowFuelRefBook
    end
    object N1: TMenuItem
      Caption = 'Допомога'
      Enabled = False
      ShortCut = 112
    end
    object N2: TMenuItem
      Action = acClose
    end
  end
  object IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL
    Destination = ':25'
    MaxLineAction = maException
    Port = 25
    DefaultPort = 0
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 270
    Top = 86
  end
  object dsParams: TDataSource
    DataSet = dmMain.cdsParams
    Left = 108
    Top = 84
  end
  object ActionList: TActionList
    OnUpdate = ActionListUpdate
    Left = 384
    Top = 84
    object acClose: TAction
      Caption = 'Вихід'
      OnExecute = acCloseExecute
    end
    object acSendInfo: TAction
      Caption = 'Відіслати дані'
      OnExecute = acSendInfoExecute
    end
    object acOpenSettings: TAction
      Caption = '@'
      OnExecute = acOpenSettingsExecute
    end
    object acShowFuelRefBook: TAction
      Caption = 'Довідник видів палива'
      OnExecute = acShowFuelRefBookExecute
    end
  end
  object IdSMTP: TIdSMTP
    IOHandler = IdSSLIOHandlerSocketOpenSSL1
    SASLMechanisms = <>
    Left = 440
    Top = 87
  end
  object IdMessage: TIdMessage
    AttachmentEncoding = 'UUE'
    BccList = <>
    CCList = <>
    Encoding = meDefault
    FromList = <
      item
      end>
    Recipients = <>
    ReplyTo = <>
    ConvertPreamble = True
    Left = 488
    Top = 87
  end
end
