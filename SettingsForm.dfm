object setGameForm: TsetGameForm
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1080#1075#1088#1086#1074#1086#1075#1086' '#1087#1088#1086#1094#1077#1089#1089#1072
  ClientHeight = 188
  ClientWidth = 473
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 38
    Width = 242
    Height = 13
    Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1076#1088#1091#1075#1080#1093' '#1080#1075#1088#1086#1082#1086#1074' (n <= 4 and n > 0):'
  end
  object Label3: TLabel
    Left = 53
    Top = 65
    Width = 197
    Height = 13
    Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1082#1088#1091#1075#1086#1074' (n <= 4 and n > 0):'
  end
  object Label2: TLabel
    Left = 146
    Top = 119
    Width = 104
    Height = 13
    Caption = #1053#1072#1095#1072#1083#1100#1085#1072#1103' '#1083#1086#1082#1072#1094#1080#1103':'
  end
  object Label5: TLabel
    Left = 155
    Top = 11
    Width = 95
    Height = 13
    Caption = #1042#1072#1096#1077' '#1080#1075#1088#1086#1074#1086#1077' '#1080#1084#1103':'
  end
  object Label4: TLabel
    Left = 45
    Top = 92
    Width = 205
    Height = 13
    Caption = #1048#1075#1088#1072' '#1085#1072#1095#1085#1105#1090#1089#1103' '#1095#1077#1088#1077#1079' (n <= 3 and n > 0):'
  end
  object countBots: TEdit
    Left = 256
    Top = 35
    Width = 27
    Height = 21
    Alignment = taCenter
    MaxLength = 1
    NumbersOnly = True
    TabOrder = 0
    Text = '2'
  end
  object countLoop: TEdit
    Left = 256
    Top = 62
    Width = 27
    Height = 21
    Alignment = taCenter
    MaxLength = 1
    NumbersOnly = True
    TabOrder = 1
    Text = '2'
  end
  object setCustomSettings: TButton
    Left = 326
    Top = 157
    Width = 139
    Height = 25
    Caption = #1055#1088#1080#1085#1103#1090#1100' '#1085#1072#1089#1090#1088#1086#1081#1082#1080
    TabOrder = 2
    OnClick = setCustomSettingsClick
  end
  object setDefaultSettings: TButton
    Left = 160
    Top = 157
    Width = 160
    Height = 25
    Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1087#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
    TabOrder = 3
    OnClick = setDefaultSettingsClick
  end
  object selectLVL: TComboBox
    Left = 256
    Top = 116
    Width = 211
    Height = 22
    Style = csOwnerDrawFixed
    TabOrder = 4
    Items.Strings = (
      #1059#1088#1086#1074#1077#1085#1100' '#1087#1077#1088#1074#1099#1081': "'#1054#1090#1073#1086#1088#1086#1095#1085#1099#1081' '#1090#1091#1088'"'
      #1059#1088#1086#1074#1077#1085#1100' '#1074#1090#1086#1088#1086#1081': "'#1069#1090#1072#1087' '#1074' '#1057#1086#1095#1080'"'
      #1059#1088#1086#1074#1077#1085#1100' '#1090#1088#1077#1090#1080#1081': "'#39#1069#1090#1072#1087' '#1074' '#1053#1086#1074#1086#1089#1080#1073#1080#1088#1089#1082#1077'"'
      #1059#1088#1086#1074#1077#1085#1100' '#1095#1077#1090#1074#1077#1088#1090#1099#1081': "'#39#1069#1090#1072#1087' '#1074' '#1059#1092#1077'"'
      #1059#1088#1086#1074#1077#1085#1100' '#1087#1103#1090#1099#1081': "'#39#1060#1080#1085#1072#1083'!"')
  end
  object nikName: TEdit
    Left = 256
    Top = 8
    Width = 121
    Height = 21
    MaxLength = 25
    TabOrder = 5
    Text = 'Name'
  end
  object timeOut: TEdit
    Left = 256
    Top = 89
    Width = 27
    Height = 21
    Alignment = taCenter
    MaxLength = 1
    NumbersOnly = True
    TabOrder = 6
    Text = '3'
  end
end
