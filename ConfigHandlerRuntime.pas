unit ConfigHandlerRuntime;

interface

uses
      ConfigManager,
      SysUtils, Forms;

type
      TConfigHandlerRuntime = class(TInterfacedObject, IConfigObserver)
      public
            procedure Update(Subject: TConfigManager);
      end;

implementation

uses Main, UTrayManager;

procedure TConfigHandlerRuntime.Update(Subject: TConfigManager);
begin
      With MainForm
      Do Begin
            If Subject.CurrentState.BooleanValues['Autosave', 'Enabled']
            Then Begin
                  FileName := Subject.ApplyDateMask(
                           Subject.CurrentState['Autosave', 'Directory']
                           + '\'
                           + Subject.CurrentState['Autosave', 'FileMask']
                  );

                  If FileExists(FileName)
                  Then Begin
                        LoadState(FileName);
                  End Else Begin
                        ForceDirectories(ExtractFileDir(FileName));
                        SaveState(FileName);
                  End;

                  AutoSaveCheck.Enabled := true;
            End;
      End;

      TrayManager.ToggleIcon(
            Subject.CurrentState.BooleanValues['TrayIcon', 'Enabled']
      );
end;

end.
