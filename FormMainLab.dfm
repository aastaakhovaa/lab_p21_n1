object FormMain: TFormMain
  Left = 457
  Top = 150
  Width = 850
  Height = 661
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Trie-'#1076#1077#1088#1077#1074#1086
  Color = clBtnFace
  Constraints.MinHeight = 660
  Constraints.MinWidth = 850
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object SplitterMain: TSplitter
    Left = 400
    Top = 0
    Height = 602
  end
  object PanelTree: TPanel
    Left = 0
    Top = 0
    Width = 400
    Height = 602
    Align = alLeft
    Caption = 'PanelTree'
    Constraints.MinWidth = 400
    TabOrder = 0
    object TreeView: TTreeView
      Left = 1
      Top = 1
      Width = 398
      Height = 600
      Align = alClient
      Indent = 19
      TabOrder = 0
    end
  end
  object PanelInformation: TPanel
    Left = 403
    Top = 0
    Width = 431
    Height = 602
    Align = alClient
    Constraints.MinWidth = 400
    TabOrder = 1
    object MemoResult: TMemo
      Left = 1
      Top = 401
      Width = 429
      Height = 200
      Align = alBottom
      ReadOnly = True
      TabOrder = 0
    end
  end
  object MainMenu: TMainMenu
    Left = 40
    Top = 72
    object mi_file: TMenuItem
      Caption = #1060#1072#1081#1083
      object mi_new: TMenuItem
        Action = act_new
      end
      object mi_open: TMenuItem
        Action = act_open
      end
      object mi_separator1: TMenuItem
        Caption = '-'
      end
      object mi_save: TMenuItem
        Action = act_save
      end
      object mi_saveas: TMenuItem
        Action = act_saveAs
      end
      object mi_separator2: TMenuItem
        Caption = '-'
      end
      object mi_close: TMenuItem
        Action = act_close
      end
      object mi_exit: TMenuItem
        Action = act_exit
      end
    end
    object mi_edit: TMenuItem
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077
      object mi_add: TMenuItem
        Action = act_add
      end
      object mi_delete: TMenuItem
        Action = act_delete
      end
      object mi_clear: TMenuItem
        Action = act_clear
      end
    end
    object mi_search: TMenuItem
      Action = act_search
    end
    object mi_task: TMenuItem
      Action = act_task
    end
  end
  object ActionList: TActionList
    Left = 8
    Top = 72
    object act_new: TAction
      Caption = #1053#1086#1074#1099#1081
      Hint = #1053#1086#1074#1099#1081
      ImageIndex = 1
      ShortCut = 16462
      OnExecute = act_newExecute
    end
    object act_open: TAction
      Caption = #1054#1090#1082#1088#1099#1090#1100
      Hint = #1054#1090#1082#1088#1099#1090#1100
      ImageIndex = 3
      ShortCut = 16463
      OnExecute = act_openExecute
    end
    object act_save: TAction
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      ImageIndex = 7
      ShortCut = 16467
      OnExecute = act_saveExecute
    end
    object act_saveAs: TAction
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1082#1072#1082'...'
      Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1082#1072#1082'...'
      ShortCut = 49235
      OnExecute = act_saveAsExecute
    end
    object act_close: TAction
      Caption = #1047#1072#1082#1088#1099#1090#1100
      Hint = #1047#1072#1082#1088#1099#1090#1100
      ImageIndex = 0
      ShortCut = 16457
      OnExecute = act_closeExecute
    end
    object act_exit: TAction
      Caption = #1042#1099#1093#1086#1076
      Hint = #1042#1099#1093#1086#1076
      ImageIndex = 2
      ShortCut = 16465
      OnExecute = act_exitExecute
    end
    object act_add: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1089#1083#1086#1074#1086
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1089#1083#1086#1074#1086
      ImageIndex = 6
      ShortCut = 116
      OnExecute = act_addExecute
    end
    object act_delete: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1089#1083#1086#1074#1086
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1089#1083#1086#1074#1086
      ImageIndex = 9
      ShortCut = 117
      OnExecute = act_deleteExecute
    end
    object act_clear: TAction
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100' '#1076#1077#1088#1077#1074#1086
      Hint = #1054#1095#1080#1089#1090#1080#1090#1100' '#1076#1077#1088#1077#1074#1086
      ImageIndex = 8
      ShortCut = 123
      OnExecute = act_clearExecute
    end
    object act_search: TAction
      Caption = #1055#1086#1080#1089#1082
      Hint = #1055#1086#1080#1089#1082
      ImageIndex = 5
      ShortCut = 16454
      OnExecute = act_searchExecute
    end
    object act_task: TAction
      Caption = #1047#1072#1076#1072#1095#1072
      Hint = #1047#1072#1076#1072#1095#1072
      ImageIndex = 4
      ShortCut = 16468
      OnExecute = act_taskExecute
    end
  end
  object ActionManager: TActionManager
    ActionBars = <
      item
      end
      item
        Items.CaptionOptions = coNone
        Items = <
          item
            Action = act_new
            ImageIndex = 1
            ShortCut = 16462
          end
          item
            Action = act_open
            ImageIndex = 3
            ShortCut = 16463
          end
          item
            Action = act_save
            ImageIndex = 7
            ShortCut = 16467
          end
          item
            Caption = '-'
          end
          item
            Action = act_add
            ImageIndex = 6
            ShortCut = 116
          end
          item
            Action = act_search
            ImageIndex = 5
            ShortCut = 16454
          end
          item
            Action = act_delete
            ImageIndex = 9
            ShortCut = 117
          end
          item
            Caption = '-'
          end
          item
            Action = act_task
            ImageIndex = 4
            ShortCut = 16468
          end
          item
            Action = act_clear
            ImageIndex = 8
            ShortCut = 123
          end
          item
            Caption = '-'
          end
          item
            Action = act_exit
            ImageIndex = 2
            ShortCut = 16465
          end>
      end
      item
        Items = <
          item
            Action = act_close
            ImageIndex = 0
            ShortCut = 16457
          end>
      end>
    LinkedActionLists = <
      item
        ActionList = ActionList
        Caption = 'ActionList'
      end>
    Left = 136
    Top = 112
    StyleName = 'XP Style'
  end
  object OpenDialog: TOpenDialog
    FileName = 
      'F:\YandexDisk\YandexDisk\Documents\Labs\delphi\2 SEM\lab2(n15)\L' +
      'ab2.res'
    Left = 8
    Top = 106
  end
  object SaveDialog: TSaveDialog
    Left = 40
    Top = 106
  end
end
