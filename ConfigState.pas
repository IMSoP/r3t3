unit ConfigState;

{$MODE Delphi}

interface

uses
      Classes, IniFiles, Dialogs, Forms, SysUtils;

type
// Class abstracting the actual set of Config items
// (heavily based on built-in TMemIniFile, and using its THashedStringList)
      TConfigState = class(TObject)
      protected
            FSections: TStringList;

            procedure LoadDefaultValues;

            function AddSection(const Section: string): TStrings;

            function GetStringValue(const Section, Item: string): string;
            procedure SetStringValue(const Section, Item, Value: string);
            function GetBooleanValue(const Section, Item: string): boolean;
            procedure SetBooleanValue(const Section, Item: string; Value: boolean);
      public
            constructor Create();
            constructor Clone(const Source: TConfigState);
            destructor Destroy(); override;

            procedure ReadSections(Strings: TStrings);
            procedure ReadSection(const Section: string; Strings: TStrings);
            property StringValues[const Section, Item: string]: string
                  read GetStringValue write SetStringValue; default;
            property BooleanValues[const Section, Item: string]: boolean
                  read GetBooleanValue write SetBooleanValue;
      end;

implementation

      constructor TConfigState.Create;
      begin
            inherited Create;
            FSections := THashedStringList.Create;
            LoadDefaultValues;
      end;

      procedure TConfigState.LoadDefaultValues;
      begin
            // Use this to detect "first run" scenarios
            // Default is a dummy value showing that no config file exists
            StringValues['General', 'Version'] := '0.0';

            // Auto-save is disable by default, but has some suggested values
            BooleanValues['Autosave', 'Enabled'] := False;
            StringValues['Autosave', 'Directory'] := ExtractFileDir(Application.ExeName) + '\';
            StringValues['Autosave', 'Filemask'] := '{yyyy-mm-dd}.txt';
      end;

      constructor TConfigState.Clone(const Source: TConfigState);
      var
            I: Integer;
            TargetSection: TStrings;
      begin
            Create;

            for I := 0 to Source.FSections.Count - 1 do
            begin
                  TargetSection := AddSection(Source.FSections[I]);
                  TargetSection.Assign( TStrings(Source.FSections.Objects[I]) );
            end;
      end;

      destructor TConfigState.Destroy;
      var
            I: Integer;
      begin
            if FSections <> nil then
            begin
                  for I := 0 to FSections.Count - 1 do
                  begin
                        TObject(FSections.Objects[I]).Free;
                  end;
                  FSections.Clear;
            end;
            
            FSections.Free;

            inherited;
      end;

      function TConfigState.AddSection(const Section: string): TStrings;
      begin
            Result := THashedStringList.Create;
            try
                  FSections.AddObject(Section, Result);
            except
                  Result.Free;
                  raise;
            end;
      end;

      procedure TConfigState.ReadSections(Strings: TStrings);
      begin
            Strings.Assign(FSections);
      end;

      procedure TConfigState.ReadSection(const Section: string; Strings: TStrings);
      var
            SectIdx, KeyIdx: Integer;
            SectionStrings: TStrings;
      begin
            Strings.BeginUpdate;
            try
                  Strings.Clear;
                  SectIdx := FSections.IndexOf(Section);
                  if SectIdx >= 0 then
                  begin
                        SectionStrings := TStrings(FSections.Objects[SectIdx]);

                        for KeyIdx := 0 to SectionStrings.Count - 1 do
                        Begin
                              Strings.Add(SectionStrings.Names[KeyIdx]);
                        End;
                  end;
            finally
                Strings.EndUpdate;
            end;
      end;

      function TConfigState.GetStringValue(const Section, Item: string): string;
      var
            I: Integer;
            Strings: TStrings;
      begin
            I := FSections.IndexOf(Section);
            if I >= 0 then
            begin
                  Strings := TStrings(FSections.Objects[I]);
                  I := Strings.IndexOfName(Item);
                  if I >= 0 then
                  begin
                        Result := Strings.ValueFromIndex[I];
                        Exit;
                  end;
            end;
      end;

      procedure TConfigState.SetStringValue(const Section, Item, Value: String);
      var
            I: Integer;
            S: string;
            Strings: TStrings;
      begin
            I := FSections.IndexOf(Section);
            if I >= 0 then
            begin
                  Strings := TStrings(FSections.Objects[I])
            end else begin
                  Strings := AddSection(Section);
            end;

            I := Strings.IndexOfName(Item);
            if I >= 0 then
            begin
                  Strings.ValueFromIndex[I] := Value;
            end else begin
                  S := Item + '=' + Value;
                  Strings.Add(S);
            end;
      end;

      function TConfigState.GetBooleanValue(const Section, Item: string): boolean;
      begin
            Result := (GetStringValue(Section, Item) = '1');
      end;

      procedure TConfigState.SetBooleanValue(const Section, Item: string; Value: boolean);
      const
            Values: array[Boolean] of string = ('0', '1');
      begin
            SetStringValue(Section, Item, Values[Value]);
      end;
end.

