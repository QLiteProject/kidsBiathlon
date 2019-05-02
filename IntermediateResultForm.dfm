object resultOfLVL: TresultOfLVL
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = #1055#1088#1086#1084#1077#1078#1091#1090#1086#1095#1085#1099#1077' '#1088#1077#1079#1091#1083#1100#1090#1072#1090#1099
  ClientHeight = 338
  ClientWidth = 417
  Color = clBtnFace
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
  object resultMemo: TMemo
    Left = 9
    Top = 8
    Width = 400
    Height = 293
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object saveResult: TButton
    Left = 8
    Top = 305
    Width = 177
    Height = 25
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1088#1077#1079#1091#1083#1100#1090#1072#1090' '#1074' '#1092#1072#1081#1083
    Enabled = False
    TabOrder = 1
    OnClick = saveResultClick
  end
  object nextLvl: TButton
    Left = 232
    Top = 305
    Width = 177
    Height = 25
    Caption = #1057#1083#1077#1076#1091#1102#1097#1080#1081' '#1091#1088#1086#1074#1077#1085#1100
    TabOrder = 2
    OnClick = nextLvlClick
  end
end
