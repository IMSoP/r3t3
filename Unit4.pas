unit Unit4;

interface

uses 
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons;

type
  TTaskFrame = class(TFrame)
    TaskPanel: TPanel;
    TaskText: TEdit;
    TaskTime: TEdit;
    StartBtn: TSpeedButton;
    StopBtn: TSpeedButton;
    SpeedButton1: TSpeedButton;
    KeyLabel: TLabel;
    procedure StartBtnClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses Unit1;

{$R *.dfm}

procedure TTaskFrame.StartBtnClick(Sender: TObject);
begin
   Form1.SetActiveTask(Self.Tag);
end;

procedure TTaskFrame.SpeedButton1Click(Sender: TObject);
begin
   Form1.DeleteTask(Self.Tag);
end;

end.
