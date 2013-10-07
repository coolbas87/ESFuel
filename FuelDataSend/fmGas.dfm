object frmGas: TfrmGas
  AlignWithMargins = True
  Left = 0
  Top = 0
  Width = 392
  Height = 21
  Margins.Left = 6
  Margins.Top = 2
  Margins.Right = 6
  Margins.Bottom = 0
  Constraints.MinHeight = 21
  Constraints.MinWidth = 392
  TabOrder = 0
  object Label1: TLabel
    Left = 0
    Top = 3
    Width = 131
    Height = 13
    Caption = '√аз (тис. м. куб./добу)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object edCosts: TDBEdit
    Left = 322
    Top = 0
    Width = 70
    Height = 21
    DataField = 'GasCosts'
    TabOrder = 1
  end
  object edCode: TDBEdit
    Left = 154
    Top = 0
    Width = 70
    Height = 21
    DataField = 'GasCode'
    TabOrder = 0
  end
end
