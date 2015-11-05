(* This is file is part of PasLibVlcPlayerDemo program
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
  Dialogs, ExtCtrls, StdCtrls, Menus, ComCtrls,
  {$IFDEF DELPHI_XE2_UP}
  System.UITypes,
  {$ENDIF}
  PasLibVlcUnit, PasLibVlcClassUnit, PasLibVlcPlayerUnit;

type
  TMainForm = class(TForm)
    PR: TPanel;
    PlayBtn: TButton;
    PauseBtn: TButton;
    GetWidthBtn: TButton;
    GetHeightBtn: TButton;
    GetStateBtn: TButton;
    ResumeBtn: TButton;
    GetPosLenBtn: TButton;
    Scale10Btn: TButton;
    ScaleFitBtn: TButton;
    SnapShotBtn: TButton;
    NextFrameBtn: TButton;
    GetASpectRatioBtn: TButton;
    SetAsp11Btn: TButton;
    SetAsp43Btn: TButton;
    LB: TListBox;
    MrlEdit: TEdit;
    MrlLab: TLabel;
    GetVolume: TButton;
    SetVolumeUp10: TButton;
    SetVolumeDo10: TButton;
    PopupMenu: TPopupMenu;
    a1: TMenuItem;
    b1: TMenuItem;
    c1: TMenuItem;
    d1: TMenuItem;
    GetPlayRateBtn: TButton;
    SetPlayRate2xBtn: TButton;
    SetPlayRateHalfBtn: TButton;
    PasLibVlcPlayer1: TPasLibVlcPlayer;
    FullScreenYesBtn: TButton;
    DeInterlaceBtn: TButton;
    ProgPanel: TPanel;
    ProgBar: TTrackBar;
    ProgLabel1: TLabel;
    ProgLabel2: TLabel;
    OpenDialog: TOpenDialog;
    GetAudioChannel: TButton;
    SetAudioChannelLeft: TButton;
    SetAudioChannelRight: TButton;
    SetAudioChannelStereo: TButton;
    SaveDialog: TSaveDialog;
    LbPopupMenu: TPopupMenu;
    LbPmClear: TMenuItem;
    LnPmSaveAs: TMenuItem;
    GetAudioOutDevEnumBtn: TButton;
    GetEqPreListBtn: TButton;
    SetEqualizerBtn: TButton;
    procedure PlayClick(Sender: TObject);
    procedure PauseClick(Sender: TObject);
    procedure GetWidthClick(Sender: TObject);
    procedure GetHeightBtnClick(Sender: TObject);
    procedure GetStateClick(Sender: TObject);
    procedure ResumeClick(Sender: TObject);
    procedure GetPosLenClick(Sender: TObject);
    procedure Scale10Click(Sender: TObject);
    procedure ScaleFitClick(Sender: TObject);
    procedure SnapShotClick(Sender: TObject);
    procedure PasLibVlcPlayer1MediaPlayerBackward(Sender: TObject);
    procedure PasLibVlcPlayer1MediaPlayerBuffering(Sender: TObject);
    procedure PasLibVlcPlayer1MediaPlayerEncounteredError(Sender: TObject);
    procedure PasLibVlcPlayer1MediaPlayerEndReached(Sender: TObject);
    procedure PasLibVlcPlayer1MediaPlayerForward(Sender: TObject);
    procedure PasLibVlcPlayer1MediaPlayerNothingSpecial(Sender: TObject);
    procedure PasLibVlcPlayer1MediaPlayerOpening(Sender: TObject);
    procedure PasLibVlcPlayer1MediaPlayerPaused(Sender: TObject);
    procedure PasLibVlcPlayer1MediaPlayerPlaying(Sender: TObject);
    procedure PasLibVlcPlayer1MediaPlayerStopped(Sender: TObject);
    procedure PasLibVlcPlayer1MediaPlayerLengthChanged(Sender: TObject;
      time: Int64);
    procedure PasLibVlcPlayer1MediaPlayerPausableChanged(Sender: TObject;
      val: Boolean);
    procedure PasLibVlcPlayer1MediaPlayerPositionChanged(Sender: TObject;
      position: Single);
    procedure PasLibVlcPlayer1MediaPlayerSeekableChanged(Sender: TObject;
      val: Boolean);
    procedure PasLibVlcPlayer1MediaPlayerTitleChanged(Sender: TObject;
      title: Integer);
    procedure PasLibVlcPlayer1MediaPlayerTimeChanged(Sender: TObject;
      time: Int64);
    procedure PasLibVlcPlayer1MediaPlayerSnapshotTaken(Sender: TObject;
      fileName: string);
    procedure NextFrameClick(Sender: TObject);
    procedure GetASpectRatioClick(Sender: TObject);
    procedure SetAsp11Click(Sender: TObject);
    procedure SetAsp43Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure GetVolumeClick(Sender: TObject);
    procedure SetVolumeUp10Click(Sender: TObject);
    procedure SetVolumeDo10Click(Sender: TObject);
    procedure PasLibVlcPlayer1ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure PasLibVlcPlayer1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure GetPlayRateBtnClick(Sender: TObject);
    procedure SetPlayRate2xBtnClick(Sender: TObject);
    procedure SetPlayRateHalfBtnClick(Sender: TObject);
    procedure TransPanel1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PasLibVlcPlayer1MouseEnter(Sender: TObject);
    procedure PasLibVlcPlayer1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PasLibVlcPlayer1MouseLeave(Sender: TObject);
    procedure PasLibVlcPlayer1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PasLibVlcPlayer1Click(Sender: TObject);
    procedure PasLibVlcPlayer1DblClick(Sender: TObject);
    procedure FullScreenYesBtnClick(Sender: TObject);
    procedure DeInterlaceBtnClick(Sender: TObject);
    procedure ProgBarChange(Sender: TObject);
    procedure MrlEditClick(Sender: TObject);
    procedure PasLibVlcPlayer1MediaPlayerMediaChanged(Sender: TObject;
      mrl: string);
    procedure GetAudioChannelClick(Sender: TObject);
    procedure SetAudioChannelLeftClick(Sender: TObject);
    procedure SetAudioChannelRightClick(Sender: TObject);
    procedure SetAudioChannelStereoClick(Sender: TObject);
    procedure GetAudioOutListBtnClick(Sender: TObject);
    procedure LbPmClearClick(Sender: TObject);
    procedure LnPmSaveAsClick(Sender: TObject);
    procedure PasLibVlcPlayer1MediaPlayerVideoOutChanged(Sender: TObject;
      video_out: Integer);
    procedure PasLibVlcPlayer1MediaPlayerScrambledChanged(Sender: TObject;
      scrambled: Integer);
    procedure GetAudioOutDevEnumBtnClick(Sender: TObject);
    procedure GetEqPreListBtnClick(Sender: TObject);
    procedure SetEqualizerBtnClick(Sender: TObject);
  private
    start : DWORD;
    procedure DoResize();
    procedure LbAdd(Item: string; AObject: TObject = NIL);
  public
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  FullScreenFormUnit,
  SetEqualizerPresetFormUnit;

////////////////////////////////////////////////////////////////////////////////

procedure TMainForm.LbAdd(Item: string; AObject: TObject = NIL);
var
  current : DWORD;
  delta : DWORD;
begin
  if (LB.Items.Count = 0) then
  begin
    start := GetTickCount();
  end;
  current := GetTickCount();
  if (start <= current) then
  begin
    delta := current - start
  end
  else
  begin
    delta := $FFFFFFFF - start + current;
  end; 
  LB.AddItem(IntToStr(delta) + ' ms  ' + Item, AObject);
  LB.ItemIndex := LB.Items.Count-1;
end;

procedure TMainForm.LbPmClearClick(Sender: TObject);
begin
  LB.Clear;
end;

procedure TMainForm.LnPmSaveAsClick(Sender: TObject);
begin
  if (SaveDialog.Execute) then
    LB.Items.SaveToFile(SaveDialog.FileName);
end;

procedure TMainForm.MrlEditClick(Sender: TObject);
begin
  if (OpenDialog.Execute) then
    MrlEdit.Text := OpenDialog.FileName;
end;

procedure TMainForm.PlayClick(Sender: TObject);
var
  appl_path   : string;
  logo_path   : string;
  logo_file_1 : string;
  logo_file_2 : string;
begin
  PasLibVlcPlayer1.Play(MrlEdit.Text);

  ProgBar.OnChange := NIL;

  appl_path := ExtractFilePath(Application.ExeName);
  if ((appl_path <> '') and (appl_path[Length(appl_path)] <> PathDelim)) then
  begin
    appl_path := appl_path + PathDelim;
  end;

  logo_path := appl_path + '..'+PathDelim+'..'+PathDelim+'..'+PathDelim+'..'+PathDelim;

  logo_file_1 := logo_path + 'logo1.png';
  logo_file_2 := logo_path + 'logo2.png';

  if (FileExists(logo_file_1) and FileExists(logo_file_2)) then
  begin
    PasLibVlcPlayer1.LogoShowFiles([logo_file_1, logo_file_2]);
  end;
  PasLibVlcPlayer1.MarqueeShowText('marquee test %H:%M:%S');
end;

procedure TMainForm.ProgBarChange(Sender: TObject);
begin
  if PasLibVlcPlayer1.CanSeek() then
  begin
    PasLibVlcPlayer1.SetVideoPosInMs(ProgBar.Position);
    ProgLabel1.Caption := PasLibVlcPlayer1.GetVideoPosStr('hh:mm:ss.ms');
  end;
end;

procedure TMainForm.PasLibVlcPlayer1Click(Sender: TObject);
begin
  LBAdd('MouseClick');
end;

procedure TMainForm.PasLibVlcPlayer1ContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
begin
  LBAdd('ContextPopUp');
end;

procedure TMainForm.PasLibVlcPlayer1DblClick(Sender: TObject);
begin
  LBAdd('MouseDblClick');
end;

procedure TMainForm.PasLibVlcPlayer1MediaPlayerBackward(Sender: TObject);
begin
  LBAdd('MediaPlayerBackward');
end;

procedure TMainForm.PasLibVlcPlayer1MediaPlayerBuffering(Sender: TObject);
begin
  LBAdd('MediaPlayerBuffering');
end;

procedure TMainForm.PasLibVlcPlayer1MediaPlayerEncounteredError(
  Sender: TObject);
begin
  LBAdd('MediaPlayerEncounteredError');
  LBAdd({$IFDEF DELPHI_XE2_UP}UTF8ToWideString{$ELSE}UTF8Decode{$ENDIF}(libvlc_errmsg()));
end;

procedure TMainForm.PasLibVlcPlayer1MediaPlayerEndReached(Sender: TObject);
begin
  LBAdd('MediaPlayerEndReached');
end;

procedure TMainForm.PasLibVlcPlayer1MediaPlayerForward(Sender: TObject);
begin
  LBAdd('MediaPlayerForward');
end;

procedure TMainForm.PasLibVlcPlayer1MediaPlayerLengthChanged(Sender: TObject;
  time: Int64);
begin
  LBAdd('MediaPlayerLengthChanged: ' + IntToStr(time) + ', time: ' + PasLibVlcPlayer1.GetVideoLenStr());
  ProgLabel2.Caption := PasLibVlcPlayer1.GetVideoLenStr();
  ProgBar.Max := PasLibVlcPlayer1.GetVideoLenInMs();
end;

procedure TMainForm.PasLibVlcPlayer1MediaPlayerMediaChanged(Sender: TObject;
  mrl: string);
begin
  LBAdd('MediaPlayerMediaChanged: ' + mrl);
  Caption := mrl;
end;

procedure TMainForm.PasLibVlcPlayer1MediaPlayerNothingSpecial(Sender: TObject);
begin
  LBAdd('MediaPlayerNothingSpecial');
end;

procedure TMainForm.PasLibVlcPlayer1MediaPlayerOpening(Sender: TObject);
begin
  LBAdd('MediaPlayerOpening');
end;

procedure TMainForm.PasLibVlcPlayer1MediaPlayerPausableChanged(Sender: TObject;
  val: Boolean);
begin
  LBAdd('MediaPlayerPausableChanged: ' + IntToStr(Ord(val)));  
end;

procedure TMainForm.PasLibVlcPlayer1MediaPlayerPaused(Sender: TObject);
begin
  LBAdd('MediaPlayerPaused');
end;

procedure TMainForm.PasLibVlcPlayer1MediaPlayerPlaying(Sender: TObject);
begin
  LBAdd('MediaPlayerPlaying');
end;

procedure TMainForm.PasLibVlcPlayer1MediaPlayerPositionChanged(Sender: TObject;
  position: Single);
begin
  LBAdd('MediaPlayerPositionChanged: ' + FloatToStr(position));
end;

procedure TMainForm.PasLibVlcPlayer1MediaPlayerScrambledChanged(Sender: TObject;
  scrambled: Integer);
begin
  LBAdd('MediaPlayerScrambledChanged: ' + IntToStr(scrambled));
end;

procedure TMainForm.PasLibVlcPlayer1MediaPlayerSeekableChanged(Sender: TObject;
  val: Boolean);
begin
  LBAdd('MediaPlayerSeekableChanged: ' + IntToStr(Ord(val)));
end;

procedure TMainForm.PasLibVlcPlayer1MediaPlayerSnapshotTaken(Sender: TObject;
  fileName: string);
begin
  LBAdd('MediaPlayerSnapshotTaken: ' + fileName);
end;

procedure TMainForm.PasLibVlcPlayer1MediaPlayerStopped(Sender: TObject);
begin
  LBAdd('MediaPlayerStopped');
end;

procedure TMainForm.PasLibVlcPlayer1MediaPlayerTimeChanged(Sender: TObject;
  time: Int64);
begin
  LBAdd('MediaPlayerTimeChanged: ' + IntToStr(time));
  ProgLabel1.Caption := PasLibVlcPlayer1.GetVideoPosStr('hh:mm:ss.ms');
  ProgBar.Position := PasLibVlcPlayer1.GetVideoPosInMs();
end;

procedure TMainForm.PasLibVlcPlayer1MediaPlayerTitleChanged(Sender: TObject;
  title: Integer);
begin
  LBAdd('MediaPlayerTitleChanged: ' + IntToStr(title));
end;

procedure TMainForm.PasLibVlcPlayer1MediaPlayerVideoOutChanged(Sender: TObject;
  video_out: Integer);
begin
  LBAdd('MediaPlayerVideoOutChanged: ' + IntToStr(video_out));
end;

procedure TMainForm.PasLibVlcPlayer1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  LBAdd('MouseDown(' + IntToStr(X) + ', ' + IntToStr(Y) + ')');
end;

procedure TMainForm.PasLibVlcPlayer1MouseEnter(Sender: TObject);
begin
  LBAdd('MouseEnter');
end;

procedure TMainForm.PasLibVlcPlayer1MouseLeave(Sender: TObject);
begin
  LBAdd('MouseLeave');
end;

procedure TMainForm.PasLibVlcPlayer1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  LBAdd('MouseMove ' + IntToStr(x) + ', ' + IntToStr(y));
end;

procedure TMainForm.PasLibVlcPlayer1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  LBAdd('MouseUp(' + IntToStr(X) + ', ' + IntToStr(Y) + ')');
end;

procedure TMainForm.PauseClick(Sender: TObject);
begin
  PasLibVlcPlayer1.Pause();
  ProgBar.OnChange := ProgBarChange;
end;

procedure TMainForm.GetWidthClick(Sender: TObject);
begin
  MessageDlg(
    'Video width = ' + IntToStr(PasLibVlcPlayer1.GetVideoWidth()),
    mtInformation, [mbOK], 0);
end;

procedure TMainForm.NextFrameClick(Sender: TObject);
begin
  PasLibVlcPlayer1.NextFrame();
  LBAdd('Position:'+IntToStr(PasLibVlcPlayer1.GetVideoPosInMs()));
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  // you can set custom path to libvlc.dll before call use PasLibVlcPlayer component
//  PasLibVlcPlayer1.VLC.Path := 'C:\Program Files (x86)\VideoLAN\VLC';
  // MrlEdit.Text := '..'+PathDelim+'..'+PathDelim+'..'+PathDelim+'..'+PathDelim+'_testFiles'+PathDelim+'test.ts';
  MrlEdit.Text :=
    '..'+PathDelim+'..'+PathDelim+'..'+PathDelim+'..'+PathDelim+
    '_testFiles'+PathDelim+'Maximize.mp4';
  DoResize();
end;

procedure TMainForm.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  LBAdd('FormMouseDown');
end;

procedure TMainForm.FormResize(Sender: TObject);
begin
  DoResize();
end;

procedure TMainForm.FullScreenYesBtnClick(Sender: TObject);
var
  aFullScreenForm : TFullScreenForm;
  oldL, oldT, oldW, oldH : Integer;
  oldA : TAlign;
begin
  MessageDlg('Press any key, to leave full screen mode', mtInformation, [mbOK], 0);

  oldL := PasLibVlcPlayer1.Left;
  oldT := PasLibVlcPlayer1.Top;
  oldW := PasLibVlcPlayer1.Width;
  oldH := PasLibVlcPlayer1.Height;
  oldA := PasLibVlcPlayer1.Align;

  if (oldA <> alNone) then PasLibVlcPlayer1.Align := alNone;
  
  aFullScreenForm := TFullScreenForm.Create(SELF);
  aFullScreenForm.SetBounds(Monitor.Left, Monitor.Top, Monitor.Width, Monitor.Height);

  // PasLibVlcPlayer1.ParentWindow := aFullScreenForm.Handle;
  {$IFDEF FPC}
    LCLIntf.SetParent(PasLibVlcPlayer1.Handle, aFullScreenForm.Handle);
  {$ELSE}
    {$IFDEF MSWINDOWS}
      Windows.SetParent(PasLibVlcPlayer1.Handle, aFullScreenForm.Handle);
    {$ENDIF}
  {$ENDIF}
  PasLibVlcPlayer1.SetBounds(0, 0, Monitor.Width, Monitor.Height);

  aFullScreenForm.ShowModal;

  PasLibVlcPlayer1.SetBounds(oldL, oldT, oldW, oldH);
  {$IFDEF FPC}
    LCLIntf.SetParent(PasLibVlcPlayer1.Handle, SELF.Handle);
  {$ELSE}
    {$IFDEF MSWINDOWS}
      Windows.SetParent(PasLibVlcPlayer1.Handle, SELF.Handle);
    {$ENDIF}
  {$ENDIF}

  aFullScreenForm.Free;

  if (oldA <> alNone) then PasLibVlcPlayer1.Align := oldA;
end;

procedure TMainForm.GetAspectRatioClick(Sender: TObject);
begin
  MessageDlg(
    'Aspect ratio = ' + PasLibVlcPlayer1.GetVideoAspectRatio(),
    mtInformation, [mbOK], 0);
end;

procedure TMainForm.GetAudioChannelClick(Sender: TObject);
var
  chname: string;
begin
  chname := 'Unknown';
  case PasLibVlcPlayer1.GetAudioChannel() of
    libvlc_AudioChannel_Error    : chname := 'Error';
    libvlc_AudioChannel_NotAvail : chname := 'Not availiable';
    libvlc_AudioChannel_Stereo   : chname := 'Stereo';
    libvlc_AudioChannel_RStereo  : chname := 'RStereo';
    libvlc_AudioChannel_Left     : chname := 'Left';
    libvlc_AudioChannel_Right    : chname := 'Right';
    libvlc_AudioChannel_Dolbys   : chname := 'Dolbys';
  end;
  MessageDlg(chname, mtInformation, [mbOK], 0);
end;

procedure TMainForm.GetAudioOutDevEnumBtnClick(Sender: TObject);
var
  ls1 : TStringList;
  id1 : Integer;
begin
  LBAdd('GetAudioOutputDeviceEnum');
  ls1 := PasLibVlcPlayer1.GetAudioOutputDeviceEnum();
  for id1 := 0 to ls1.Count - 1 do
  begin
    LBAdd('  ' + ls1.Strings[id1]);
  end;
  ls1.Free;
end;

procedure TMainForm.GetAudioOutListBtnClick(Sender: TObject);
var
  ls1 : TStringList;
  ls2 : TStringList;
  id1 : Integer;
  id2 : Integer;
begin
  LBAdd('GetAudioOutputList');
  ls1 := PasLibVlcPlayer1.GetAudioOutputList();
  for id1 := 0 to ls1.Count - 1 do
  begin
    LBAdd('  ' + ls1.Strings[id1]);
    ls2 := PasLibVlcPlayer1.GetAudioOutputDeviceList(ls1.Strings[id1]);
    if (ls2.Count < 1) then
    begin
      LBAdd('    no devices found');
    end;
    for id2 := 0 to ls2.Count - 1 do
    begin
      LBAdd('    device: ' + ls2.Strings[id2]);
    end;
    ls2.Free;
  end;
  ls1.Free;
end;

procedure TMainForm.GetEqPreListBtnClick(Sender: TObject);
var
  ls1 : TStringList;
  id1 : Integer;
  ebc : Word;
begin
  LBAdd('GetEqualizerPresetList');
  ls1 := PasLibVlcPlayer1.EqualizerGetPresetList();
  for id1 := 0 to ls1.Count - 1 do
  begin
    LBAdd('  ' + IntToStr(Word(ls1.Objects[id1])) + ' - ' + ls1.Strings[id1]);
  end;
  ls1.Free;

  ebc := PasLibVlcPlayer1.EqualizerGetBandCount();

  LBAdd('GetEqualizerBandCount = ' + IntToStr(ebc));

  LBAdd('GetEqualizerBandFrequency');
  for id1 := 0 to ebc - 1 do
  begin
    LBAdd('  ' + IntToStr(id1) + ' - ' + IntToStr(Round(PasLibVlcPlayer1.EqualizerGetBandFrequency(id1))));
  end;
end;

procedure TMainForm.GetHeightBtnClick(Sender: TObject);
begin
  MessageDlg(
    'Video height = ' + IntToStr(PasLibVlcPlayer1.GetVideoHeight()),
    mtInformation, [mbOK], 0);
end;

procedure TMainForm.GetPlayRateBtnClick(Sender: TObject);
begin
  MessageDlg(
    'Play rate = ' + IntToStr(PasLibVlcPlayer1.GetPlayRate()),
    mtInformation, [mbOK], 0);
end;

procedure TMainForm.GetPosLenClick(Sender: TObject);
begin
  MessageDlg(
    'Len = ' + IntToStr(PasLibVlcPlayer1.GetVideoLenInMs()) + ' ms, '+
    'Pos = ' + IntToStr(PasLibVlcPlayer1.GetVideoPosInMs()),
    mtInformation, [mbOK], 0);
end;

procedure TMainForm.GetStateClick(Sender: TObject);
var
  stateName: string;
begin
  case PasLibVlcPlayer1.GetState() of
    plvPlayer_NothingSpecial: stateName := 'Idle';
    plvPlayer_Opening:        stateName := 'Opening';
    plvPlayer_Buffering:      stateName := 'Buffering';
    plvPlayer_Playing:        stateName := 'Playing';
    plvPlayer_Paused:         stateName := 'Paused';
    plvPlayer_Stopped:        stateName := 'Stopped';
    plvPlayer_Ended:          stateName := 'Ended';
    plvPlayer_Error:          stateName := 'Error';
    else                      stateName := 'Unknown';
  end;
  MessageDlg('State = ' + stateName, mtInformation, [mbOK], 0);
end;

procedure TMainForm.GetVolumeClick(Sender: TObject);
begin
  MessageDlg(
    'Volume level = ' + IntToStr(PasLibVlcPlayer1.GetAudioVolume()),
    mtInformation, [mbOK], 0);
end;

procedure TMainForm.ResumeClick(Sender: TObject);
begin
  PasLibVlcPlayer1.Resume();
  ProgBar.OnChange := NIL;
end;

procedure TMainForm.Scale10Click(Sender: TObject);
var
  sc: Single;
begin
  sc := PasLibVlcPlayer1.GetVideoScaleInPercent;
  if (sc < 1) then sc := 100;
  sc := sc - 10;
  if PasLibVlcPlayer1.IsPlay() then
    PasLibVlcPlayer1.SetVideoScaleInPercent(sc);
end;

procedure TMainForm.ScaleFitClick(Sender: TObject);
begin
  if PasLibVlcPlayer1.IsPlay() then
    PasLibVlcPlayer1.SetVideoScaleInPercent(0);
end;

procedure TMainForm.SetAsp11Click(Sender: TObject);
begin
  PasLibVlcPlayer1.SetVideoAspectRatio('1:1');
end;

procedure TMainForm.SetAsp43Click(Sender: TObject);
begin
  PasLibVlcPlayer1.SetVideoAspectRatio('4:3');
end;

procedure TMainForm.SetAudioChannelLeftClick(Sender: TObject);
begin
  PasLibVlcPlayer1.SetAudioChannel(libvlc_AudioChannel_Left);
end;

procedure TMainForm.SetAudioChannelRightClick(Sender: TObject);
begin
  PasLibVlcPlayer1.SetAudioChannel(libvlc_AudioChannel_Right);
end;

procedure TMainForm.SetAudioChannelStereoClick(Sender: TObject);
begin
  PasLibVlcPlayer1.SetAudioChannel(libvlc_AudioChannel_Stereo);
end;

procedure TMainForm.SetEqualizerBtnClick(Sender: TObject);
var
  eqf : TSetEqualizerPresetForm;
  prl : TStringList;
begin
  prl := PasLibVlcPlayer1.EqualizerGetPresetList();
  eqf := TSetEqualizerPresetForm.Create(SELF);
  eqf.FVLC := PasLibVlcPlayer1.VLC;
  eqf.PresetListLB.Items.AddStrings(prl);
  if eqf.ShowModal = mrOK then
  begin
    if (eqf.PresetListLB.ItemIndex > -1) then
    begin
      PasLibVlcPlayer1.EqualizerSetPreset(
        Word(prl.Objects[eqf.PresetListLB.ItemIndex])
      );
    end;
  end;
  eqf.Free;
  prl.Free;
end;

procedure TMainForm.SetPlayRate2xBtnClick(Sender: TObject);
var
  newPlayRate: Integer;
begin
  newPlayRate := PasLibVlcPlayer1.GetPlayRate() * 2;
  if (newPlayRate > 400) then exit;
  PasLibVlcPlayer1.SetPlayRate(newPlayRate);
end;

procedure TMainForm.SetPlayRateHalfBtnClick(Sender: TObject);
var
  newPlayRate: Integer;
begin
  newPlayRate := PasLibVlcPlayer1.GetPlayRate() div 2;
  if (newPlayRate < 25) then exit;
  PasLibVlcPlayer1.SetPlayRate(newPlayRate);
end;

procedure TMainForm.SetVolumeDo10Click(Sender: TObject);
begin
  PasLibVlcPlayer1.SetAudioVolume(PasLibVlcPlayer1.GetAudioVolume()-10);
end;

procedure TMainForm.SetVolumeUp10Click(Sender: TObject);
begin
  PasLibVlcPlayer1.SetAudioVolume(PasLibVlcPlayer1.GetAudioVolume()+10);
end;

procedure TMainForm.SnapShotClick(Sender: TObject);
begin
  PasLibVlcPlayer1.SnapShot(ChangeFileExt(Application.ExeName, '.png'));
end;

procedure TMainForm.TransPanel1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  LBAdd('Trans MouseDown(' + IntToStr(X) + ', ' + IntToStr(Y) + ')');
end;

procedure TMainForm.DeInterlaceBtnClick(Sender: TObject);
begin
  if (PasLibVlcPlayer1.DeInterlaceFilter = deOFF) then
  begin
    PasLibVlcPlayer1.DeinterlaceMode   := dmX;
    PasLibVlcPlayer1.DeInterlaceFilter := deON;
    LBAdd('DeInterlaceFilter = ON, ' + PasLibVlcPlayer1.DeinterlaceModeName);
  end
  else
  begin
    PasLibVlcPlayer1.DeInterlaceFilter := deOFF;
    LBAdd('DeInterlaceFilter = OFF');
  end;  
end;

procedure TMainForm.DoResize();
begin
  MrlEdit.Width := PR.Left - 16;
  LB.Width := MrlEdit.Width;
  LB.Top := ClientHeight - 8 - LB.Height;
  ProgPanel.Top := LB.Top - 8 - ProgPanel.Height;
  ProgPanel.Width := LB.Width;
  
  PasLibVlcPlayer1.Width := LB.Width;
  PasLibVlcPlayer1.Height := Lb.Top - MrlEdit.Top - MrlEdit.Height - 16 - ProgPanel.Height - 8;
end;

end.
