{$I ..\..\source\compiler.inc}
program DemoPasLibVlcMediaListPlayer;

uses
  Forms,
  PasLibVlcUnit in '..\..\source\PasLibVlcUnit.pas',
  PasLibVlcClassUnit in '..\..\source\PasLibVlcClassUnit.pas',
  PasLibVlcPlayerUnit in '..\..\source\PasLibVlcPlayerUnit.pas',
  MainFormUnit in 'MainFormUnit.pas' {MainForm};

{$R *.res}

begin
  {$IFDEF DELPHI2007_UP}
  ReportMemoryLeaksOnShutdown := TRUE;
  {$ENDIF}
  
  Application.Initialize;
  {$IFDEF DELPHI2007_UP}
  Application.MainFormOnTaskbar := True;
  {$ENDIF}
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
