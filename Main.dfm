object MainForm: TMainForm
  Left = 123
  Top = 130
  BorderStyle = bsSizeToolWin
  Caption = 'Rowan'#39's Really Rubbish Time Tracking Tool'
  ClientHeight = 131
  ClientWidth = 494
  Color = clSkyBlue
  Constraints.MinWidth = 370
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
  OnShortCut = FormShortCut
  PixelsPerInch = 96
  TextHeight = 13
  object FooterPanel: TPanel
    Left = 0
    Top = 101
    Width = 494
    Height = 30
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    Align = alBottom
    BevelOuter = bvNone
    Color = 15642740
    Constraints.MaxHeight = 30
    Constraints.MinHeight = 30
    TabOrder = 0
    DesignSize = (
      494
      30)
    object AddButton: TSpeedButton
      Left = 2
      Top = 3
      Width = 90
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = 'Add Task'
      OnClick = AddButtonClick
    end
    object TasklessLabel: TLabel
      Left = 231
      Top = 7
      Width = 60
      Height = 16
      Anchors = [akRight, akBottom]
      Caption = 'Paused:'
      Constraints.MaxWidth = 60
      Constraints.MinWidth = 60
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 4408279
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitLeft = 99
    end
    object TotalLabel: TLabel
      Left = 374
      Top = 7
      Width = 41
      Height = 16
      Anchors = [akRight, akBottom]
      Caption = 'Total:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitLeft = 272
    end
    inline TasklessTime: TEditableTime
      Left = 293
      Top = 3
      Width = 70
      Height = 24
      Anchors = [akRight, akBottom]
      Constraints.MaxWidth = 70
      Constraints.MinWidth = 70
      TabOrder = 0
      TabStop = True
      ExplicitLeft = 293
      ExplicitTop = 3
      inherited TextEdit: TEdit
        Color = 15658751
      end
      inherited TextDisplay: TPanel
        Color = 13421823
      end
    end
    inline TotalTime: TEditableTime
      Left = 418
      Top = 3
      Width = 70
      Height = 24
      Anchors = [akRight, akBottom]
      TabOrder = 1
      TabStop = True
      ExplicitLeft = 418
      ExplicitTop = 3
      inherited TextDisplay: TPanel
        Cursor = crDefault
        Color = clWhite
      end
    end
  end
  object HeaderPanel: TPanel
    Left = 0
    Top = 0
    Width = 494
    Height = 30
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    Align = alTop
    BevelOuter = bvNone
    Color = 15642740
    Constraints.MaxHeight = 30
    Constraints.MinHeight = 30
    TabOrder = 1
    DesignSize = (
      494
      30)
    object FilenameLabel: TLabel
      Left = 199
      Top = 9
      Width = 213
      Height = 13
      Anchors = [akLeft, akRight, akBottom]
      AutoSize = False
      EllipsisPosition = epPathEllipsis
    end
    object LoadButton: TSpeedButton
      Left = 55
      Top = 4
      Width = 57
      Height = 23
      Anchors = [akLeft, akBottom]
      Caption = 'Load...'
      OnClick = LoadButtonClick
    end
    object SaveButton: TSpeedButton
      Left = 4
      Top = 4
      Width = 49
      Height = 23
      Anchors = [akLeft, akBottom]
      Caption = 'Save...'
      OnClick = SaveButtonClick
    end
    object SettingsButton: TSpeedButton
      Left = 418
      Top = 4
      Width = 69
      Height = 22
      Anchors = [akTop, akRight]
      Caption = 'Options...'
      OnClick = SettingsButtonClick
    end
    object AutoSaveCheck: TCheckBox
      Left = 120
      Top = 7
      Width = 73
      Height = 17
      Anchors = [akLeft, akBottom]
      Caption = 'Auto-Save'
      Checked = True
      Enabled = False
      State = cbChecked
      TabOrder = 0
    end
  end
  object TickTimer: TTimer
    OnTimer = TickTimerTimer
    Left = 8
    Top = 48
  end
  object Killer: TTimer
    Enabled = False
    Interval = 10
    OnTimer = KillerTimer
    Left = 40
    Top = 48
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = '.tsv'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 72
    Top = 48
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '.tsv'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 104
    Top = 48
  end
  object AutoSaveTimer: TTimer
    Interval = 60000
    OnTimer = AutoSaveTimerTimer
    Left = 136
    Top = 48
  end
end
