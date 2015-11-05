program DemoPasLivVlcPlayerPauseAtStart;

{$MODE Delphi}

uses
  Forms, Interfaces,
  MainFormUnit in 'MainFormUnit.pas' {MainForm};

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
