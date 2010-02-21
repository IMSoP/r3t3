unit UTrayManager;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Menus;

type
  TTrayManager = class(TForm)
    TheTrayIcon: TTrayIcon;
    TrayPopupMenu: TPopupMenu;
    ShowHideTaskList1: TMenuItem;
    ExitR3T31: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure TheTrayIconClick(Sender: TObject);
    procedure ExitR3T31Click(Sender: TObject);
    procedure ShowHideTaskList1Click(Sender: TObject);
  private
    { Private declarations }
    FIconBase: TIcon;
    FIconRunning: TIcon;
    FIconPaused: TIcon;
  public
    { Public declarations }
    procedure InitialiseTrayIconImages;
    procedure NotifyPaused;
    procedure NotifyRunning(TaskNum: Integer);
  end;

var
  TrayManager: TTrayManager;

implementation

{$R *.dfm}

uses Main, UDebug;

procedure TTrayManager.ExitR3T31Click(Sender: TObject);
begin
      MainForm.Close;
end;

procedure TTrayManager.FormCreate(Sender: TObject);
begin
      Self.InitialiseTrayIconImages;

      // Self.NotifyPaused;
end;

procedure TTrayManager.InitialiseTrayIconImages;
begin
      FIconBase := TIcon.Create;
      FIconBase.LoadFromResourceName(hInstance, 'IconBase16');

      FIconPaused := TIcon.Create;
      FIconPaused.LoadFromResourceName(hInstance, 'IconPaused');

      FIconRunning := TIcon.Create;
      FIconRunning.LoadFromResourceName(hInstance, 'IconRunning');
end;

procedure TTrayManager.NotifyPaused;
begin
      TheTrayIcon.Icon := FIconPaused;
end;

procedure TTrayManager.NotifyRunning(TaskNum: Integer);
begin
      TheTrayIcon.Icon := FIconRunning;
end;

procedure TTrayManager.ShowHideTaskList1Click(Sender: TObject);
begin
      MainForm.ToggleVisible;
end;

procedure TTrayManager.TheTrayIconClick(Sender: TObject);
begin
      MainForm.toggleVisible();
end;

end.
