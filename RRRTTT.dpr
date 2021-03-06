program RRRTTT;

{Custom resource file for button glyphs, icons, etc}
{$R 'R3T3Buttons.res' 'R3T3Buttons.rc'}
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
{%TogetherDiagram 'ModelSupport_RRRTTT\ConfigManager\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_RRRTTT\ConfigHandlerINIFile\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_RRRTTT\ConfigState\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_RRRTTT\UConfigDialog\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_RRRTTT\_TaskFrame\default.txvpck'}
{%TogetherDiagram 'ModelSupport_RRRTTT\ConfigManager\default.txvpck'}
{%TogetherDiagram 'ModelSupport_RRRTTT\ConfigHandlerINIFile\default.txvpck'}
{%TogetherDiagram 'ModelSupport_RRRTTT\ConfigState\default.txvpck'}
{%TogetherDiagram 'ModelSupport_RRRTTT\UConfigDialog\default.txvpck'}
{%TogetherDiagram 'ModelSupport_RRRTTT\PCRE\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_RRRTTT\UDebug\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_RRRTTT\ConfigHandlerRuntime\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_RRRTTT\pcre_dll\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_RRRTTT\UTrayManager\default.txaPackage'}

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
  _EditableTimeFrame in '_EditableTimeFrame.pas' {EditableTime: TFrame},
  ConfigManager in 'ConfigManager.pas',
  ConfigState in 'ConfigState.pas',
  ConfigHandlerINIFile in 'ConfigHandlerINIFile.pas',
  UConfigDialog in 'UConfigDialog.pas' {ConfigDialog},
  PCRE in 'PCRE\PCRE.pas',
  pcre_dll in 'PCRE\pcre_dll.pas',
  ConfigHandlerRuntime in 'ConfigHandlerRuntime.pas',
  UDebug in 'UDebug.pas' {DebugForm},
  UTrayManager in 'UTrayManager.pas' {TrayManager};

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
  Application.CreateForm(TTrayManager, TrayManager);
  Application.CreateForm(TDebugForm, DebugForm);
  Application.CreateForm(TConfigDialog, ConfigDialog);

  TheConfigManager := TConfigManager.Create;
  TheConfigManager.AttachObserver( TConfigHandlerINIFile.Create(TheConfigManager) );
  TheConfigManager.AttachObserver( ConfigDialog );
  TheConfigManager.AttachObserver( TConfigHandlerRuntime.Create );

  Application.Run;
end.
