unit _ClickToEditFrame;

interface

uses

  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, Buttons, ExtCtrls, StdCtrls;

type
  TClickToEdit = class(TFrame)
  protected
      _realText: String;
      _readOnly: Boolean;

  public

  published
    YesButton: TSpeedButton;
    NoButton: TSpeedButton;
    TextEdit: TEdit;
    TextDisplay: TPanel;

    constructor Create(Owner: TComponent); override;

    // Custom functions
    procedure SetDisplayText(NewValue: String); virtual;
    procedure BeginEditting; virtual;
    procedure DoneEditting(AcceptText: boolean); virtual;

    // Events
    procedure TextDisplayClick(Sender: TObject);
    procedure TextDisplayMouseEnter(Sender: TObject);
    procedure TextDisplayMouseLeave(Sender: TObject);
    procedure YesButtonClick(Sender: TObject);
    procedure NoButtonClick(Sender: TObject);
    procedure TextEditKeyPress(Sender: TObject; var Key: Char);
    procedure TextEditExit(Sender: TObject);

    property DisplayText: string read _realText write SetDisplayText;
    property ReadOnly: Boolean read _readOnly write _readOnly;
  end;

implementation

uses Main;

{$R *.dfm}

// Set initial state
constructor TClickToEdit.Create(Owner: TComponent);
begin
      inherited;
      _realText := '';
      _readOnly := False;
end;

procedure TClickToEdit.SetDisplayText(NewValue: String);
begin
     _realText := NewValue;

     if Length(_realText) = 0
     then begin
           TextDisplay.Caption := '[Click to edit...]';
           TextDisplay.Font.Style := [fsItalic];
           TextDisplay.Font.Color := $666666;
     end
     else begin
            // "&" does that magic hotkey / underlining thing; the escape seems to be "&&" 
           TextDisplay.Caption := ' ' + StringReplace(_realText, '&', '&&', [rfReplaceAll]);
           TextDisplay.Font.Style := [];
           TextDisplay.Font.Color := clBlack;
     end;
end;

// Main editting functions
procedure TClickToEdit.BeginEditting;
begin
      if not ReadOnly then
      begin
            // Make sure the correct text is in the edit box, and flip the display
            TextEdit.Text := _realText;
            TextDisplay.Visible := false;
            TextEdit.Visible := true;
            TextEdit.SetFocus;
            TextEdit.SelectAll;

            // Display the Yes/No buttons; order is important: they stack up from the right
            NoButton.Visible := true;
            YesButton.Visible := true;

            // Warn the main frame that we're in edit mode, and not to interfere
            // Doing this last allows other elements to react to us taking focus first
            MainForm.Editting := Self;
      end;
end;

procedure TClickToEdit.DoneEditting(AcceptText: boolean);
begin
      // Read the text out of the edit box (if accepted), and flip the display
      If AcceptText
            Then DisplayText := TextEdit.Text;

      // Swap display for edit box
      TextEdit.Visible := false;
      TextDisplay.Visible := true;
      // Hide the Yes/No buttons
      YesButton.Visible := false;
      NoButton.Visible := false;

      // Tell the main frame we're all done
      MainForm.Editting := nil;
end;

// Event Handlers -  mostly either accept or reject changes
procedure TClickToEdit.TextEditKeyPress(Sender: TObject; var Key: Char);
begin
      case Ord(Key) of
            13: // Return
            Begin
                  DoneEditting(true);
                  Key := #0;
            End;
            27: // Escape
            Begin
                  DoneEditting(false);
                  Key := #0;
            End;
      end;
end;

procedure TClickToEdit.TextDisplayClick(Sender: TObject);
begin
      BeginEditting;
end;

procedure TClickToEdit.TextDisplayMouseEnter(Sender: TObject);
begin
      If Not ReadOnly Then
            TextDisplay.BevelOuter := bvRaised;
end;

procedure TClickToEdit.TextDisplayMouseLeave(Sender: TObject);
begin
     TextDisplay.BevelOuter := bvLowered;
end;

procedure TClickToEdit.YesButtonClick(Sender: TObject);
begin
      DoneEditting(true);
end;

procedure TClickToEdit.NoButtonClick(Sender: TObject);
begin
      DoneEditting(false);
end;

procedure TClickToEdit.TextEditExit(Sender: TObject);
begin
      Self.DoneEditting(false);
end;


end.
