unit _EditableTimeFrame;

interface

uses
      _ClickToEditFrame, PCRE,

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
      Regex: IRegex;
      Match: IMatch;
      hours, minutes, seconds, fraction: Integer;
      Done: boolean;
begin
      Done := false;

      // If the input is a single number, interpret as that many minutes
      Regex := RegexCreate('^\d+$');
      Match := Regex.Match(NewValue);
      If ( Match.Success )
      Then Begin
            Time := ( StrToInt(NewValue) * 60 );
            Done := true;
      End;

      // hh:mm, both sides optional
      If Not Done
      Then Begin
            // Not sure if this leaks memory - there doesn't seem to be a destructor?
            Regex := RegexCreate('^(\d*):(\d{0,2})$');
            Match := Regex.Match(NewValue);
            If ( Match.Success )
            Then Begin
                  If Match.Groups[1].Length = 0
                        Then Hours := 0
                        Else Hours := StrToInt(Match.Groups[1].Value);
                  If Match.Groups[2].Length = 0
                        Then Minutes := 0
                        Else Minutes := StrToInt(Match.Groups[2].Value);

                  // Over 59 minutes? Error!
                  If Minutes > 59
                        Then Raise EConvertError.Create('Invalid time specification: '+NewValue);

                  Time := (hours * 3600) + (minutes * 60);

                  Done := true;
            End;
      End;

      // hh:mm:ss; must have at least something in minutes section
      If Not Done
      Then Begin
            // Not sure if this leaks memory - there doesn't seem to be a destructor?
            Regex := RegexCreate('^(\d*):(\d{1,2}):(\d*)$');
            Match := Regex.Match(NewValue);
            If ( Match.Success )
            Then Begin
                  If Match.Groups[1].Length = 0
                        Then Hours := 0
                        Else Hours := StrToInt(Match.Groups[1].Value);
                  If Match.Groups[2].Length = 0
                        Then Minutes := 0
                        Else Minutes := StrToInt(Match.Groups[2].Value);
                  If Match.Groups[3].Length = 0
                        Then Seconds := 0
                        Else Seconds := StrToInt(Match.Groups[3].Value);

                  // Over 59 minutes? Error!
                  If Minutes > 59
                        Then Raise EConvertError.Create('Invalid time specification: '+NewValue);
                  // Ditto seconds
                  If Seconds > 59
                        Then Raise EConvertError.Create('Invalid time specification: '+NewValue);

                  Time := (hours * 3600) + (minutes * 60) + seconds;

                  Done := true;
            End;
      End;

      // hh.fraction; e.g. "1.5", ".5", and (why not?) "1."
      If Not Done
      Then Begin
            // Not sure if this leaks memory - there doesn't seem to be a destructor?
            Regex := RegexCreate('^(\d*)\.(\d*)$');
            Match := Regex.Match(NewValue);
            If ( Match.Success )
            Then Begin
                  // Just "." is considered an error
                  If ( Match.Groups[1].Length = 0 ) And ( Match.Groups[2].Length = 0 )
                        Then Raise EConvertError.Create('Invalid time specification: '+NewValue);

                  If Match.Groups[1].Length = 0
                        Then Hours := 0
                        Else Hours := StrToInt(Match.Groups[1].Value);

                  If Match.Groups[2].Length = 0
                  Then Begin
                        Time := (Hours * 3600);
                  End Else Begin
                        Fraction := StrToInt(Match.Groups[2].Value);
                        // Ooh, I'd never really thought how complicated this is
                        Time := (Hours * 3600)
                               + Round( Fraction * 3600 / IntPower(10, Match.Groups[2].Length) );
                  End;

                  Done := true;
            End;
      End;

      // If everything fails, raise hell (or an error)
      If Not Done
            Then Raise EConvertError.Create('Invalid time specification: '+NewValue);

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
