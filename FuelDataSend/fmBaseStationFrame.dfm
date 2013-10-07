object frmBaseStationFrame: TfrmBaseStationFrame
  AlignWithMargins = True
  Left = 0
  Top = 0
  Width = 727
  Height = 160
  Margins.Left = 6
  Margins.Top = 6
  Margins.Right = 6
  Margins.Bottom = 0
  Color = clBtnFace
  ParentBackground = False
  ParentColor = False
  TabOrder = 0
  object lblStationName: TLabel
    AlignWithMargins = True
    Left = 6
    Top = 9
    Width = 715
    Height = 13
    Margins.Left = 6
    Margins.Top = 2
    Margins.Right = 6
    Margins.Bottom = 0
    Align = alTop
    Alignment = taCenter
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
    ExplicitWidth = 3
  end
  object Bevel1: TBevel
    AlignWithMargins = True
    Left = 6
    Top = 0
    Width = 715
    Height = 7
    Margins.Left = 6
    Margins.Top = 0
    Margins.Right = 6
    Margins.Bottom = 0
    Align = alTop
    Shape = bsTopLine
    ExplicitLeft = 0
    ExplicitWidth = 644
  end
  object pnlLabels: TPanel
    AlignWithMargins = True
    Left = 6
    Top = 43
    Width = 715
    Height = 13
    Margins.Left = 6
    Margins.Top = 2
    Margins.Right = 6
    Margins.Bottom = 0
    Align = alTop
    AutoSize = True
    BevelOuter = bvNone
    TabOrder = 0
    object Label2: TLabel
      Left = 154
      Top = 0
      Width = 33
      Height = 13
      Caption = 'Шифр'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 238
      Top = 0
      Width = 40
      Height = 13
      Caption = 'Прихід'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 322
      Top = 0
      Width = 47
      Height = 13
      Caption = 'Витрати'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 406
      Top = 0
      Width = 50
      Height = 13
      Caption = 'Залишок'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblOtherOrgs: TLabel
      Left = 490
      Top = 0
      Width = 108
      Height = 13
      Caption = 'Залишки стор. орг.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object chbSendData: TDBCheckBox
    AlignWithMargins = True
    Left = 6
    Top = 24
    Width = 715
    Height = 17
    Margins.Left = 6
    Margins.Top = 2
    Margins.Right = 6
    Margins.Bottom = 0
    Align = alTop
    Caption = 'Відправляти дані по цій станції'
    DataField = 'IsSendData'
    DataSource = dsStationData
    TabOrder = 1
  end
  object cdsStationData: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 48
    Top = 42
    object cdsStationDataCoalCode: TIntegerField
      DefaultExpression = '041'
      FieldName = 'CoalCode'
      Required = True
      DisplayFormat = '000'
      EditFormat = '000'
    end
    object cdsStationDataCoalIncome: TIntegerField
      DefaultExpression = '0'
      FieldName = 'CoalIncome'
      Required = True
    end
    object cdsStationDataCoalCosts: TIntegerField
      DefaultExpression = '0'
      FieldName = 'CoalCosts'
      Required = True
    end
    object cdsStationDataCoalRemains: TIntegerField
      DefaultExpression = '0'
      FieldName = 'CoalRemains'
      Required = True
    end
    object cdsStationDataMasutCode: TIntegerField
      DefaultExpression = '055'
      FieldName = 'MasutCode'
      Required = True
      DisplayFormat = '000'
      EditFormat = '000'
    end
    object cdsStationDataMasutIncome: TIntegerField
      DefaultExpression = '0'
      FieldName = 'MasutIncome'
      Required = True
    end
    object cdsStationDataMasutCosts: TIntegerField
      DefaultExpression = '0'
      FieldName = 'MasutCosts'
      Required = True
    end
    object cdsStationDataMasutRemains: TIntegerField
      DefaultExpression = '0'
      FieldName = 'MasutRemains'
      Required = True
    end
    object cdsStationDataMasutOtherOrgsRemains: TIntegerField
      DefaultExpression = '0'
      FieldName = 'MasutOtherOrgsRemains'
      Required = True
    end
    object cdsStationDataGasCode: TIntegerField
      DefaultExpression = '065'
      FieldName = 'GasCode'
      Required = True
      DisplayFormat = '000'
      EditFormat = '000'
    end
    object cdsStationDataGasCosts: TIntegerField
      DefaultExpression = '0'
      FieldName = 'GasCosts'
      Required = True
    end
    object cdsStationDataIsSendData: TBooleanField
      DefaultExpression = '''True'''
      FieldName = 'IsSendData'
    end
  end
  object dsStationData: TDataSource
    DataSet = cdsStationData
    Left = 126
    Top = 42
  end
end
