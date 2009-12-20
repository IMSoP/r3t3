unit _TaskFrame;

interface

uses
      _ClickToEditFrame,

  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, _EditableTimeFrame;

type
  TTaskFrame = class(TFrame)
    TaskPanel: TPanel;
    StartBtn: TSpeedButton;
    StopBtn: TSpeedButton;
    DeleteButton: TSpeedButton;
    KeyLabel: TLabel;
    TaskName: TClickToEdit;
    TaskTime: TEditableTime;
    procedure StartBtnClick(Sender: TObject);
    procedure DeleteButtonClick(Sender: TObject);
    procedure StopBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses Main;

{$R *.dfm}

procedure TTaskFrame.StartBtnClick(Sender: TObject);
begin
      MainForm.SetActiveTask(Self.Tag);
end;

procedure TTaskFrame.StopBtnClick(Sender: TObject);
begin
      MainForm.SetActiveTask(-1);
end;

procedure TTaskFrame.DeleteButtonClick(Sender: TObject);
begin
      MainForm.DeleteTask(Self.Tag);
end;

end.
