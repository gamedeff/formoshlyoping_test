unit MainFormUnit;

{$MODE Delphi}

interface

uses
  {$IFNDEF FPC}Windows, Messages, {$ENDIF}SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, PasLibVlcPlayerUnit, ExtCtrls, ComCtrls;

type

  { TMainForm }

  TMainForm = class(TForm)
    EventsMemo: TMemo;
    LeftPanel: TPanel;
    InfoPanel: TPanel;
    PauseBtn: TButton;
    TimePanel: TPanel;
    RightPanel: TPanel;
    PlayModeDefaultBtn: TButton;
    PasLibVlcMediaList1: TPasLibVlcMediaList;
    PlayListBox: TListBox;
    BottomPanel: TPanel;
    Player: TPasLibVlcPlayer;
    PlayBtn: TButton;
    PlayModeLoopBtn: TButton;
    PlayModeRepeatBtn: TButton;
    PrevBtn: TButton;
    NextBtn: TButton;
    StopBtn: TButton;
    ClearBtn: TButton;
    InfoTrackBar: TTrackBar;
    procedure ClearBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure InfoTrackBarChange(Sender: TObject);
    procedure PasLibVlcMediaList1MediaListItemAdded(Sender: TObject;
      mrl: WideString; item: Pointer; index: Integer);
    procedure PauseBtnClick(Sender: TObject);
    procedure PlayerMediaPlayerEndReached(Sender: TObject);
    procedure PlayerMediaPlayerLengthChanged(Sender: TObject; time: Int64);
    procedure PlayerMediaPlayerMediaChanged(Sender: TObject; mrl: string);
    procedure PlayerMediaPlayerPositionChanged(Sender: TObject; position: Single
      );
    procedure PlayerMediaPlayerTimeChanged(Sender: TObject; time: Int64);
    procedure PlayListBoxClick(Sender: TObject);
    procedure PasLibVlcMediaList1NextItemSet(Sender: TObject; mrl: WideString;
      item: Pointer; index: Integer);
    procedure PasLibVlcMediaList1ItemAdded(Sender: TObject; mrl: WideString;
      item: Pointer; index: Integer);
    procedure PasLibVlcMediaList1ItemDeleted(Sender: TObject; mrl: WideString;
      item: Pointer; index: Integer);
    procedure PlayerMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PlayBtnClick(Sender: TObject);
    procedure PlayModeDefaultBtnClick(Sender: TObject);
    procedure PlayModeLoopBtnClick(Sender: TObject);
    procedure PlayModeRepeatBtnClick(Sender: TObject);
    procedure PrevBtnClick(Sender: TObject);
    procedure NextBtnClick(Sender: TObject);
    procedure StopBtnClick(Sender: TObject);
  private
    { Private declarations }
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
  PasLibVlcMediaList1.Add('http://www.youtube.com/watch?v=4AnpQfd7PGI');
  PasLibVlcMediaList1.Add('http://www.youtube.com/watch?v=Bh_sV058aLU');
  PasLibVlcMediaList1.Add('http://www.youtube.com/watch?v=GJbo6ynoxEk');
  //
  PasLibVlcMediaList1.Add('..'+PathDelim+'..'+PathDelim+'_testFiles'+PathDelim+'Maximize.mp4');
  PasLibVlcMediaList1.Add('..'+PathDelim+'..'+PathDelim+'_testFiles'+PathDelim+'test.ts');
  PasLibVlcMediaList1.Add('http://www.miastomuzyki.pl/odbior/rmf_aacp.pls');
  PasLibVlcMediaList1.Add('http://www.radio-canada.ca/util/endirect/premiere.asx');
end;

procedure TMainForm.ClearBtnClick(Sender: TObject);
begin
  PasLibVlcMediaList1.Clear();
end;

procedure TMainForm.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  EventsMemo.Lines.Add('From MouseDown at ' + IntToStr(x) + ',' + IntToStr(y));
end;

procedure TMainForm.InfoTrackBarChange(Sender: TObject);
begin
  if Player.CanSeek() then
  begin
    Player.SetVideoPosInMs(InfoTrackBar.Position);
    TimePanel.Caption := Player.GetVideoPosStr('hh:mm:ss.ms') + ' / ' +
                         Player.GetVideoLenStr('hh:mm:ss.ms');
  end;
end;

procedure TMainForm.PlayListBoxClick(Sender: TObject);
var
  idx: Integer;
  item: TObject;
