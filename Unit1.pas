unit Unit1;

interface

uses Unit2, Unit4,

  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls;

const
   HK_SHOWHIDE = 1;

type
  TForm1 = class(TForm)
    TickTimer: TTimer;
    Button1: TButton;
    TasklessTime: TEdit;
    Killer: TTimer;
    procedure RegisterHotKeys();
    procedure ToggleVisible();
    procedure AddTask();
    procedure DeleteTask(TaskNum: Integer);
    procedure SetActiveTask(TaskNum: Integer);
    procedure OnHotKey(var Msg: TMessage); message WM_HOTKEY;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure TickTimerTimer(Sender: TObject);
    procedure KillerTimer(Sender: TObject);
  private
    { Private declarations }
  public
    _hidden: boolean;
    _taskFrames: Array of TTaskFrame;
    _numTasks: integer;
    _currentTask: integer;
    _killMe: TComponent;
end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.RegisterHotKeys();
var
   modifier, key: integer;
   result: boolean;
begin
   modifier := MOD_WIN;
   key := Ord('Q');
   result := RegisterHotKey(Self.Handle, HK_SHOWHIDE, modifier, key);
end;

procedure TForm1.ToggleVisible();
begin
    if (_hidden) then begin
        Self.WindowState := wsNormal;
        Self.Visible := true;
        ShowWindow(Handle, SW_RESTORE);
        _hidden := false;
        SetForegroundWindow(Self.Handle);
    end
    else begin
        // minimize our app
        _hidden := true;
        //self.WindowState := wsMinimized;
        ShowWindow(Handle, SW_HIDE);
        //PostMessage(Self.handle, WM_SYSCOMMAND, SC_MINIMIZE , 0);
    end;
end;

procedure TForm1.OnHotKey(var Msg: TMessage);
var
   hotID: integer;
begin
   hotID := Msg.WParam;
   case hotID of
      HK_SHOWHIDE:
         Self.toggleVisible();
   end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
         Self.RegisterHotKeys();
         _numTasks := 0;
         _currentTask := -1;
         Self.AddTask();
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   //Self.toggleVisible();
   //Action := caNone;
end;

procedure TForm1.AddTask();
var
   TempFrame: TTaskFrame;
begin
   TempFrame := TTaskFrame.Create(Form1);

   TempFrame.Name := 'TaskFrame' + IntToStr(_numTasks);
   TempFrame.Top := _numTasks * TempFrame.Height;

   TempFrame.KeyLabel.Caption := IntToStr(_numTasks);

   SetLength(_taskFrames, _numTasks+1);
   _taskFrames[_numTasks] := TempFrame;
   TempFrame.Tag := _numTasks;

   TempFrame.Parent := Form1;

   inc(_numTasks);
end;

procedure TForm1.DeleteTask(TaskNum: Integer);
var
   i: Integer;
begin
   if _currentTask = TaskNum
      then Form1.SetActiveTask(-1);

   // Basically to avoid confusion
   TickTimer.Enabled := False;

   _taskFrames[TaskNum].Name := 'KillMe';
   _killMe := _taskFrames[TaskNum];
   Form1.Killer.Enabled := True;

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

procedure TForm1.Button1Click(Sender: TObject);
begin
   Form1.AddTask();
end;


procedure TForm1.TickTimerTimer(Sender: TObject);
var
   TimeText: TEdit;
begin
   if _currentTask = -1 then
      TimeText := Form1.TasklessTime
   else
      TimeText := _taskFrames[_currentTask].TaskTime;

   TimeText.Tag := TimeText.Tag + 1;
   TimeText.Text := Format('%.2d:%.2d:%.2d', [
                  TimeText.Tag Div 3600,
                  (TimeText.Tag Mod 3600) div 60,
                  TimeText.Tag mod 60
                  ]);
end;

procedure TForm1.SetActiveTask(TaskNum: Integer);
begin
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
   end
   else
   begin
      _taskFrames[TaskNum].TaskPanel.Color := clMoneyGreen;
      _currentTask := TaskNum;
      _taskFrames[TaskNum].StartBtn.Visible := False;
      _taskFrames[TaskNum].StopBtn.Visible := True;
   end;
end;

procedure TForm1.KillerTimer(Sender: TObject);
begin
   if _killMe <> nil then
   begin
      _killMe.Free;
      Form1.Killer.Enabled := False;
   end;
end;

end.

