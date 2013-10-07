object dmMain: TdmMain
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 223
  Width = 284
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
      FieldName = 'Name'
      Size = 100
    end
    object cdsEnObjCoal: TBooleanField
      FieldName = 'Coal'
    end
    object cdsEnObjMasut: TBooleanField
      FieldName = 'Masut'
    end
    object cdsEnObjGas: TBooleanField
      FieldName = 'Gas'
    end
    object cdsEnObjOtherOrg: TBooleanField
      FieldName = 'OtherOrg'
    end
    object cdsEnObjFilename: TStringField
      FieldName = 'Filename'
      Size = 10
    end
    object cdsEnObjCoalCode: TIntegerField
      FieldName = 'CoalCode'
      DisplayFormat = '000'
      EditFormat = '000'
    end
    object cdsEnObjMasutCode: TIntegerField
      FieldName = 'MasutCode'
      DisplayFormat = '000'
      EditFormat = '000'
    end
    object cdsEnObjGasCode: TIntegerField
      FieldName = 'GasCode'
      DisplayFormat = '000'
      EditFormat = '000'
    end
  end
  object dsStationsRef: TDataSource
    DataSet = cdsStationsRef
    Left = 48
    Top = 64
  end
end
