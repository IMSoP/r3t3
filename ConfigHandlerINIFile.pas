unit ConfigHandlerINIFile;

{$MODE Delphi}
{$M+}

interface

uses
      ConfigManager, ConfigState,
      
      Forms, Classes, IniFiles, SysUtils;

const
      R3T3_INI_FILE_NAME = 'R3T3.ini';

type
      TConfigHandlerINIFile = class(TInterfacedObject, IConfigObserver)
      private
            FConfigManager: TConfigManager;
            FINIFileName: String;

            procedure LoadFileContents;

      published
            constructor Create(ConfigManager: TConfigManager);
            procedure Update(Subject: TConfigManager);
      end;

implementation


{ TConfigHandlerINIFile }

constructor TConfigHandlerINIFile.Create(ConfigManager: TConfigManager);
begin
      inherited Create;
      FConfigManager := ConfigManager;
      FINIFileName := ExtractFileDir(Application.ExeName) + '\' + R3T3_INI_FILE_NAME;
      LoadFileContents;
      FConfigManager.AttachObserver(Self);
end;

procedure TConfigHandlerINIFile.LoadFileContents;
var
      INIFile: TMemIniFile;
      Sections, Keys: TStringList;
      SectIdx, KeyIdx: Integer;
      NewState: TConfigState;
begin
      INIFile := TMemIniFile.Create(FINIFileName);

      Sections := TStringList.Create;
      INIFile.ReadSections(Sections);

      If Sections.Count > 0
      Then Begin
            NewState := TConfigState.Clone(FConfigManager.CurrentState);

            // Loop through all values and sections, over-writing that variable in the state
            For SectIdx := 0 to Sections.Count - 1 do
            Begin
                  Keys := TStringList.Create;
                  INIFile.ReadSection(Sections[SectIdx], Keys);

                  For KeyIdx := 0 to Keys.Count - 1 do
                  Begin
                        NewState.StringValues[ Sections[SectIdx], Keys[KeyIdx] ]
                              := INIFile.ReadString(Sections[SectIdx], Keys[KeyIdx], '');
                  End;
            End;

            // Send the new state to the ConfigManager, and then free the local copy
            FConfigManager.CurrentState := NewState;
            NewState.Free;
      End;

      INIFile.Free;
end;

procedure TConfigHandlerINIFile.Update(Subject: TConfigManager);
var
      INIFile: TMemIniFile;
      Sections, Keys: TStringList;
      SectIdx, KeyIdx: Integer;
begin
      Sections := TStringList.Create;
      Subject.CurrentState.ReadSections(Sections);

      If Sections.Count > 0
      Then Begin
            INIFile := TMemIniFile.Create(FINIFileName);

            // Pull all values out of current state, and write them to the file
            For SectIdx := 0 to Sections.Count - 1 do
            Begin
                  Keys := TStringList.Create;
                  Subject.CurrentState.ReadSection(Sections[SectIdx], Keys);

                  For KeyIdx := 0 to Keys.Count - 1 do
                  Begin
                        INIFile.WriteString(
                              Sections[SectIdx], Keys[KeyIdx],
                              Subject.CurrentState.StringValues[ Sections[SectIdx], Keys[KeyIdx] ]
                        );
                  End;
            End;

            // Save file, and free object
            INIFile.UpdateFile;
            INIFile.Free;
      End;
end;

end.
