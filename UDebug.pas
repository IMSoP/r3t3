unit UDebug;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls;

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

{$R *.dfm}

Procedure TDebugForm.DebugOut(DebugItem: String);
Begin
      DebugOutput.Lines.Add(DebugItem);
End;

end.
