object frmAnother: TfrmAnother
  Left = 0
  Top = 0
  Caption = 'My Another Window'
  ClientHeight = 118
  ClientWidth = 243
  Color = 8967591
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object btnQuit: TButton
    Left = 76
    Top = 46
    Width = 95
    Height = 29
    Caption = 'Quit'
    Default = True
    TabOrder = 0
    OnClick = btnQuitClick
  end
end
