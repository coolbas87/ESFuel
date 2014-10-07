object frmSettings: TfrmSettings
  Left = 0
  Top = 0
  ActiveControl = edHost
  BorderStyle = bsDialog
  Caption = 'Налаштування'
  ClientHeight = 233
  ClientWidth = 341
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 2
    Top = 2
    Width = 168
    Height = 192
    Caption = 'Поштовий сервер'
    TabOrder = 0
    object Label1: TLabel
      Left = 6
      Top = 14
      Width = 37
      Height = 13
      Caption = 'С&ервер'
    end
    object Label4: TLabel
      Left = 6
      Top = 50
      Width = 25
      Height = 13
      Caption = 'П&орт'
      FocusControl = edPort
    end
    object Label5: TLabel
      Left = 6
      Top = 109
      Width = 26
      Height = 13
      Caption = 'Ло&гін'
      FocusControl = edLogin
    end
    object Label6: TLabel
      Left = 6
      Top = 147
      Width = 37
      Height = 13
      Caption = 'Па&роль'
      FocusControl = edPassword
    end
    object edPort: TDBEdit
      Left = 6
      Top = 66
      Width = 154
      Height = 21
      DataField = 'MailSrvPort'
      DataSource = dsParams
      TabOrder = 1
    end
    object chbUseScureConnection: TDBCheckBox
      Left = 6
      Top = 90
      Width = 149
      Height = 17
      Action = acToggleUseSecConnection
      DataField = 'UseSecurityConn'
      DataSource = dsParams
      TabOrder = 2
    end
    object edHost: TDBEdit
      Left = 6
      Top = 30
      Width = 154
      Height = 21
      DataField = 'MailSrvHost'
      DataSource = dsParams
      TabOrder = 0
    end
    object edLogin: TDBEdit
      Left = 6
      Top = 125
      Width = 154
      Height = 21
      DataField = 'MailSrvLogin'
      DataSource = dsParams
      TabOrder = 3
    end
    object edPassword: TDBEdit
      Left = 6
      Top = 163
      Width = 154
      Height = 21
      DataField = 'MailSrvPaswd'
      DataSource = dsParams
      PasswordChar = '*'
      TabOrder = 4
    end
  end
  object GroupBox2: TGroupBox
    Left = 176
    Top = 2
    Width = 161
    Height = 135
    Caption = 'Налаштування листа'
    TabOrder = 1
    object Label7: TLabel
      Left = 6
      Top = 14
      Width = 103
      Height = 13
      Caption = 'А&дреса відправника'
      FocusControl = edSenderEmail
    end
    object Label8: TLabel
      Left = 6
      Top = 50
      Width = 103
      Height = 13
      Caption = 'Адре&са одержувача'
      FocusControl = edRecipientEmail
    end
    object Label9: TLabel
      Left = 6
      Top = 90
      Width = 24
      Height = 13
      Caption = 'Те&ма'
      FocusControl = edSubject
    end
    object edSenderEmail: TDBEdit
      Left = 6
      Top = 30
      Width = 147
      Height = 21
      DataField = 'EmailFrom'
      DataSource = dsParams
      TabOrder = 0
    end
    object edRecipientEmail: TDBEdit
      Left = 6
      Top = 66
      Width = 147
      Height = 21
      DataField = 'EmailTo'
      DataSource = dsParams
      TabOrder = 1
    end
    object edSubject: TDBEdit
      Left = 6
      Top = 106
      Width = 147
      Height = 21
      DataField = 'EmailSubject'
      DataSource = dsParams
      TabOrder = 2
    end
  end
  object btCancel: TButton
    Left = 252
    Top = 202
    Width = 85
    Height = 25
    Cancel = True
    Caption = 'Відміна'
    ModalResult = 2
    TabOrder = 3
  end
  object btOK: TButton
    Left = 165
    Top = 202
    Width = 85
    Height = 25
    Caption = 'ОК'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object dsParams: TDataSource
    Left = 64
    Top = 64
  end
  object ActionList: TActionList
    Left = 130
    Top = 66
    object acToggleUseSecConnection: TAction
      Caption = 'Захищене з’єднання (SSL)'
      OnExecute = acToggleUseSecConnectionExecute
    end
  end
end
