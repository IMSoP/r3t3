program RRRTTT;

{%TogetherDiagram 'ModelSupport_RRRTTT\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_RRRTTT\Main\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_RRRTTT\Main\default.txvpck'}
{%TogetherDiagram 'ModelSupport_RRRTTT\_TaskFrame\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_RRRTTT\RRRTTT\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_RRRTTT\RRRTTT\default.txvpck'}
{%TogetherDiagram 'ModelSupport_RRRTTT\_ClickToEditFrame\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_RRRTTT\Cloner\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_RRRTTT\_EditableTimeFrame\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_RRRTTT\default.txvpck'}
{%TogetherDiagram 'ModelSupport_RRRTTT\_ClickToEditFrame\default.txvpck'}
{%TogetherDiagram 'ModelSupport_RRRTTT\_EditableTimeFrame\default.txvpck'}
{$R 'R3T3Buttons.res' 'R3T3Buttons.rc'}

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Dialogs,
  StdCtrls,
  ComCtrls,
  Forms,
  Main in 'Main.pas' {MainForm},
  _TaskFrame in '_TaskFrame.pas' {TaskFrame: TFrame},
  _ClickToEditFrame in '_ClickToEditFrame.pas' {ClickToEdit: TFrame},
  _EditableTimeFrame in '_EditableTimeFrame.pas' {EditableTime: TFrame};

{$R *.res}

begin
  Application.Initialize;

  // Hide the application's window, and set our own
  // window to the proper parameters..
  ShowWindow(Application.Handle, SW_HIDE);
  SetWindowLong(Application.Handle, GWL_EXSTYLE,
        GetWindowLong(Application.Handle, GWL_EXSTYLE)
        and not WS_EX_APPWINDOW or WS_EX_TOOLWINDOW);
  ShowWindow(Application.Handle, SW_SHOW);

  Application.Title := 'Rowan''s Really Rubbish Time Tracking Tool';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
