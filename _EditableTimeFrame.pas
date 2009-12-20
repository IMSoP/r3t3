unit _EditableTimeFrame;

interface

uses
      _ClickToEditFrame,

  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, StrUtils, Math;

type
  TEditableTime = class(TClickToEdit)
  private
      _timeValue: Integer;
  published
      constructor Create(Owner: TComponent); override;

      procedure BeginEditting; override;
      procedure DoneEditting(AcceptText: boolean); override;

      procedure SetDisplayText(NewValue: string); override;
      procedure SetTime(NewValue: Integer);
      procedure UpdateTimeDisplay;

      property Time: Integer read _timeValue write SetTime;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

// Set initial state
constructor TEditableTime.Create(Owner: TComponent);
begin
      inherited;
      _realText := TextDisplay.Caption;
end;

procedure TEditableTime.BeginEditting;
var
      TotalMinutes: Integer;
begin
      // Do all the default behaviour first; it's easier that way
      inherited;

      // If more than 30 seconds over the minute, round up
      TotalMinutes := _timeValue Div 60
             + IfThen( (_timeValue Mod 60 >= 30), 1, 0 );

      // Now, though, trim the text down to just hours:minutes
      TextEdit.Text := Format(
            '%.1d:%.2d',
            [
                  TotalMinutes Div 60,
                  TotalMinutes Mod 60
            ]
      );

      TextEdit.SelectAll;
end;

procedure TEditableTime.DoneEditting(AcceptText: boolean);
begin
      // Clear any previous redness
      TextEdit.Font.Color := clBlack;
      // Use exception handler to catch invalid input
      try
            if AcceptText then
            begin

            end;

            // Call parent: will attempt to set DisplayText property, and then toggle display
            inherited;
      except
            on E: EConvertError do
                  // Clearly, the user tried to hit accept on an invalid time
                  TextEdit.Font.Color := clRed;
      end;
end;

procedure TEditableTime.SetDisplayText(NewValue: string);
var
      hours, minutes, seconds: Integer;
begin
      // If the input is a single number, interpret as that many minutes
      if TryStrToInt(NewValue, minutes)
      then begin
            Time := (minutes * 60);
      end
      else begin
            // If string is 4 chars, assume h:mm, add zero seconds, and proceed
            if Length(NewValue) = 4
            then
                  NewValue := NewValue + ':00';

            // If the string isn't the right "shape", manually raise an exception
            if    (Length(NewValue) <> 7)
                  Or (MidStr(NewValue, 2, 1) <> ':')
                  Or (MidStr(NewValue, 5, 1) <> ':')
            then
                  Raise EConvertError.Create('Invalid time specification: '+NewValue);

            // Get (and let Delphi validate) the hours and minutes
            hours := StrToInt( MidStr(NewValue, 1, 1) );
            minutes := StrToInt( MidStr(NewValue, 3, 2) );
            seconds := StrToInt( MidStr(NewValue, 6, 2) );

            // Set the internal time value to the appropriate integer
            _timeValue := (hours * 3600) + (minutes * 60) + seconds;
      end;

      UpdateTimeDisplay;
end;

procedure TEditableTime.SetTime(NewValue: Integer);
begin
      // Just for sanity
      if NewValue < 0 then
            NewValue := 0;

      _timeValue := NewValue;
      UpdateTimeDisplay;
end;

procedure TEditableTime.UpdateTimeDisplay;
begin
       _realText := Format(
            '%.1d:%.2d:%.2d',
            [
                  _timeValue Div 3600,
                  (_timeValue Mod 3600) Div 60,
                  _timeValue Mod 60
            ]
       );
       TextDisplay.Caption := _realText;
end;

end.
