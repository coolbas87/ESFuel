object frmSelectStation: TfrmSelectStation
  Left = 0
  Top = 0
  AutoSize = True
  BorderStyle = bsDialog
  Caption = 'frmSelectStation'
  ClientHeight = 77
  ClientWidth = 277
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
  object Label1: TLabel
    AlignWithMargins = True
    Left = 6
    Top = 6
    Width = 265
    Height = 13
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 2
    Align = alTop
    AutoSize = False
    Caption = 'Станція'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
    ExplicitLeft = 1
    ExplicitTop = 1
    ExplicitWidth = 200
  end
  object Panel1: TPanel
    Left = 0
    Top = 44
    Width = 277
    Height = 33
    Align = alTop
    TabOrder = 0
    DesignSize = (
      277
      33)
    object Button1: TButton
      Left = 121
      Top = 2
      Width = 75
      Height = 25
      Action = acOK
      Anchors = [akTop, akRight]
      Default = True
      TabOrder = 0
    end
    object Button2: TButton
      Left = 196
      Top = 2
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Відміна'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object lcbStation: TDBLookupComboBox
    AlignWithMargins = True
    Left = 6
    Top = 21
    Width = 265
    Height = 21
    Margins.Left = 6
    Margins.Top = 0
    Margins.Right = 6
    Margins.Bottom = 2
    Align = alTop
    DataField = 'stIDName'
    DataSource = dsSource
    NullValueKey = 46
    TabOrder = 1
  end
  object dsSource: TDataSource
    Left = 22
    Top = 28
  end
  object ActionList: TActionList
    OnUpdate = ActionListUpdate
    Left = 78
    Top = 30
    object acClose: TAction
      Caption = 'Відміна'
      OnExecute = acCloseExecute
    end
    object acOK: TAction
      Caption = 'OK'
      OnExecute = acOKExecute
    end
  end
end
