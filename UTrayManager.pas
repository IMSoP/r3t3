unit UTrayManager;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ImgList;

type
  TTrayManager = class(TForm)
    TrayIconImageList: TImageList;
    TheTrayIcon: TTrayIcon;
    procedure FormCreate(Sender: TObject);
    procedure TheTrayIconClick(Sender: TObject);
  private
    { Private declarations }
    FIconIdxBase: Integer;
    FIconIdxRunning: Integer;
    FIconIdxPaused: Integer;
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

procedure TTrayManager.FormCreate(Sender: TObject);
begin
      Self.InitialiseTrayIconImages;

      // Self.NotifyPaused;
end;

procedure TTrayManager.InitialiseTrayIconImages();
var
      NewIcon: TIcon;
      i: Integer;
begin
      NewIcon := TIcon.Create;

      // Load the base icon first, since the IconIndex special-cases 0
      NewIcon.LoadFromResourceName(hInstance, 'IconBase');
      FIconIdxBase := TrayIconImageList.AddIcon(NewIcon);

      NewIcon.LoadFromResourceName(hInstance, 'IconRunning');
      FIconIdxRunning := TrayIconImageList.AddIcon(NewIcon);

      NewIcon.LoadFromResourceName(hInstance, 'IconPaused');
      FIconIdxPaused := TrayIconImageList.AddIcon(NewIcon);

      {
      For i := 0 To 9
      Do Begin
            NewIcon := TIcon.Create;
            NewIcon.LoadFromResourceName(hInstance, 'Foo'+IntToStr(i));
            TrayIconImageList.AddIcon(NewIcon);
            NewIcon.Free;
      End;
      }

      NewIcon.Free;
end;

procedure TTrayManager.NotifyPaused;
begin
      TheTrayIcon.IconIndex := FIconIdxPaused;
end;

procedure TTrayManager.NotifyRunning(TaskNum: Integer);
begin
      TheTrayIcon.IconIndex := FIconIdxRunning;
end;

procedure TTrayManager.TheTrayIconClick(Sender: TObject);
begin
         MainForm.toggleVisible();
end;

end.