begin
  if (PlayListBox.ItemIndex < 0) then exit;
  if (PlayListBox.ItemIndex >= PlayListBox.Count) then exit;

  // check for item stil exists in play list
  item := PlayListBox.Items.Objects[PlayListBox.ItemIndex];
  idx := PasLibVlcMediaList1.IndexOfItem(item);

  // if exists then play it
  if (idx > -1) then
  begin
    PasLibVlcMediaList1.PlayItem(item);
  end;
end;

procedure TMainForm.NextBtnClick(Sender: TObject);
begin
  PasLibVlcMediaList1.Next();
end;

procedure TMainForm.PasLibVlcMediaList1ItemAdded(Sender: TObject;
  mrl: WideString; item: Pointer; index: Integer);
begin
  PlayListBox.Items.AddObject(mrl, item);
end;

procedure TMainForm.PasLibVlcMediaList1ItemDeleted(Sender: TObject;
  mrl: WideString; item: Pointer; index: Integer);
begin
  PlayListBox.Items.Delete(index);
end;

procedure TMainForm.PlayerMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  EventsMemo.Lines.Add('Player MouseDown at ' + IntToStr(x) + ',' + IntToStr(y));
end;

procedure TMainForm.PasLibVlcMediaList1MediaListItemAdded(Sender: TObject;
  mrl: WideString; item: Pointer; index: Integer);
begin
  PlayListBox.Items.AddObject(mrl, item);
end;

procedure TMainForm.PauseBtnClick(Sender: TObject);
begin
  PasLibVlcMediaList1.Pause();
  if (PauseBtn.Caption = 'Pause') then PauseBtn.Caption := 'Resume'
  else PauseBtn.Caption := 'Pause';
  InfoTrackBar.OnChange := InfoTrackBarChange;
end;

procedure TMainForm.PlayerMediaPlayerEndReached(Sender: TObject);
begin
  TimePanel.Caption := '';
  InfoTrackBar.Position := 0;
end;

procedure TMainForm.PlayerMediaPlayerLengthChanged(Sender: TObject; time: Int64
  );
begin
  //InfoTrackBar.Max := MaxInt;
  TimePanel.Caption := Player.GetVideoPosStr('hh:mm:ss.ms') + ' / ' +
                       Player.GetVideoLenStr('hh:mm:ss.ms');
  InfoTrackBar.Max := Player.GetVideoLenInMs();
end;

procedure TMainForm.PlayerMediaPlayerMediaChanged(Sender: TObject; mrl: string);
begin
  Caption := mrl;
end;

procedure TMainForm.PlayerMediaPlayerPositionChanged(Sender: TObject;
  position: Single);
begin
  //InfoTrackBar.Position := Round(MaxInt * position);
end;

procedure TMainForm.PlayerMediaPlayerTimeChanged(Sender: TObject; time: Int64);
begin
  TimePanel.Caption := Player.GetVideoPosStr('hh:mm:ss.ms') + ' / ' +
                       Player.GetVideoLenStr('hh:mm:ss.ms');
  InfoTrackBar.Position := Player.GetVideoPosInMs();
end;

procedure TMainForm.PasLibVlcMediaList1NextItemSet(Sender: TObject;
  mrl: WideString; item: Pointer; index: Integer);
begin
  if (index < PlayListBox.Count) then
  begin
    PlayListBox.ItemIndex := index;
  end;
  EventsMemo.Lines.Add('Play ' + mrl);
end;

procedure TMainForm.PlayBtnClick(Sender: TObject);
begin
  PasLibVlcMediaList1.Play();
  InfoTrackBar.OnChange := NIL;
  PauseBtn.Caption := 'Pause';
end;

procedure TMainForm.PlayModeDefaultBtnClick(Sender: TObject);
begin
  PasLibVlcMediaList1.SetPlayModeNormal();
end;

procedure TMainForm.PlayModeLoopBtnClick(Sender: TObject);
begin
  PasLibVlcMediaList1.SetPlayModeLoop();
end;

procedure TMainForm.PlayModeRepeatBtnClick(Sender: TObject);
begin
  PasLibVlcMediaList1.SetPlayModeRepeat();
end;

procedure TMainForm.PrevBtnClick(Sender: TObject);
begin
  PasLibVlcMediaList1.Prev();
end;

procedure TMainForm.StopBtnClick(Sender: TObject);
begin
  PasLibVlcMediaList1.Stop();
end;

end.


