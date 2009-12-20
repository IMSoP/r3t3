unit Main;

interface

uses _TaskFrame, _ClickToEditFrame, _EditableTimeFrame,

  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, Buttons, ExtDlgs, StrUtils;

const
   // This is VK_OEM_5: US standard keyboard \ and | key.
   //       according to http://safari.oreilly.com/0672319330/ch09lev1sec3
   VK_BACKSLASH = $DC;
   // Registered identifier that Win32 will send back to us for our global hotkey 
   HK_SHOWHIDE = 1;

type
  TMainForm = class(TForm)
  private
    _hidden: boolean;
    _taskFrames: Array of TTaskFrame;
    _numTasks: integer;
    _currentTask: integer;
    _killMe: TComponent;
    _editting: TClickToEdit;
    _filename: TFileName;
  published
    TickTimer: TTimer;
    Killer: TTimer;
    AddButton: TSpeedButton;
    TasklessTime: TEditableTime;
    TasklessLabel: TLabel;
    SaveButton: TSpeedButton;
    SaveDialog1: TSaveDialog;
    LoadButton: TSpeedButton;
    OpenDialog1: TOpenDialog;
    AutoSaveTimer: TTimer;
    AutoSaveCheck: TCheckBox;
    FilenameLabel: TLabel;
    procedure SaveButtonClick(Sender: TObject);
    procedure LoadButtonClick(Sender: TObject);
    procedure AutoSaveTimerTimer(Sender: TObject);
    procedure RegisterHotKeys();
    procedure ToggleVisible();
    procedure AddTask();
    procedure DeleteTask(TaskNum: Integer);
    procedure SetActiveTask(TaskNum: Integer);
    procedure OnHotKey(var Msg: TMessage); message WM_HOTKEY;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure AddButtonClick(Sender: TObject);
    procedure TickTimerTimer(Sender: TObject);
    procedure KillerTimer(Sender: TObject);
    procedure FormShortCut(var Msg: TWMKey; var Handled: Boolean);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SaveState(OutFileName:String);
    procedure LoadState(InFileName:String);
    procedure SetFilename(NewValue: TFileName);

    property Editting: TClickToEdit read _editting write _editting;
    property FileName: TFileName read _filename write SetFilename;
end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.FormCreate(Sender: TObject);
begin
         Self.RegisterHotKeys();
         _numTasks := 0;
         _currentTask := -1;
         _editting := nil;
         _filename := '';
         Self.AddTask();
end;

// If the main form captures a mouse event, it implies any editting is aborted
procedure TMainForm.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
      if _editting <> nil then
            _editting.DoneEditting(false);
end;

procedure TMainForm.RegisterHotKeys();
var
   modifier, key: integer;
begin
   modifier := MOD_WIN;
   key := VK_BACKSLASH;
   RegisterHotKey(Self.Handle, HK_SHOWHIDE, modifier, key);
end;

procedure TMainForm.ToggleVisible();
begin
    if (_hidden) then begin
        Self.WindowState := wsNormal;
        Self.Visible := true;
        ShowWindow(Handle, SW_RESTORE);
        _hidden := false;
        SetForegroundWindow(Self.Handle);
    end
    else begin
        // Cancel any outstanding editting
        if _editting <> nil then
            _editting.DoneEditting(false);

        // minimize our app
        _hidden := true;
        //self.WindowState := wsMinimized;
        ShowWindow(Handle, SW_HIDE);
        //PostMessage(Self.handle, WM_SYSCOMMAND, SC_MINIMIZE , 0);
    end;
end;

procedure TMainForm.OnHotKey(var Msg: TMessage);
var
   hotID: integer;
begin
   hotID := Msg.WParam;
   case hotID of
      HK_SHOWHIDE:
         Self.toggleVisible();
   end;
end;

