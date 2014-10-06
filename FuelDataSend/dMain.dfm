object dmMain: TdmMain
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 258
  Width = 438
  object cdsStationsRef: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <>
    IndexFieldNames = 'stID'
    Params = <>
    StoreDefs = True
    Left = 48
    Top = 18
    object cdsStationsRefstID: TIntegerField
      FieldName = 'stID'
    end
    object cdsStationsRefName: TStringField
      FieldName = 'Name'
      Size = 100
    end
  end
  object cdsFuelRef: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'Code'
        DataType = ftInteger
      end
      item
        Name = 'Name'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'IsActive'
        DataType = ftBoolean
      end>
    IndexDefs = <>
    IndexFieldNames = 'Code'
    Params = <>
    StoreDefs = True
    Left = 126
    Top = 18
    object cdsFuelRefCode: TIntegerField
      DisplayLabel = 'Код'
      FieldName = 'Code'
      DisplayFormat = '#000'
      EditFormat = '#000'
    end
    object cdsFuelRefName: TStringField
      DisplayLabel = 'Назва'
      DisplayWidth = 30
      FieldName = 'Name'
      Size = 100
    end
    object cdsFuelRefIsActive: TBooleanField
      DefaultExpression = '''False'''
      FieldName = 'IsActive'
    end
  end
  object cdsParams: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 48
    Top = 112
    object cdsParamsstID: TIntegerField
      DisplayLabel = 'Станція'
      FieldName = 'stID'
      Required = True
    end
    object cdsParamsstIDName: TStringField
      DisplayLabel = 'Станція'
      FieldKind = fkLookup
      FieldName = 'stIDName'
      LookupDataSet = cdsStationsRef
      LookupKeyFields = 'stID'
      LookupResultField = 'Name'
      KeyFields = 'stID'
      Required = True
      Size = 100
      Lookup = True
    end
    object cdsParamsLayout: TIntegerField
      FieldName = 'Layout'
      OnChange = cdsParamsLayoutChange
    end
    object cdsParamsDataDate: TDateTimeField
      FieldName = 'DataDate'
      OnChange = cdsParamsDataDateChange
      OnValidate = cdsParamsDataDateValidate
    end
    object cdsParamsEmailFrom: TStringField
      FieldName = 'EmailFrom'
      Size = 200
    end
    object cdsParamsEmailTo: TStringField
      DefaultExpression = '''data@rdc.centre.energy.gov.ua'''
      FieldName = 'EmailTo'
      Size = 200
    end
    object cdsParamsEmailSubject: TStringField
      DefaultExpression = '''//palyvo'''
      FieldName = 'EmailSubject'
      Size = 200
    end
    object cdsParamsUseSecurityConn: TBooleanField
      DefaultExpression = '''False'''
      FieldName = 'UseSecurityConn'
      OnChange = cdsParamsUseSecurityConnChange
    end
    object cdsParamsMailSrvHost: TStringField
      FieldName = 'MailSrvHost'
      Size = 255
    end
    object cdsParamsMailSrvPort: TIntegerField
      DefaultExpression = '25'
      FieldName = 'MailSrvPort'
    end
    object cdsParamsMailSrvLogin: TStringField
      FieldName = 'MailSrvLogin'
      Size = 255
    end
    object cdsParamsMailSrvPaswd: TStringField
      FieldName = 'MailSrvPaswd'
      Size = 255
    end
  end
  object cdsEnObj: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <>
    IndexFieldNames = 'ID'
    MasterFields = 'stID'
    MasterSource = dsStationsRef
    PacketRecords = 0
    Params = <>
    StoreDefs = True
    Left = 126
    Top = 72
    object cdsEnObjID: TIntegerField
      FieldName = 'ID'
    end
    object cdsEnObjIDEnObj: TIntegerField
      FieldName = 'IDEnObj'
    end
    object cdsEnObjCipher: TStringField
      FieldName = 'Cipher'
      Size = 5
    end
    object cdsEnObjName: TStringField
      DisplayWidth = 25
      FieldName = 'Name'
      Size = 100
    end
    object cdsEnObjFilename: TStringField
      FieldName = 'Filename'
      Size = 10
    end
  end
  object dsStationsRef: TDataSource
    DataSet = cdsStationsRef
    Left = 48
    Top = 64
  end
  object cdsStationData: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <>
    IndexFieldNames = 'IDEnObj'
    Params = <>
    StoreDefs = True
    OnNewRecord = cdsStationDataNewRecord
    Left = 344
    Top = 18
    object cdsStationDataIDEnObj: TIntegerField
      DefaultExpression = '0'
      DisplayLabel = 'Станція'
      FieldName = 'IDEnObj'
      Required = True
    end
    object cdsStationDataCode: TIntegerField
      DisplayLabel = 'Код палива'
      FieldName = 'Code'
      Required = True
      DisplayFormat = '000'
      EditFormat = '000'
    end
    object cdsStationDataCodeName: TStringField
      DisplayLabel = 'Паливо'
      DisplayWidth = 25
      FieldKind = fkLookup
      FieldName = 'CodeName'
      LookupDataSet = cdsFuelRefClone
      LookupKeyFields = 'Code'
      LookupResultField = 'Name'
      KeyFields = 'Code'
      Required = True
      Size = 1024
      Lookup = True
    end
    object cdsStationDataIncome: TIntegerField
      DefaultExpression = '0'
      DisplayLabel = 'Прихід'
      FieldName = 'Income'
      Required = True
    end
    object cdsStationDataCosts: TIntegerField
      DefaultExpression = '0'
      DisplayLabel = 'Витрати'
      FieldName = 'Costs'
      Required = True
    end
    object cdsStationDataRemains: TIntegerField
      DefaultExpression = '0'
      DisplayLabel = 'Залишки'
      FieldName = 'Remains'
      Required = True
    end
  end
  object cdsFuelRefClone: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 208
    Top = 16
  end
  object cdsFuelTypes: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <>
    IndexFieldNames = 'IDEnObj'
    MasterFields = 'IDEnObj'
    MasterSource = dsEnObj
    PacketRecords = 0
    Params = <>
    StoreDefs = True
    OnNewRecord = cdsFuelTypesNewRecord
    Left = 126
    Top = 176
    object cdsFuelTypesIDEnObj: TIntegerField
      FieldName = 'IDEnObj'
    end
    object cdsFuelTypesCode: TIntegerField
      FieldName = 'Code'
      DisplayFormat = '000'
      EditFormat = '000'
    end
  end
  object dsEnObj: TDataSource
    DataSet = cdsEnObj
    Left = 128
    Top = 128
  end
end
