object Form1: TForm1
  Left = 193
  Top = 124
  Width = 528
  Height = 587
  BorderStyle = bsSizeToolWin
  Caption = 'Ron'#39's Really Rubbish Time Tracking Tool'
  Color = clSkyBlue
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  DesignSize = (
    520
    560)
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 144
    Top = 440
    Width = 75
    Height = 25
    Caption = 'Add Task'
    TabOrder = 0
    OnClick = Button1Click
  end
  object TasklessTime: TEdit
    Left = 234
    Top = 440
    Width = 89
    Height = 24
    Anchors = [akLeft, akTop, akRight]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    ReadOnly = True
    TabOrder = 1
    Text = '00:00:00'
  end
  object TickTimer: TTimer
    OnTimer = TickTimerTimer
    Left = 8
    Top = 520
  end
  object Killer: TTimer
    Enabled = False
    Interval = 10
    OnTimer = KillerTimer
    Left = 48
    Top = 520
  end
end
