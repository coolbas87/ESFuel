object frmFuelTypesRef: TfrmFuelTypesRef
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Довідник видів палива'
  ClientHeight = 324
  ClientWidth = 294
  Color = clBtnFace
  Constraints.MinHeight = 352
  Constraints.MinWidth = 300
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 294
    Height = 287
    Align = alClient
    DataSource = dsFuelRef
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleHotTrack]
    ReadOnly = True
    TabOrder = 0
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
        FieldName = 'Name'
        Visible = True
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 287
    Width = 294
    Height = 37
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      294
      37)
    object bClose: TButton
      Left = 213
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Закрити'
      ModalResult = 8
      TabOrder = 0
    end
  end
  object dsFuelRef: TDataSource
    Left = 24
    Top = 16
  end
end
