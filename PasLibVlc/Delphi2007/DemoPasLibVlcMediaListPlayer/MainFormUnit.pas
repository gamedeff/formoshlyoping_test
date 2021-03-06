(* This is file is part of PasLibVlcMediaListPlayerDemo program
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 *
 * Any non-GPL usage of this software or parts of this software is strictly
 * forbidden.
 *
 * The "appropriate copyright message" mentioned in section 2c of the GPLv2
 * must read: "Code from FAAD2 is copyright (c) Nero AG, www.nero.com"
 *
 * Commercial non-GPL licensing of this software is possible.
 * please contact robert@prog.olsztyn.pl
 *
 * http://prog.olsztyn.pl/paslibvlc/
 *
 *)

{$I compiler.inc}
 
unit MainFormUnit;

interface

uses
  {$IFDEF UNIX}Unix,{$ENDIF}
  {$IFDEF MSWINDOWS}Windows,{$ENDIF}
  Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls,
  PasLibVlcUnit, PasLibVlcClassUnit, PasLibVlcPlayerUnit;

type
  TMainForm = class(TForm)
    Player: TPasLibVlcPlayer;
    PasLibVlcMediaList1: TPasLibVlcMediaList;
    PlayListBox: TListBox;
    BottomPanel: TPanel;
    PlayBtn: TButton;
    PrevBtn: TButton;
    NextBtn: TButton;
    StopBtn: TButton;
    ClearBtn: TButton;
    PlayModeNormalBtn: TButton;
    PlayModeLoopBtn: TButton;
    PlayModeRepeatBtn: TButton;
    RightPanel: TPanel;
    EventsMemo: TMemo;
    LeftPanel: TPanel;
    InfoPanel: TPanel;
    TimePanel: TPanel;
    TrackBar: TTrackBar;
    PauseBtn: TButton;
    procedure FormCreate(Sender: TObject);
    procedure PlayListBoxClick(Sender: TObject);
    procedure PasLibVlcMediaList1NextItemSet(Sender: TObject; mrl: WideString;
      item: Pointer; index: Integer);
    procedure PasLibVlcMediaList1ItemAdded(Sender: TObject; mrl: WideString;
      item: Pointer; index: Integer);
    procedure PasLibVlcMediaList1ItemDeleted(Sender: TObject; mrl: WideString;
      item: Pointer; index: Integer);
    procedure PlayBtnClick(Sender: TObject);
    procedure PrevBtnClick(Sender: TObject);
    procedure NextBtnClick(Sender: TObject);
    procedure StopBtnClick(Sender: TObject);
    procedure ClearBtnClick(Sender: TObject);
    procedure PlayModeNormalBtnClick(Sender: TObject);
    procedure PlayModeLoopBtnClick(Sender: TObject);
    procedure PlayModeRepeatBtnClick(Sender: TObject);
    procedure PlayerMediaPlayerEndReached(Sender: TObject);
    procedure PlayerMediaPlayerPositionChanged(Sender: TObject;
      position: Single);
    procedure PlayerMediaPlayerLengthChanged(Sender: TObject; time: Int64);
    procedure PlayerMediaPlayerTimeChanged(Sender: TObject; time: Int64);
    procedure PauseBtnClick(Sender: TObject);
    procedure TrackBarChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.PlayModeLoopBtnClick(Sender: TObject);
begin
  PasLibVlcMediaList1.SetPlayModeLoop();
end;

procedure TMainForm.PlayModeNormalBtnClick(Sender: TObject);
begin
  PasLibVlcMediaList1.SetPlayModeNormal();
end;

procedure TMainForm.PlayModeRepeatBtnClick(Sender: TObject);
begin
  PasLibVlcMediaList1.SetPlayModeRepeat();
end;

procedure TMainForm.ClearBtnClick(Sender: TObject);
begin
  PasLibVlcMediaList1.Clear();
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
//  not work in wersion 1.1.11
  PasLibVlcMediaList1.Add('http://www.youtube.com/watch?v=4AnpQfd7PGI');
  PasLibVlcMediaList1.Add('http://www.youtube.com/watch?v=Bh_sV058aLU');
  PasLibVlcMediaList1.Add('http://www.youtube.com/watch?v=GJbo6ynoxEk');
  PasLibVlcMediaList1.Add('..'+PathDelim+'..'+PathDelim+'_testFiles'+PathDelim+'Maximize.mp4');
  PasLibVlcMediaList1.Add('..'+PathDelim+'..'+PathDelim+'_testFiles'+PathDelim+'test.ts');
  PasLibVlcMediaList1.Add('http://www.miastomuzyki.pl/odbior/rmf_aacp.pls');
  PasLibVlcMediaList1.Add('http://www.radio-canada.ca/util/endirect/premiere.asx');
//  PasLibVlcMediaList1.Add('http://79.252.173.254:16453/1:0:1:7034:41B:1:C00000:0:0:0:');
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

procedure TMainForm.PasLibVlcMediaList1NextItemSet(Sender: TObject;
  mrl: WideString; item: Pointer; index: Integer);
begin
  if (index < PlayListBox.Count) then
  begin
    PlayListBox.ItemIndex := index;
  end;

  EventsMemo.Lines.Add('Play ' + mrl);
end;

procedure TMainForm.PauseBtnClick(Sender: TObject);
begin
  PasLibVlcMediaList1.Pause();
  if (PauseBtn.Caption = 'Pause') then PauseBtn.Caption := 'Resume'
  else PauseBtn.Caption := 'Pause';
  TrackBar.OnChange := TrackBarChange;
end;

procedure TMainForm.PlayBtnClick(Sender: TObject);
begin
  PasLibVlcMediaList1.Play();
  TrackBar.OnChange := NIL;
end;

procedure TMainForm.PlayerMediaPlayerEndReached(Sender: TObject);
begin
  TrackBar.Position := 0;
  TimePanel.Caption := '';
end;

procedure TMainForm.PlayerMediaPlayerLengthChanged(Sender: TObject;
  time: Int64);
begin
//  TrackBar.Max := MaxInt;
  TrackBar.Max := Player.GetVideoLenInMs();
  TimePanel.Caption := Player.GetVideoPosStr('hh:mm:ss.ms') + ' / ' +
                       Player.GetVideoLenStr('hh:mm:ss.ms');
end;

procedure TMainForm.PlayerMediaPlayerPositionChanged(Sender: TObject;
  position: Single);
begin
//  TrackBar.Position := Round(MaxInt * position);
end;

procedure TMainForm.PlayerMediaPlayerTimeChanged(Sender: TObject; time: Int64);
begin
  TimePanel.Caption := Player.GetVideoPosStr('hh:mm:ss.ms') + '/' +
                       Player.GetVideoLenStr('hh:mm:ss.ms');
  TrackBar.Position := Player.GetVideoPosInMs();
end;

procedure TMainForm.PrevBtnClick(Sender: TObject);
begin
  PasLibVlcMediaList1.Prev();
end;

procedure TMainForm.StopBtnClick(Sender: TObject);
begin
  PasLibVlcMediaList1.Stop();
end;

procedure TMainForm.TrackBarChange(Sender: TObject);
begin
  if Player.CanSeek() then
  begin
    Player.SetVideoPosInMs(TrackBar.Position);
    PlayerMediaPlayerTimeChanged(SELF, TrackBar.Position);
  end;
end;

end.


