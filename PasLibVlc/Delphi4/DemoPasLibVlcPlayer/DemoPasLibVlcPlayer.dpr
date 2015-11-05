program DemoPasLibVlcPlayer;

uses
  Forms,
  MainFormUnit in 'MainFormUnit.pas' {MainForm},
  PasLibVlcPlayerUnit in '..\..\source\PasLibVlcPlayerUnit.pas',
  PasLibVlcUnit in '..\..\source\PasLibVlcUnit.pas',
  PasLibVlcClassUnit in '..\..\source\PasLibVlcClassUnit.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
