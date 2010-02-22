object ConfigDialog: TConfigDialog
  Left = 206
  Top = 173
  BorderStyle = bsDialog
  Caption = 'Settings'
  ClientHeight = 231
  ClientWidth = 361
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  PopupMode = pmAuto
  Position = poMainFormCenter
  DesignSize = (
    361
    231)
  PixelsPerInch = 96
  TextHeight = 13
  object OKBtn: TButton
    Left = 282
    Top = 200
    Width = 75
    Height = 26
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
    OnClick = OKBtnClick
  end
  object CancelBtn: TButton
    Left = 201
    Top = 200
    Width = 75
    Height = 26
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
    OnClick = CancelBtnClick
  end
  object AutoSaveGroup: TGroupBox
    Left = 1
    Top = 1
    Width = 357
    Height = 146
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Auto-Save'
    TabOrder = 2
    DesignSize = (
      357
      146)
    object ASDirectoryBrowseButton: TSpeedButton
      Left = 286
      Top = 65
      Width = 63
      Height = 22
      Anchors = [akTop, akRight]
      Caption = 'Browse...'
      Enabled = False
      OnClick = ASDirectoryBrowseButtonClick
      ExplicitLeft = 290
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
      Width = 346
      Height = 13
      AutoSize = False
      Caption = 'Current Filename: '
      EllipsisPosition = epPathEllipsis
      Visible = False
    end
    object ASHelpText: TLabel
      Left = 7
      Top = 111
      Width = 339
      Height = 26
      Anchors = [akLeft, akTop, akRight]
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
      Width = 292
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      Enabled = False
      TabOrder = 1
      Text = 'ASDirectoryEdit'
      OnChange = ASDirectoryEditChange
    end
    object ASEnabledCheck: TCheckBox
      Left = 7
      Top = 18
      Width = 340
      Height = 17
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Start saving automatically when R3T3 launches'
      TabOrder = 2
      OnClick = ASEnabledCheckClick
    end
  end
  object TrayIconGroup: TGroupBox
    Left = 1
    Top = 147
    Width = 357
    Height = 49
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Tray Icon'
    TabOrder = 3
    DesignSize = (
      357
      49)
    object TrayIconEnabledCheck: TCheckBox
      Left = 7
      Top = 18
      Width = 340
      Height = 17
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Show icon in Notification Area ("System Tray")'
      TabOrder = 0
    end
  end
  object ASDirectoryDialog: TSaveDialog
    Left = 384
    Top = 104
  end
end
