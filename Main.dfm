object MainForm: TMainForm
  Left = 123
  Top = 130
  BorderStyle = bsSizeToolWin
  Caption = 'Rowan'#39's Really Rubbish Time Tracking Tool'
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
  Position = poScreenCenter
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnMouseDown = FormMouseDown
  OnShortCut = FormShortCut
  PixelsPerInch = 96
  TextHeight = 13
  object AddButton: TSpeedButton
    Left = 3
    Top = 449
    Width = 111
    Height = 25
    Caption = 'Add Task'
    OnClick = AddButtonClick
  end
  object TasklessLabel: TLabel
    Left = 170
    Top = 453
    Width = 58
    Height = 16
    Caption = 'Paused:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object SaveButton: TSpeedButton
    Left = 4
    Top = 421
    Width = 49
    Height = 23
    Caption = 'Save...'
    OnClick = SaveButtonClick
  end
  object LoadButton: TSpeedButton
    Left = 57
    Top = 421
    Width = 57
    Height = 23
    Caption = 'Load...'
    OnClick = LoadButtonClick
  end
  object FilenameLabel: TLabel
    Left = 208
    Top = 426
    Width = 304
    Height = 13
    AutoSize = False
    EllipsisPosition = epPathEllipsis
  end
  object TotalLabel: TLabel
    Left = 397
    Top = 454
    Width = 41
    Height = 16
    Caption = 'Total:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  inline TasklessTime: TEditableTime
    Left = 234
    Top = 450
    Width = 70
    Height = 24
    TabOrder = 0
    TabStop = True
    ExplicitLeft = 234
    ExplicitTop = 450
    inherited TextEdit: TEdit
      Color = 15658751
    end
    inherited TextDisplay: TPanel
      Color = 13421823
    end
  end
  object AutoSaveCheck: TCheckBox
    Left = 120
    Top = 425
    Width = 82
    Height = 17
    Caption = 'Auto-Save'
    Checked = True
    Enabled = False
    State = cbChecked
    TabOrder = 1
  end
  inline TotalTime: TEditableTime
    Left = 442
    Top = 450
    Width = 70
    Height = 24
    TabOrder = 2
    TabStop = True
    ExplicitLeft = 442
    ExplicitTop = 450
    inherited TextDisplay: TPanel
      Cursor = crDefault
      Color = clWhite
    end
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
