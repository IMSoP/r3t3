unit _TaskFrame;

{$MODE Delphi}

interface

uses
  _ClickToEditFrame, _EditableTimeFrame,

  LCLIntf, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, LResources;

type
  TTaskFrame = class(TFrame)
  private
    { Private declarations }
    FTaskNumber: Integer;
  public
    { Public declarations }
  published
    TaskPanel: TPanel;
    StartBtn: TSpeedButton;
    StopBtn: TSpeedButton;
    DeleteButton: TSpeedButton;
    TaskName: TClickToEdit;
    TaskTime: TEditableTime;
    KeyLabel: TLabel;
    procedure StartBtnClick(Sender: TObject);
    procedure DeleteButtonClick(Sender: TObject);
    procedure StopBtnClick(Sender: TObject);
    procedure SetTaskNumber(NewTaskNumber: Integer);
    property TaskNumber: Integer read FTaskNumber write SetTaskNumber;
  end;

implementation

uses Main;


procedure TTaskFrame.SetTaskNumber(NewTaskNumber: Integer);
begin
      // Set the internal field
      FTaskNumber := NewTaskNumber;

      // Display as a number, or as a letter (tasks 10..35 are A..Z)
      If (NewTaskNumber < 10) Or (NewTaskNumber > 35)
            Then KeyLabel.Caption := IntToStr(NewTaskNumber)
            Else KeyLabel.Caption := Chr(NewTaskNumber - 10 + Ord('A'));
end;

procedure TTaskFrame.StartBtnClick(Sender: TObject);
begin
      MainForm.SetActiveTask(Self.TaskNumber);
end;

procedure TTaskFrame.StopBtnClick(Sender: TObject);
begin
      MainForm.SetActiveTask(-1);
end;

procedure TTaskFrame.DeleteButtonClick(Sender: TObject);
begin
      MainForm.DeleteTask(Self.TaskNumber);
end;

initialization
  {$i _TaskFrame.lrs}
  {$i _TaskFrame.lrs}

end.
