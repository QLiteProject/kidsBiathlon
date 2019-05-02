object gameForm: TgameForm
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'BiathlonGameProject (pre-alpha)'
  ClientHeight = 174
  ClientWidth = 626
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object renderingBlock: TImage
    Left = 8
    Top = 8
    Width = 233
    Height = 153
  end
  object timePanel: TPanel
    Left = 247
    Top = 8
    Width = 369
    Height = 65
    TabOrder = 0
    object timeOut: TLabel
      Left = 318
      Top = 10
      Width = 16
      Height = 39
      Caption = '3'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -32
      Font.Name = 'Calibri Light'
      Font.Style = []
      ParentFont = False
    end
    object textTimeOut: TLabel
      Left = 22
      Top = 10
      Width = 290
      Height = 39
      Caption = #1048#1075#1088#1072' '#1085#1072#1095#1085#1105#1090#1089#1103' '#1095#1077#1088#1077#1079': '
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -32
      Font.Name = 'Calibri Light'
      Font.Style = []
      ParentFont = False
    end
  end
  object stepBot: TTimer
    Enabled = False
    Interval = 16
    OnTimer = stepBotTimer
    Left = 24
    Top = 24
  end
  object stepCharacter: TTimer
    Enabled = False
    Interval = 80
    OnTimer = stepCharacterTimer
    Left = 88
    Top = 24
  end
  object startGame: TTimer
    Enabled = False
    OnTimer = startGameTimer
    Left = 160
    Top = 24
  end
end