procedure TMainForm.FormShortCut(var Msg: TWMKey; var Handled: Boolean);
begin
      if _editting = nil then
            case Msg.CharCode of
                  VK_BACKSLASH:
                        begin
                              // Backslash is the "pause" button
                              SetActiveTask(-1);
                              Handled := true;
                        end;
                  Ord('0')..Ord('9'):
                        begin
                              // Activate the task for that number, if it exists
                              SetActiveTask(Msg.CharCode - 48);
                              Handled := true;
                        end;
            end;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   //Self.toggleVisible();
   //Action := caNone;
end;

procedure TMainForm.AddTask();
var
   TempFrame: TTaskFrame;
begin
   // Cancel any outstanding editting
   if _editting <> nil then
      _editting.DoneEditting(false);

   TempFrame := TTaskFrame.Create(MainForm);

   TempFrame.Name := 'TaskFrame' + IntToStr(_numTasks);
   TempFrame.Top := _numTasks * TempFrame.Height;

   TempFrame.KeyLabel.Caption := IntToStr(_numTasks);

   SetLength(_taskFrames, _numTasks+1);
   _taskFrames[_numTasks] := TempFrame;
   TempFrame.Tag := _numTasks;

   TempFrame.Parent := MainForm;

   inc(_numTasks);
end;

procedure TMainForm.DeleteTask(TaskNum: Integer);
var
   i: Integer;
begin
   // Cancel any outstanding editting
   if _editting <> nil then
      _editting.DoneEditting(false);

   if _currentTask = TaskNum
      then MainForm.SetActiveTask(-1);

   // Basically to avoid confusion
   TickTimer.Enabled := False;

   _taskFrames[TaskNum].Name := 'KillMe';
   _killMe := _taskFrames[TaskNum];
   MainForm.Killer.Enabled := True;

   for i := TaskNum to _numTasks - 2 do
   begin
      _taskFrames[i] := _taskFrames[i+1];
      _taskFrames[i].Tag := i;
      _taskFrames[i].Name := 'TaskFrame' + IntToStr(i);
      _taskFrames[i].KeyLabel.Caption := IntToStr(i);
      _taskFrames[i].Top := i * _taskFrames[i].Height;
   end;

   Dec(_numTasks);
   SetLength(_taskFrames, _numTasks);

   // if we've just rearranged the active task, it will have a new ID
   if _currentTask > TaskNum
      then dec(_currentTask);

   // normal operation may now resume
   TickTimer.Enabled := True;
end;

procedure TMainForm.AutoSaveTimerTimer(Sender: TObject);
begin
      if (Filename <> '') And (AutoSaveCheck.Checked)
      then
            SaveState(Filename);
end;

procedure TMainForm.AddButtonClick(Sender: TObject);
begin
   MainForm.AddTask();
end;



procedure TMainForm.TickTimerTimer(Sender: TObject);
var
   TimeText: TEditableTime;
begin
   if _currentTask = -1 then
      TimeText := MainForm.TasklessTime
   else
      TimeText := _taskFrames[_currentTask].TaskTime;

   TimeText.Time := TimeText.Time + 1;
end;

procedure TMainForm.SetActiveTask(TaskNum: Integer);
begin
   // New task number must be -1, or an index less than the number of tasks
   if TaskNum < _numTasks then
   begin
      // Cancel any outstanding editting
      if _editting <> nil then
            _editting.DoneEditting(false);

      // first deactivate the old
      if _currentTask = -1 then
      begin
            // TODO: Deal with anonymous time
      end
      else
      begin
            _taskFrames[_currentTask].TaskPanel.Color := clSkyBlue;
            _taskFrames[_currentTask].StopBtn.Visible := False;
            _taskFrames[_currentTask].StartBtn.Visible := True;
      end;

      // now activate the new
      if TaskNum = -1 then
      begin
            // TODO: Deal with anonymous time
            // This will at least stop the crash-per-second bug
            _currentTask := -1;
      end
      else
      begin
            _taskFrames[TaskNum].TaskPanel.Color := clMoneyGreen;
            _currentTask := TaskNum;
            _taskFrames[TaskNum].StartBtn.Visible := False;
            _taskFrames[TaskNum].StopBtn.Visible := True;
      end;
   end;
