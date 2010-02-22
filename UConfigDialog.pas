unit UConfigDialog;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, Dialogs, StrUtils,

  ConfigManager, ConfigState, PCRE;


type
  TConfigDialog = class(TForm, IConfigObserver)
    OKBtn: TButton;
    CancelBtn: TButton;
    AutoSaveGroup: TGroupBox;
    ASDirectoryDialog: TSaveDialog;
    ASFileMaskEdit: TEdit;
    ASDirectoryEdit: TEdit;
    ASFileMaskLabel: TLabel;
    ASDirectoryLabel: TLabel;
    ASCurrentFileDisplay: TLabel;
    ASEnabledCheck: TCheckBox;
    ASHelpText: TLabel;
    TrayIconGroup: TGroupBox;
    TrayIconEnabledCheck: TCheckBox;
    ASDirectoryBrowseButton: TButton;
    procedure ASDirectoryBrowseButtonClick(Sender: TObject);
    procedure ASFileMaskEditChange(Sender: TObject);
    procedure ASDirectoryEditChange(Sender: TObject);
    procedure ASEnabledCheckClick(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
  private
      FASDirectoryName: String;
      FASFileMask: String;
      FConfigManager: TConfigManager;

      procedure UpdateASFileMaskDisplay;
      procedure LoadDialogFromState(const NewState: TConfigState);
      procedure SaveDialogToState;
  public
      procedure IConfigObserver.Update = ConfigUpdate;
      procedure ConfigUpdate(Subject: TConfigManager);
  end;

var
  ConfigDialog: TConfigDialog;

implementation

{$R *.dfm}

procedure TConfigDialog.ConfigUpdate(Subject: TConfigManager);
begin
      If FConfigManager = Nil
      Then Begin
            FConfigManager := Subject;
            FConfigManager.AttachObserver(Self);
      End;

      LoadDialogFromState(Subject.CurrentState);
end;

procedure TConfigDialog.ASDirectoryBrowseButtonClick(Sender: TObject);
begin
      ASDirectoryDialog.InitialDir := FASDirectoryName;
      ASDirectoryDialog.FileName := FASFileMask;

      If ASDirectoryDialog.Execute
      Then Begin
            FASDirectoryName := ExtractFileDir(ASDirectoryDialog.FileName);
            FASFileMask := ExtractFileName(ASDirectoryDialog.FileName);

            UpdateASFileMaskDisplay;
      End;
end;

procedure TConfigDialog.ASDirectoryEditChange(Sender: TObject);
begin
      FASDirectoryName := ASDirectoryEdit.Text;
      UpdateASFileMaskDisplay;
end;

procedure TConfigDialog.ASEnabledCheckClick(Sender: TObject);
begin
      ASFileMaskEdit.Enabled := ASEnabledCheck.Checked;
      ASDirectoryEdit.Enabled := ASEnabledCheck.Checked;
      ASDirectoryBrowseButton.Enabled := ASEnabledCheck.Checked;
end;

procedure TConfigDialog.ASFileMaskEditChange(Sender: TObject);
begin
      FASFileMask := ASFileMaskEdit.Text;
      UpdateASFileMaskDisplay;
end;

procedure TConfigDialog.UpdateASFileMaskDisplay;
begin
      ASFileMaskEdit.Text := FASFileMask;
      ASDirectoryEdit.Text := FASDirectoryName;

      ASCurrentFileDisplay.Caption :=
            'Current Filename: '
            + TConfigManager.ApplyDateMask(FASDirectoryName + '\' + FASFileMask);

      ASCurrentFileDisplay.Visible := True;
end;

procedure TConfigDialog.LoadDialogFromState(const NewState: TConfigState);
begin
      // Auto-save enabled?
      ASEnabledCheck.Checked := NewState.BooleanValues['Autosave', 'Enabled'];
      ASFileMaskEdit.Enabled := ASEnabledCheck.Checked;
      ASDirectoryEdit.Enabled := ASEnabledCheck.Checked;
      ASDirectoryBrowseButton.Enabled := ASEnabledCheck.Checked;

      // Auto-save params
      FASDirectoryName := NewState['Autosave', 'Directory'];
      FASFileMask := NewState['Autosave', 'Filemask'];

      UpdateASFileMaskDisplay;

      // Tray Icon enabled?
      TrayIconEnabledCheck.Checked := NewState.BooleanValues['TrayIcon', 'Enabled'];
end;

procedure TConfigDialog.SaveDialogToState;
var
      NewState: TConfigState;
begin
      NewState := TConfigState.Clone(FConfigManager.CurrentState);

      NewState.BooleanValues['Autosave', 'Enabled'] := ASEnabledCheck.Checked;
      NewState['Autosave', 'Directory'] := FASDirectoryName;
      NewState['Autosave', 'Filemask'] := FASFileMask;

      NewState.BooleanValues['TrayIcon', 'Enabled'] := TrayIconEnabledCheck.Checked;

      FConfigManager.CurrentState := NewState;

      NewState.Free;
end;

procedure TConfigDialog.OKBtnClick(Sender: TObject);
begin
      SaveDialogToState;
end;

procedure TConfigDialog.CancelBtnClick(Sender: TObject);
begin
      // Reset dialog to currently active config state
      LoadDialogFromState( FConfigManager.CurrentState );
end;

end.
