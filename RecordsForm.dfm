object tableOfRecords: TtableOfRecords
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = #1056#1077#1082#1086#1088#1076#1099' '#1080#1075#1088#1099
  ClientHeight = 297
  ClientWidth = 727
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object grFiles: TGroupBox
    Left = 8
    Top = 8
    Width = 297
    Height = 281
    Caption = #1060#1072#1081#1083#1099' '#1088#1091#1079#1077#1083#1100#1090#1072#1090#1086#1074':'
    TabOrder = 0
    object lsFiles: TListBox
      Left = 3
      Top = 16
      Width = 291
      Height = 262
      ItemHeight = 13
      ParentShowHint = False
      PopupMenu = lsMenu
      ShowHint = True
      TabOrder = 0
      OnDblClick = lsFilesDblClick
    end
  end
  object grResults: TGroupBox
    Left = 311
    Top = 8
    Width = 407
    Height = 281
    Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090':'
    TabOrder = 1
    object mResults: TMemo
      Left = 3
      Top = 16
      Width = 400
      Height = 262
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
  object lsMenu: TPopupMenu
    Left = 24
    Top = 40
    object deleteResult: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1074#1099#1073#1088#1072#1085#1085#1099#1081' '#1088#1077#1079#1091#1083#1100#1090#1072#1090
      OnClick = deleteResultClick
    end
  end
end
