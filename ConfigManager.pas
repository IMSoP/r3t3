unit ConfigManager;

interface

uses
      ConfigState, PCRE,
      Classes, SysUtils, Dialogs, StrUtils;

type

// Observer interface
      TConfigManager = class; // Forward declaration

      IConfigObserver = interface
            ['{38E93441-E02B-4F88-9718-4204AE5F085B}']
            procedure Update(Subject: TConfigManager);
      end;

// Main ConfigManager class, the Subject of the Observer pattern
      TConfigManager = class(TObject)
      private
            FObservers: IInterfaceList;
            FCurrentState: TConfigState;

            procedure NotifyObservers;
            procedure SetState(const NewState: TConfigState);

            class function DateReplaceCallback(Match: IMatch): String;
      published
            constructor Create;

            procedure AttachObserver(NewObserver: IConfigObserver);
            procedure DetachObserver(Observer: IConfigObserver);

            class function ApplyDateMask(const MaskString: String): String;

            property CurrentState: TConfigState read FCurrentState write SetState;
      end;

implementation

      constructor TConfigManager.Create;
      begin
            FCurrentState := TConfigState.Create;
      end;

      // Observer handling functions

      procedure TConfigManager.AttachObserver(NewObserver: IConfigObserver);
      begin
            if FObservers = nil then
            begin
                  FObservers := TInterfaceList.Create;
            end;
            FObservers.Add(NewObserver);
            NotifyObservers;
      end;

      procedure TConfigManager.DetachObserver(Observer: IConfigObserver);
      begin
            if FObservers <> nil then
            begin
                  FObservers.Remove(Observer);
                  if FObservers.Count = 0 then
                  begin
                        FObservers := nil;
                  end;
            end;
      end;

      procedure TConfigManager.NotifyObservers;
      var
            i: Integer;
      begin
            if fObservers <> nil then
            begin
                  for i := 0 to FObservers.Count - 1
                  do begin
                        (FObservers[i] as IConfigObserver).Update( Self );
                  end;
            end;
      end;

      procedure TConfigManager.SetState(const NewState: TConfigState);
      begin
            FCurrentState.Free;
            // Take a clone of the new state, leaving the caller to free the original
            FCurrentState := TConfigState.Clone(NewState);
            
            NotifyObservers;
      end;

      class function TConfigManager.DateReplaceCallback(Match: IMatch): String;
      begin
           DateTimeToString(Result, Match.Value, Now());
           // Strip the { and } off
           // [Delphi strings are indexed 1..N, we want 2..N-1, which has length N-2] 
           Result := MidStr(Result, 2, Length(Result)-2);
      end;

      class function TConfigManager.ApplyDateMask(const MaskString: String): String;
      var
            ReplaceRegex: IRegex;
            Callback: TRegexMatchEvaluator;
      begin
            ReplaceRegex := RegexCreate('{.*?}');
            Callback := DateReplaceCallback;
            Result := ReplaceRegex.Replace(MaskString, Callback);
      end;
end.
