unit Cloner;

interface

uses
  SysUtils, Classes, Controls, Dialogs;

function Replicate(C: TComponent; NewOwner: TComponent): TComponent;

implementation

procedure CloneComponent(C1: TComponent; C2: TComponent);
//
// This procedure clones the properties of C1 and writes them to C2.
// C1 and C2 must be of the same type.  Use it for components that do
// not have an Assign method.
//
var
  theStream: TMemoryStream;
  tmpS:      string;
begin
  if C1.ClassType <> C2.ClassType then
    raise EComponentError.Create('Object types are incompatible');

  if C1 is TControl then
    TControl(C2).Parent := TWinControl(C1).Parent;

  theStream := TMemoryStream.Create; // Create the memory stream.

  with theStream do try
    tmpS    := C1.Name;
    C1.Name := EmptyStr;
    WriteComponent(C1);        // Write C1 properties to stream
    C1.Name := tmpS;
    Seek(0, soFromBeginning);  // Position to beginning of stream.
    ReadComponent(C2);         // read properties from stream into C2
  finally
    Free;                      // IAC, free stream.
  end;
end;

function Replicate(C: TComponent; NewOwner: TComponent): TComponent;
//
// This function "replicates" component C and returns
// a new component whose type and properties match
// those of C.
//
var
   i: integer;
   Sub: TComponent;
begin
  Result := TComponentClass(C.ClassType).Create(NewOwner); // Create component }
  CloneComponent(C, Result);                              // Clone it }
  // Recurse!
  for i := 0 to C.ComponentCount-1 do
  begin
      ShowMessage(C.Components[i].Name);
      Sub := TComponentClass(C.Components[i].ClassType).Create(Result); //
      CloneComponent(C.Components[i], Sub);
  end;
end;

end.
