object frmMasut: TfrmMasut
  AlignWithMargins = True
  Left = 0
  Top = 0
  Width = 560
  Height = 21
  Margins.Left = 6
  Margins.Top = 2
  Margins.Right = 6
  Margins.Bottom = 0
  Constraints.MinHeight = 21
  Constraints.MinWidth = 560
  TabOrder = 0
  object Label1: TLabel
    Left = 0
    Top = 3
    Width = 93
    Height = 13
    Caption = 'Мазут (т/добу)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object edCode: TDBEdit
    Left = 154
    Top = 0
    Width = 70
    Height = 21
    DataField = 'MasutCode'
    TabOrder = 0
  end
  object edIncome: TDBEdit
    Left = 238
    Top = 0
    Width = 70
    Height = 21
    DataField = 'MasutIncome'
    TabOrder = 1
  end
  object edCosts: TDBEdit
    Left = 322
    Top = 0
    Width = 70
    Height = 21
    DataField = 'MasutCosts'
    TabOrder = 2
  end
  object edRemains: TDBEdit
    Left = 406
    Top = 0
    Width = 70
    Height = 21
    DataField = 'MasutRemains'
    TabOrder = 3
  end
  object edOtherOrgRemains: TDBEdit
    Left = 490
    Top = 0
    Width = 70
    Height = 21
    DataField = 'MasutOtherOrgsRemains'
    TabOrder = 4
    Visible = False
  end
end
