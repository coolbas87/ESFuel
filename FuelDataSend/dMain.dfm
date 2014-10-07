object dmMain: TdmMain
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 258
  Width = 498
  object dsStationsRef: TDataSource
    DataSet = mtStationsRef
    Left = 184
    Top = 56
  end
  object dsEnObj: TDataSource
    DataSet = mtEnObj
    Left = 272
    Top = 56
  end
  object mtFuelRef: TFDMemTable
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
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    StoreDefs = True
    Left = 96
    Top = 8
    object mtFuelRefCode: TIntegerField
      DisplayLabel = 'Код'
      FieldName = 'Code'
      DisplayFormat = '#000'
      EditFormat = '#000'
    end
    object mtFuelRefName: TStringField
      DisplayLabel = 'Назва'
      DisplayWidth = 30
      FieldName = 'Name'
      Size = 100
    end
    object mtFuelRefIsActive: TBooleanField
      DefaultExpression = '''False'''
      FieldName = 'IsActive'
    end
  end
  object mtFuelRefClone: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    StoreDefs = True
    Left = 96
    Top = 64
    object IntegerField1: TIntegerField
      DisplayLabel = 'Код'
      FieldName = 'Code'
      DisplayFormat = '#000'
      EditFormat = '#000'
    end
    object StringField1: TStringField
      DisplayLabel = 'Назва'
      DisplayWidth = 30
      FieldName = 'Name'
      Size = 100
    end
    object BooleanField1: TBooleanField
      DefaultExpression = '''False'''
      FieldName = 'IsActive'
    end
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 40
    Top = 144
  end
  object mtStationsRef: TFDMemTable
    IndexFieldNames = 'stID'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 184
    Top = 8
    object mtStationsRefstID: TIntegerField
      FieldName = 'stID'
    end
    object mtStationsRefName: TStringField
      FieldName = 'Name'
      Size = 100
    end
  end
  object mtEnObj: TFDMemTable
    IndexFieldNames = 'ID'
    MasterSource = dsStationsRef
    MasterFields = 'stID'
    DetailFields = 'ID'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 272
    Top = 8
    object mtEnObjID: TIntegerField
      FieldName = 'ID'
    end
    object mtEnObjIDEnObj: TIntegerField
      FieldName = 'IDEnObj'
    end
    object mtEnObjCipher: TStringField
      FieldName = 'Cipher'
      Size = 5
    end
    object mtEnObjName: TStringField
      DisplayWidth = 25
      FieldName = 'Name'
      Size = 100
    end
    object mtEnObjFilename: TStringField
      FieldName = 'Filename'
      Size = 10
    end
  end
  object mtFuelTypes: TFDMemTable
    OnNewRecord = mtFuelTypesNewRecord
    IndexFieldNames = 'IDEnObj'
    MasterSource = dsEnObj
    MasterFields = 'IDEnObj'
    DetailFields = 'IDEnObj'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 352
    Top = 8
    object mtFuelTypesIDEnObj: TIntegerField
      FieldName = 'IDEnObj'
    end
    object mtFuelTypesCode: TIntegerField
      FieldName = 'Code'
      DisplayFormat = '000'
      EditFormat = '000'
    end
  end
  object mtStationData: TFDMemTable
    OnNewRecord = mtStationDataNewRecord
    FieldDefs = <
      item
        Name = 'IDEnObj'
        DataType = ftInteger
      end
      item
        Name = 'Code'
        DataType = ftInteger
      end
      item
        Name = 'Income'
        DataType = ftInteger
      end
      item
        Name = 'Costs'
        DataType = ftInteger
      end
      item
        Name = 'Remains'
        DataType = ftInteger
      end>
    IndexDefs = <>
    IndexFieldNames = 'IDEnObj'
    MasterSource = dsEnObj
    MasterFields = 'IDEnObj'
    DetailFields = 'IDEnObj'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    StoreDefs = True
    Left = 432
    Top = 8
    object mtStationDataIDEnObj: TIntegerField
      DefaultExpression = '0'
      DisplayLabel = 'Станція'
      FieldName = 'IDEnObj'
      Required = True
    end
    object mtStationDataCode: TIntegerField
      DisplayLabel = 'Код палива'
      FieldName = 'Code'
      Required = True
      DisplayFormat = '000'
      EditFormat = '000'
    end
    object mtStationDataCodeName: TStringField
      DisplayLabel = 'Паливо'
      DisplayWidth = 25
      FieldKind = fkLookup
      FieldName = 'CodeName'
      LookupDataSet = mtFuelRefClone
      LookupKeyFields = 'Code'
      LookupResultField = 'Name'
      KeyFields = 'Code'
      Required = True
      Size = 1024
      Lookup = True
    end
    object mtStationDataIncome: TIntegerField
      DefaultExpression = '0'
      DisplayLabel = 'Прихід'
      FieldName = 'Income'
      Required = True
    end
    object mtStationDataCosts: TIntegerField
      DefaultExpression = '0'
      DisplayLabel = 'Витрати'
      FieldName = 'Costs'
      Required = True
    end
    object mtStationDataRemains: TIntegerField
      DefaultExpression = '0'
      DisplayLabel = 'Залишки'
      FieldName = 'Remains'
      Required = True
    end
  end
  object mtParams: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 24
    Top = 8
    object mtParamsstID: TIntegerField
      DisplayLabel = 'Станція'
      FieldName = 'stID'
      Required = True
    end
    object mtParamsstIDName: TStringField
      DisplayLabel = 'Станція'
      FieldKind = fkLookup
      FieldName = 'stIDName'
      LookupDataSet = mtStationsRef
      LookupKeyFields = 'stID'
      LookupResultField = 'Name'
      KeyFields = 'stID'
      Required = True
      Size = 100
      Lookup = True
    end
    object mtParamsLayout: TIntegerField
      FieldName = 'Layout'
      OnChange = mtParamsLayoutChange
    end
    object mtParamsDataDate: TDateTimeField
      FieldName = 'DataDate'
      OnChange = mtParamsDataDateChange
      OnValidate = mtParamsDataDateValidate
    end
    object mtParamsEmailFrom: TStringField
      FieldName = 'EmailFrom'
      Size = 200
    end
    object mtParamsEmailTo: TStringField
      DefaultExpression = '''data@rdc.centre.energy.gov.ua'''
      FieldName = 'EmailTo'
      Size = 200
    end
    object mtParamsEmailSubject: TStringField
      DefaultExpression = '''//palyvo'''
      FieldName = 'EmailSubject'
      Size = 200
    end
    object mtParamsUseSecurityConn: TBooleanField
      DefaultExpression = '''False'''
      FieldName = 'UseSecurityConn'
      OnChange = mtParamsUseSecurityConnChange
    end
    object mtParamsMailSrvHost: TStringField
      FieldName = 'MailSrvHost'
      Size = 255
    end
    object mtParamsMailSrvPort: TIntegerField
      DefaultExpression = '25'
      FieldName = 'MailSrvPort'
    end
    object mtParamsMailSrvLogin: TStringField
      FieldName = 'MailSrvLogin'
      Size = 255
    end
    object mtParamsMailSrvPaswd: TStringField
      FieldName = 'MailSrvPaswd'
      Size = 255
    end
  end
  object mtEnObjClone: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 272
    Top = 104
    object mtEnObjCloneID: TIntegerField
      FieldName = 'ID'
    end
    object mtEnObjCloneIDEnObj: TIntegerField
      FieldName = 'IDEnObj'
    end
    object mtEnObjCloneCipher: TStringField
      FieldName = 'Cipher'
      Size = 5
    end
    object mtEnObjCloneName: TStringField
      DisplayWidth = 25
      FieldName = 'Name'
      Size = 100
    end
    object mtEnObjCloneFilename: TStringField
      FieldName = 'Filename'
      Size = 10
    end
  end
  object mtStationDataClone: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 432
    Top = 64
    object mtStationDataCloneIDEnObj: TIntegerField
      DefaultExpression = '0'
      DisplayLabel = 'Станція'
      FieldName = 'IDEnObj'
      Required = True
    end
    object mtStationDataCloneEnObjName: TStringField
      DisplayLabel = 'Станція'
      DisplayWidth = 25
      FieldKind = fkLookup
      FieldName = 'EnObjName'
      LookupDataSet = mtEnObjClone
      LookupKeyFields = 'IDEnObj'
      LookupResultField = 'Name'
      KeyFields = 'IDEnObj'
      Size = 100
      Lookup = True
    end
    object mtStationDataCloneCode: TIntegerField
      DisplayLabel = 'Код палива'
      FieldName = 'Code'
      Required = True
      DisplayFormat = '000'
      EditFormat = '000'
    end
    object mtStationDataCloneCodeName: TStringField
      DisplayLabel = 'Паливо'
      DisplayWidth = 25
      FieldKind = fkLookup
      FieldName = 'CodeName'
      LookupDataSet = mtFuelRefClone
      LookupKeyFields = 'Code'
      LookupResultField = 'Name'
      KeyFields = 'Code'
      Required = True
      Size = 1024
      Lookup = True
    end
    object mtStationDataCloneIncome: TIntegerField
      DefaultExpression = '0'
      DisplayLabel = 'Прихід'
      FieldName = 'Income'
      Required = True
    end
    object mtStationDataCloneCosts: TIntegerField
      DefaultExpression = '0'
      DisplayLabel = 'Витрати'
      FieldName = 'Costs'
      Required = True
    end
    object mtStationDataCloneRemains: TIntegerField
      DefaultExpression = '0'
      DisplayLabel = 'Залишки'
      FieldName = 'Remains'
      Required = True
    end
  end
end
