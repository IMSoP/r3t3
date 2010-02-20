unit UDebug;

{$MODE Delphi}

interface

uses
  LCLIntf, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, LResources;

type
  TDebugForm = class(TForm)
  published
    DebugOutput: TMemo;
  private
    { Private declarations }
  public
    { Public declarations }
    Procedure DebugOut(DebugItem: String);
  end;

var
  DebugForm: TDebugForm;

implementation


Procedure TDebugForm.DebugOut(DebugItem: String);
Begin
      DebugOutput.Lines.Add(DebugItem);
End;

initialization
  {$i UDebug.lrs}
  {$i UDebug.lrs}

end.
