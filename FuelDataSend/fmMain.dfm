object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'Передача даних палива у ЦЕС'
  ClientHeight = 322
  ClientWidth = 734
  Color = clBtnFace
  Constraints.MinHeight = 380
  Constraints.MinWidth = 750
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
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 282
    Width = 734
    Height = 40
    Align = alBottom
    TabOrder = 0
    DesignSize = (
      734
      40)
    object bExit: TButton
      Left = 653
      Top = 6
      Width = 75
      Height = 27
      Action = acClose
      Anchors = [akTop, akRight]
      Cancel = True
      TabOrder = 1
    end
    object bSend: TButton
      Left = 527
      Top = 6
      Width = 125
      Height = 27
      Action = acSendInfo
      Anchors = [akTop, akRight]
      Default = True
      TabOrder = 0
    end
  end
  object Panel2: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 728
    Height = 21
    Align = alTop
    AutoSize = True
    BevelOuter = bvNone
    TabOrder = 2
    object lblDaniCaption: TLabel
      Left = 7
      Top = 3
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
  object rgLayoutType: TDBRadioGroup
    AlignWithMargins = True
    Left = 6
    Top = 29
    Width = 722
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
  object pcMain: TPageControl
    Left = 0
    Top = 71
    Width = 734
    Height = 211
    ActivePage = tsStandartView
    Align = alClient
    MultiLine = True
    TabOrder = 3
    TabPosition = tpRight
    object tsStandartView: TTabSheet
      Caption = 'По станціях'
      object Splitter1: TSplitter
        Left = 185
        Top = 0
        Width = 6
        Height = 203
        Color = clBtnFace
        ParentColor = False
        ExplicitLeft = 182
        ExplicitTop = 81
        ExplicitHeight = 187
      end
      object DBGrid2: TDBGrid
        Left = 0
        Top = 0
        Width = 185
        Height = 203
        Align = alLeft
        DataSource = dsEnObj
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'Name'
            Visible = True
          end>
      end
      object DBGrid1: TDBGrid
        Left = 191
        Top = 0
        Width = 515
        Height = 203
        Align = alClient
        DataSource = dsStationData
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'Code'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CodeName'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Income'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Costs'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Remains'
            Visible = True
          end>
      end
    end
    object tsExtView: TTabSheet
      Caption = 'Загалом'
      ImageIndex = 1
      object grdStationDataClone: TDBGrid
        Left = 0
        Top = 0
        Width = 706
        Height = 203
        Align = alClient
        DataSource = dsStationDataClone
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'EnObjName'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CodeName'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Income'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Costs'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Remains'
            Visible = True
          end>
      end
    end
  end
  object mmMain: TMainMenu
    Left = 160
    Top = 86
    object miDovPalyvo: TMenuItem
      Action = acShowFuelRefBook
    end
    object N3: TMenuItem
      Action = acOpenSettings
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
  object dsParams: TDataSource
    DataSet = dmMain.mtParams
    Left = 108
    Top = 87
  end
  object ActionList: TActionList
    OnUpdate = ActionListUpdate
    Left = 384
    Top = 85
    object acClose: TAction
      Caption = 'Вихід'
      OnExecute = acCloseExecute
    end
    object acSendInfo: TAction
      Caption = 'Відіслати дані'
      OnExecute = acSendInfoExecute
    end
    object acOpenSettings: TAction
      Caption = 'Налаштування'
      OnExecute = acOpenSettingsExecute
    end
    object acShowFuelRefBook: TAction
      Caption = 'Довідник видів палива'
      OnExecute = acShowFuelRefBookExecute
    end
  end
  object dsStationData: TDataSource
    DataSet = dmMain.mtStationData
    Left = 48
    Top = 87
  end
  object dsEnObj: TDataSource
    DataSet = dmMain.mtEnObj
    Left = 48
    Top = 136
  end
  object dsStationDataClone: TDataSource
    DataSet = dmMain.mtStationDataClone
    Left = 116
    Top = 139
  end
end
