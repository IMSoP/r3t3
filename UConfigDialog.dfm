object ConfigDialog: TConfigDialog
  Left = 206
  Top = 173
  BorderStyle = bsDialog
  Caption = 'Settings'
  ClientHeight = 183
  ClientWidth = 367
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  PopupMode = pmAuto
  Position = poDesigned
  DesignSize = (
    367
    183)
  PixelsPerInch = 96
  TextHeight = 13
  object OKBtn: TButton
    Left = 288
    Top = 152
    Width = 75
    Height = 26
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
    OnClick = OKBtnClick
    ExplicitTop = 180
  end
  object CancelBtn: TButton
    Left = 207
    Top = 152
    Width = 75
    Height = 26
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
    OnClick = CancelBtnClick
    ExplicitTop = 180
  end
  object AutoSaveGroup: TGroupBox
    Left = 1
    Top = 1
    Width = 363
    Height = 146
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Auto-Save'
    TabOrder = 2
    object ASDirectoryBrowseButton: TSpeedButton
      Left = 290
      Top = 65
      Width = 63
      Height = 22
      Caption = 'Browse...'
      Enabled = False
      OnClick = ASDirectoryBrowseButtonClick
    end
    object ASFileMaskLabel: TLabel
      Left = 7
      Top = 68
      Width = 47
      Height = 13
      Caption = 'File Mask:'
      FocusControl = ASFileMaskEdit
    end
    object ASDirectoryLabel: TLabel
      Left = 6
      Top = 41
      Width = 48
      Height = 13
      Caption = 'Directory:'
      FocusControl = ASDirectoryEdit
    end
    object ASCurrentFileDisplay: TLabel
      Left = 7
      Top = 92
      Width = 89
      Height = 13
      Caption = 'Current Filename: '
      Visible = False
    end
    object ASHelpText: TLabel
      Left = 7
      Top = 111
      Width = 346
      Height = 26
      Caption = 
        'Text in braces {} will be substituted for the current date using' +
        ' Delphi'#39's DateTimeToString routine - e.g. "Hours {yyyy-mm-dd}.tx' +
        't"'
      WordWrap = True
    end
    object ASFileMaskEdit: TEdit
      Left = 57
      Top = 65
      Width = 121
      Height = 21
      Enabled = False
      TabOrder = 0
      Text = 'ASFileMaskEdit'
      OnChange = ASFileMaskEditChange
    end
    object ASDirectoryEdit: TEdit
      Left = 57
      Top = 38
      Width = 296
      Height = 21
      Enabled = False
      TabOrder = 1
      Text = 'ASDirectoryEdit'
      OnChange = ASDirectoryEditChange
    end
    object ASEnabledCheck: TCheckBox
      Left = 7
      Top = 18
      Width = 346
      Height = 17
      Caption = 'Start saving automatically when R3T3 launches'
      TabOrder = 2
      OnClick = ASEnabledCheckClick
    end
  end
  object ASDirectoryDialog: TSaveDialog
    Left = 384
    Top = 104
  end
end
