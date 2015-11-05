{$I ..\..\source\compiler.inc}
program DemoPasLibVlcPlayer;

uses
{$IFDEF FPC}
  Interfaces,
{$ENDIF}
  Forms,
  PasLibVlcUnit in '..\..\source\PasLibVlcUnit.pas',
  PasLibVlcClassUnit in '..\..\source\PasLibVlcClassUnit.pas',
  PasLibVlcPlayerUnit in '..\..\source\PasLibVlcPlayerUnit.pas',
  MainFormUnit in 'MainFormUnit.pas' {MainForm},
  FullScreenFormUnit in 'FullScreenFormUnit.pas' {FullScreenForm},
  SetEqualizerPresetFormUnit in 'SetEqualizerPresetFormUnit.pas' {SetEqualizerPresetForm};

begin
  {$IFDEF DELPHI2007_UP}
  ReportMemoryLeaksOnShutdown := TRUE;
  {$ENDIF}
  
  Application.Initialize;
  {$IFDEF DELPHI2007_UP}
  Application.MainFormOnTaskbar := True;
  {$ENDIF}
  Application.Title := 'PasLibVlcPlayerDemo';
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TSetEqualizerPresetForm, SetEqualizerPresetForm);
  Application.Run;
end.