end;

procedure TMainForm.SetFilename(NewValue: TFileName);
begin
      _filename := NewValue;
      FilenameLabel.Caption := NewValue;
end;

procedure TMainForm.SaveButtonClick(Sender: TObject);
begin
      If SaveDialog1.Execute
      Then Begin
           SaveState(SaveDialog1.FileName);
           Filename := SaveDialog1.FileName;
           AutoSaveCheck.Enabled := true;
      End;
end;

procedure TMainForm.LoadButtonClick(Sender: TObject);
begin
      If OpenDialog1.Execute
      Then Begin
           LoadState(OpenDialog1.FileName);
           Filename := OpenDialog1.FileName;
           AutoSaveCheck.Enabled := true;
      End;
end;

procedure TMainForm.SaveState(OutFileName:String);
var
     i: Integer;
     OutFile: TextFile;
     Success: Boolean;
begin
     Success := false;

     AssignFile(OutFile, OutFileName);
     ReWrite(OutFile);
     try
            For i:=0 to _numTasks -1 do
            Begin
                  write(OutFile, IntToStr(i) + #9);
                  write(OutFile, _taskFrames[i].TaskTime.DisplayText + #9);
                  writeln(OutFile, _taskFrames[i].TaskName.DisplayText);
            End;
            // Write the taskless timer
            write(OutFile, '!'#9);
            write(OutFile, TasklessTime.DisplayText + #9);
            writeln(OutFile, '[Unassigned Time]');
            Success := true;
     finally
            CloseFile(OutFile);
     end;

     if not Success then
            ShowMessage('Could not save file.');
end;

procedure TMainForm.KillerTimer(Sender: TObject);
begin
   if _killMe <> nil then
   begin
      _killMe.Free;
      MainForm.Killer.Enabled := False;
   end;
end;

procedure TMainForm.LoadState(InFileName: String);
var
      InFile: TextFile;
      Success: Boolean;
      TabIndex, LastTabIndex: Integer;
      RawLine, x, y, z: String;
begin
      Success := false;

      AssignFile(InFile, InFileName);
      Reset(InFile);
      try
            While Not EOF(InFile)
            Do Begin
                  x := ''; y := ''; z := '';

                  ReadLn(InFile, RawLine);

                  TabIndex := PosEx(#9, RawLine);
                  If TabIndex > 0
                        Then x := MidStr(RawLine, 1, TabIndex-1);
                  LastTabIndex := TabIndex;

                  TabIndex := PosEx(#9, RawLine, LastTabIndex+1);
                  If TabIndex > 0
                        Then y := MidStr(RawLine, LastTabIndex+1, TabIndex - LastTabIndex - 1);

                  z := MidStr(RawLine, TabIndex+1, Length(RawLine) - TabIndex);

                  try
                        case x[1] of
                              '!':
                                    TasklessTime.DisplayText := y;
                              '0' .. '9':
                                    begin
                                          if StrToInt(x) > _numTasks - 1 then
                                          begin
                                                AddTask();
                                                _taskFrames[_numTasks-1].TaskTime.DisplayText := y;
                                                _taskFrames[_numTasks-1].TaskName.DisplayText := z;
                                          end else begin
                                                _taskFrames[ StrToInt(x) ].TaskTime.DisplayText := y;
                                                _taskFrames[ StrToInt(x) ].TaskName.DisplayText := z;
                                          end;
                                    end;
                        end;
                  except
                        ShowMessage('Error parsing line: '+RawLine);
                  end;
            End;
            Success := true;
      finally
            CloseFile(InFile);
      end;

      if not Success then
            ShowMessage('Could not load file.');
end;

end.

