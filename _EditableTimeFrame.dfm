inherited EditableTime: TEditableTime
  Width = 70
  ExplicitWidth = 70
  inherited YesButton: TSpeedButton
    Left = 39
    ExplicitLeft = 39
  end
  inherited NoButton: TSpeedButton
    Left = 55
    ExplicitLeft = 55
  end
  inherited TextEdit: TEdit
    Width = 38
    Text = '00:00'
    ExplicitWidth = 38
  end
  inherited TextDisplay: TPanel
    Width = 70
    Align = alCustom
    Alignment = taCenter
    Caption = '0:00:00'
    Font.Style = [fsBold]
    ExplicitWidth = 70
  end
end
