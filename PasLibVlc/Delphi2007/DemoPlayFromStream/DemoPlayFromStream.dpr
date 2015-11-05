{$I ..\..\source\compiler.inc}
program DemoPlayFromStream;

uses
  Forms,
  PasLibVlcUnit in '..\..\source\PasLibVlcUnit.pas',
  PasLibVlcClassUnit in '..\..\source\PasLibVlcClassUnit.pas',
  PasLibVlcPlayerUnit in '..\..\source\PasLibVlcPlayerUnit.pas',
  MainFormUnit in 'MainFormUnit.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  {$IFDEF DELPHI2007_UP}
  Application.MainFormOnTaskbar := True;
  {$ENDIF}
  Application.Title := 'PasLibVlcDemo';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
