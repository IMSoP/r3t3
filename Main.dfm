object MainForm: TMainForm
  Left = 123
  Top = 130
  BorderStyle = bsSizeToolWin
  Caption = 'Ron'#39's Really Rubbish Time Tracking Tool'
  ClientHeight = 479
  ClientWidth = 520
  Color = clSkyBlue
  Constraints.MaxHeight = 505
  Constraints.MaxWidth = 528
  Constraints.MinHeight = 505
  Constraints.MinWidth = 528
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnMouseDown = FormMouseDown
  OnShortCut = FormShortCut
  PixelsPerInch = 96
  TextHeight = 13
  object AddButton: TSpeedButton
    Left = 8
    Top = 448
    Width = 91
    Height = 25
    Caption = 'Add Task'
    OnClick = AddButtonClick
  end
  object TasklessLabel: TLabel
    Left = 120
    Top = 458
    Width = 102
    Height = 13
    Caption = 'Un-assigned time:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object SaveButton: TSpeedButton
    Left = 320
    Top = 450
    Width = 57
    Height = 23
    Caption = 'Save...'
    OnClick = SaveButtonClick
  end
  object LoadButton: TSpeedButton
    Left = 383
    Top = 450
    Width = 57
    Height = 23
    Caption = 'Load...'
    OnClick = LoadButtonClick
  end
  object FilenameLabel: TLabel
    Left = 312
    Top = 431
    Width = 200
    Height = 13
    AutoSize = False
  end
  inline TasklessTime: TEditableTime
    Left = 224
    Top = 450
    Width = 70
    Height = 24
    TabOrder = 0
    TabStop = True
    ExplicitLeft = 224
    ExplicitTop = 450
  end
  object AutoSaveCheck: TCheckBox
    Left = 446
    Top = 454
    Width = 97
    Height = 17
    Caption = 'Auto-Save'
    Checked = True
    Enabled = False
    State = cbChecked
    TabOrder = 1
  end
  object TickTimer: TTimer
    OnTimer = TickTimerTimer
    Left = 8
    Top = 8
  end
  object Killer: TTimer
    Enabled = False
    Interval = 10
    OnTimer = KillerTimer
    Left = 40
    Top = 8
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = '.tsv'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 72
    Top = 8
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '.tsv'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 104
    Top = 8
  end
  object AutoSaveTimer: TTimer
    Interval = 60000
    OnTimer = AutoSaveTimerTimer
    Left = 136
    Top = 8
  end
end
