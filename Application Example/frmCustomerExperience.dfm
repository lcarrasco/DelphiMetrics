object frm_CustomerExperience: Tfrm_CustomerExperience
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Help us improve the next version of our software'
  ClientHeight = 233
  ClientWidth = 480
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object lblTitle: TLabel
    Left = 24
    Top = 24
    Width = 347
    Height = 19
    Caption = 'Help us improve the next version of our software'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 12349458
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lblText: TLabel
    Left = 24
    Top = 52
    Width = 435
    Height = 56
    Caption = 
      'The program collects information about computer hardware and how' +
      ' you use this software, without interrupting you. This helps our' +
      ' company identify which features to improve. No information is u' +
      'sed to identify or contact you (anonymous data).'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object lblPrivacy: TLabel
    Left = 24
    Top = 199
    Width = 136
    Height = 13
    Caption = 'Company Privacy Statement'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsUnderline]
    ParentFont = False
  end
  object rbYes: TRadioButton
    Left = 24
    Top = 130
    Width = 433
    Height = 17
    Caption = 'I want to participate!'
    Checked = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    TabStop = True
  end
  object rbNo: TRadioButton
    Left = 24
    Top = 151
    Width = 433
    Height = 17
    Caption = 'I don'#39't want to participate.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object btnOK: TButton
    Left = 276
    Top = 194
    Width = 88
    Height = 25
    Caption = 'OK'
    TabOrder = 2
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 370
    Top = 194
    Width = 87
    Height = 25
    Caption = 'Cancel'
    TabOrder = 3
    OnClick = btnCancelClick
  end
end
