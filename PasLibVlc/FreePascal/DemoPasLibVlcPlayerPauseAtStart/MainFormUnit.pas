unit MainFormUnit;

{$MODE Delphi}

interface

uses
  LCLIntf, LCLType, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, PasLibVlcPlayerUnit;

type

  { TMainForm }

  TMainForm = class(TForm)
    mrlEdit: TEdit;
    player: TPasLibVlcPlayer;
    playButton: TButton;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure playerMediaPlayerTimeChanged(Sender: TObject;
      time: Int64);
    procedure playButtonClick(Sender: TObject);
  private
    needStop : Boolean;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.lfm}

procedure TMainForm.FormCreate(Sender: TObject);
begin
  {$IFDEF LCLGTK2}
    Caption := Caption + ' LCLGTK2';
  {$ELSE}
    {$IFDEF LCLQT}
      Caption := Caption + ' LCLQT';
    {$ELSE}
      Caption := Caption + ' LCLWIN32';
    {$ENDIF}
  {$ENDIF}
  needStop := TRUE;
  mrlEdit.Text := '..'+PathDelim+'..'+PathDelim+'_testFiles'+PathDelim+'test.ts';
  player.Play(mrlEdit.Text);
end;

procedure TMainForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  player.Stop();
end;

procedure TMainForm.playButtonClick(Sender: TObject);
begin
  player.Resume();
end;

procedure TMainForm.playerMediaPlayerTimeChanged(Sender: TObject;
  time: Int64);
begin
  if (needStop) and (time > 500) then
  begin
    needStop := FALSE;
    player.Pause();
  end;
end;

end.
