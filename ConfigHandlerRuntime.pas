unit ConfigHandlerRuntime;

interface

uses
      ConfigManager,
      SysUtils, Forms;

type
      TConfigHandlerRuntime = class(TInterfacedObject, IConfigObserver)
      private
            FMainForm: TForm;
      public
            constructor Create(MainForm: TForm);
            procedure Update(Subject: TConfigManager);
      end;

implementation

uses Main;

constructor TConfigHandlerRuntime.Create(MainForm: TForm);
begin
      FMainForm := MainForm;
end;

procedure TConfigHandlerRuntime.Update(Subject: TConfigManager);
begin
      With (FMainForm as TMainForm)
      Do Begin
            If Subject.CurrentState.BooleanValues['Autosave', 'Enabled']
            Then Begin
                  FileName := Subject.ApplyDateMask(
                           Subject.CurrentState['Autosave', 'Directory']
                           + Subject.CurrentState['Autosave', 'FileMask']
                  );

                  If FileExists(FileName)
                        Then LoadState(FileName)
                        Else SaveState(FileName);

                  AutoSaveCheck.Enabled := true;
            End;
      End;
end;

end.
