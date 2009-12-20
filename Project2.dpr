program Project2;

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
  Unit1 in 'Unit1.pas' {Form1},
  Unit2 in 'Unit2.pas' {FakeForm},
  Unit3 in 'Unit3.pas' {Form3},
  Cloner in 'Cloner.pas',
  Unit4 in 'Unit4.pas' {TaskFrame: TFrame};

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

  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
