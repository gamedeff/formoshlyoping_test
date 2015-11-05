(*
 *******************************************************************************
 * PasLibVlcPlayerUnit.pas - VCL component for VideoLAN libvlc 2.2.0
 *
 * See copyright notice below.
 *
 * Last modified: 2015.04.04
 *
 * author: Robert Jędrzejczyk
 * e-mail: robert@prog.olsztyn.pl
 *    www: http://prog.olsztyn.pl/paslibvlc
 *
 *
 * See PasLibVlcPlayerUnit.txt for change log
 *
 *******************************************************************************
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
 *******************************************************************************
 *
 * libvlc is part of project VideoLAN
 *
 * Copyright (c) 1996-2010 VideoLAN Team
 *
 * For more information about VideoLAN
 *
 * please visit http://www.videolan.org
 *
 *)

{$I compiler.inc}

unit PasLibVlcPlayerUnit;

interface

uses
  {$IFDEF UNIX}Unix,{$ENDIF}
  {$IFDEF MSWINDOWS}Windows,{$ENDIF}
  {$IFDEF FPC}
  LCLType, LCLIntf, LazarusPackageIntf, LMessages, LResources, Forms, Dialogs,
  {$ELSE}
  Messages,
  {$ENDIF}
  {$IFDEF HAS_SYNCOBJS}SyncObjs,{$ENDIF}
  Classes, SysUtils, Controls, ExtCtrls, Graphics,
  PasLibVlcUnit,
  PasLibVlcClassUnit;

const
  WM_START = WM_USER;

type
  TVlcMessage = {$IFDEF FPC}TLMessage{$ELSE}TMessage{$ENDIF};

const
  WM_MEDIA_PLAYER_MEDIA_CHANGED      = WM_START + $100;
  WM_MEDIA_PLAYER_NOTHING_SPECIAL    = WM_START + $101;
  WM_MEDIA_PLAYER_OPENING            = WM_START + $102;
  WM_MEDIA_PLAYER_BUFFERING          = WM_START + $103;
  WM_MEDIA_PLAYER_PLAYING            = WM_START + $104;
  WM_MEDIA_PLAYER_PAUSED             = WM_START + $105;
  WM_MEDIA_PLAYER_STOPPED            = WM_START + $106;
  WM_MEDIA_PLAYER_FORWARD            = WM_START + $107;
  WM_MEDIA_PLAYER_BACKWARD           = WM_START + $108;
  WM_MEDIA_PLAYER_END_REACHED        = WM_START + $109;
  WM_MEDIA_PLAYER_ENCOUNTERED_ERROR  = WM_START + $110;

  WM_MEDIA_PLAYER_TIME_CHANGED       = WM_START + $111;
  WM_MEDIA_PLAYER_POSITION_CHANGED   = WM_START + $112;

  WM_MEDIA_PLAYER_SEEKABLE_CHNANGED  = WM_START + $113;
  WM_MEDIA_PLAYER_PAUSABLE_CHNANGED  = WM_START + $114;
  WM_MEDIA_PLAYER_TITLE_CHNANGED     = WM_START + $115;
  WM_MEDIA_PLAYER_SNAPSHOT_TAKEN     = WM_START + $116;
  WM_MEDIA_PLAYER_LENGTH_CHANGED     = WM_START + $117;
  WM_MEDIA_PLAYER_VOUT_CHANGED       = WM_START + $118;
  WM_MEDIA_PLAYER_SCRAMBLED_CHNANGED = WM_START + $119;

type
  TPasLibVlcPlayerState = (
    plvPlayer_NothingSpecial,
    plvPlayer_Opening,
    plvPlayer_Buffering,
    plvPlayer_Playing,
    plvPlayer_Paused,
    plvPlayer_Stopped,
    plvPlayer_Ended,
    plvPlayer_Error);

type
  TPasLibVlcPlayerMouseEventsHandler = (
    mehComponent,
    mehVideoLAN
  );

type
  TNotifySeekableChanged  = procedure(Sender : TObject; val             : Boolean)  of object;
  TNotifyPausableChanged  = procedure(Sender : TObject; val             : Boolean)  of object;
  TNotifyTitleChanged     = procedure(Sender : TObject; title           : Integer)  of object;
  TNotifySnapshotTaken    = procedure(Sender : TObject; fileName        : string)   of object;
  TNotifyTimeChanged      = procedure(Sender : TObject; time            : Int64)    of object;
  TNotifyLengthChanged    = procedure(Sender : TObject; time            : Int64)    of object;
  TNotifyPositionChanged  = procedure(Sender : TObject; position        : Single)   of object;
  TNotifyMediaChanged     = procedure(Sender : TObject; mrl             : string)   of object;
  TNotifyVideoOutChanged  = procedure(Sender : TObject; video_out       : Integer)  of object;
  TNotifyScrambledChanged = procedure(Sender : TObject; scrambled       : Integer)  of object;
  TNotifyPlayerEvent      = procedure(p_event: libvlc_event_t_ptr; data : Pointer)  of object;

  TPasLibVlcPlayer = class;

  {$IFDEF FPC}
  TPasLibVlcPlayer = class(TPanel)
  {$ELSE}
  {$IFDEF DELPHI_XE7_UP}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32 or pidLinux32)]
  {$ENDIF}
  TPasLibVlcPlayer = class(TCustomPanel)
  {$ENDIF}
  private
    FVLC          : TPasLibVlc;
    p_mi          : libvlc_media_player_t_ptr;
    p_mi_ev_mgr   : libvlc_event_manager_t_ptr;

    FCS           :  {$IFDEF HAS_SYNCOBJS}SyncObjs.{$ENDIF}TCriticalSection;

    //
    FError        : string;
    FMute         : Boolean;

    FVideoOutput : TVideoOutput;
    FAudioOutput : TAudioOutput;

    FTitleShow        : Boolean;
    FTitleShowPos     : TPasLibVlcTitlePosition;
    FTitleShowTimeOut : LongWord;

    FSnapshotFmt  : string;
    FSnapshotPrv  : Boolean;

    FVideoOnTop   : Boolean;
    FUseOverlay   : Boolean;

    FSpuShow      : Boolean;
    FOsdShow      : Boolean;

    FViewTeleText : Boolean;

    FDeinterlaceFilter : TDeinterlaceFilter;
    FDeinterlaceMode   : TDeinterlaceMode;
    
    // events handlers
    FOnMediaPlayerMediaChanged     : TNotifyMediaChanged;
    FOnMediaPlayerNothingSpecial   : TNotifyEvent;
    FOnMediaPlayerOpening          : TNotifyEvent;
    FOnMediaPlayerBuffering        : TNotifyEvent;
    FOnMediaPlayerPlaying          : TNotifyEvent;
    FOnMediaPlayerPaused           : TNotifyEvent;
    FOnMediaPlayerStopped          : TNotifyEvent;
    FOnMediaPlayerForward          : TNotifyEvent;
    FOnMediaPlayerBackward         : TNotifyEvent;
    FOnMediaPlayerEndReached       : TNotifyEvent;
    FOnMediaPlayerEncounteredError : TNotifyEvent;
    FOnMediaPlayerTimeChanged      : TNotifyTimeChanged;
    FOnMediaPlayerPositionChanged  : TNotifyPositionChanged;
    FOnMediaPlayerSeekableChanged  : TNotifySeekableChanged;
    FOnMediaPlayerPausableChanged  : TNotifyPausableChanged;
    FOnMediaPlayerTitleChanged     : TNotifyTitleChanged;
    FOnMediaPlayerSnapshotTaken    : TNotifySnapshotTaken;
    FOnMediaPlayerLengthChanged    : TNotifyLengthChanged;
    FOnMediaPlayerVideoOutChanged  : TNotifyVideoOutChanged;
    FOnMediaPlayerScrambledChanged : TNotifyScrambledChanged;
    FOnMediaPlayerEvent            : TNotifyPlayerEvent;

    FUseEvents                     : boolean;

    FPlayerWinCtrl                 : TWinControl;
    FMouseEventWinCtrl             : TPasLibVlcMouseEventWinCtrl;

    FMouseEventsHandler            : TPasLibVlcPlayerMouseEventsHandler;

    FStartOptions                  : TStringList;

    function  GetVlcInstance() : TPasLibVlc;
    procedure SetStartOptions(Value: TStringList);

    procedure SetMouseEventHandler(aValue : TPasLibVlcPlayerMouseEventsHandler);

    procedure SetSnapshotFmt(aFormat: string);
    procedure SetSnapshotPrv(aValue : Boolean);

    procedure SetSpuShow(aValue: Boolean);
    procedure SetOsdShow(aValue: Boolean);
    procedure SetVideoOnTop(aValue : Boolean);
    procedure SetUseOverlay(aValue : Boolean);
    procedure SetViewTeleText(aValue : Boolean);

    procedure UpdateTitleShow();
    procedure SetTitleShow(aValue: Boolean);
    procedure SetTitleShowPos(aValue: TPasLibVlcTitlePosition);
    procedure SetTitleShowTimeOut(aValue: LongWord);

    procedure SetDeinterlaceFilter(aValue: TDeinterlaceFilter);
    procedure SetDeinterlaceMode(aValue: TDeinterlaceMode);
    function  GetDeinterlaceModeName(): WideString;

    procedure UpdateDeInterlace();

    procedure InternalOnClick(Sender: TObject);
    procedure InternalOnDblClick(Sender: TObject);
    procedure InternalOnMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure InternalOnMouseMove(Sender: TObject;
      Shift: TShiftState; X, Y: Integer);
    procedure InternalOnMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    {$IFDEF DELPHI2005_UP}
    procedure InternalOnMouseActivate(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y, HitTest: Integer;
      var MouseActivate: TMouseActivate);
    {$ENDIF}
    {$IFDEF DELPHI2006_UP}
    procedure InternalOnMouseEnter(Sender: TObject);
    procedure InternalOnMouseLeave(Sender: TObject);
    {$ENDIF}

    procedure WmMediaPlayerMediaChanged    (var m: TVlcMessage); message WM_MEDIA_PLAYER_MEDIA_CHANGED;
    procedure WmMediaPlayerNothingSpecial  (var m: TVlcMessage); message WM_MEDIA_PLAYER_NOTHING_SPECIAL;
    procedure WmMediaPlayerOpening         (var m: TVlcMessage); message WM_MEDIA_PLAYER_OPENING;
    procedure WmMediaPlayerBuffering       (var m: TVlcMessage); message WM_MEDIA_PLAYER_BUFFERING;
    procedure WmMediaPlayerPlaying         (var m: TVlcMessage); message WM_MEDIA_PLAYER_PLAYING;
    procedure WmMediaPlayerPaused          (var m: TVlcMessage); message WM_MEDIA_PLAYER_PAUSED;
    procedure WmMediaPlayerStopped         (var m: TVlcMessage); message WM_MEDIA_PLAYER_STOPPED;
    procedure WmMediaPlayerForward         (var m: TVlcMessage); message WM_MEDIA_PLAYER_FORWARD;
    procedure WmMediaPlayerBackward        (var m: TVlcMessage); message WM_MEDIA_PLAYER_BACKWARD;
    procedure WmMediaPlayerEndReached      (var m: TVlcMessage); message WM_MEDIA_PLAYER_END_REACHED;
    procedure WmMediaPlayerEncounteredError(var m: TVlcMessage); message WM_MEDIA_PLAYER_ENCOUNTERED_ERROR;

    procedure WmMediaPlayerTimeChanged     (var m: TVlcMessage); message WM_MEDIA_PLAYER_TIME_CHANGED;
    procedure WmMediaPlayerPositionChanged (var m: TVlcMessage); message WM_MEDIA_PLAYER_POSITION_CHANGED;

    procedure WmMediaPlayerSeekableChanged (var m: TVlcMessage); message WM_MEDIA_PLAYER_SEEKABLE_CHNANGED;
    procedure WmMediaPlayerPausableChanged (var m: TVlcMessage); message WM_MEDIA_PLAYER_PAUSABLE_CHNANGED;
    procedure WmMediaPlayerTitleChanged    (var m: TVlcMessage); message WM_MEDIA_PLAYER_TITLE_CHNANGED;
    procedure WmMediaPlayerSnapshotTaken   (var m: TVlcMessage); message WM_MEDIA_PLAYER_SNAPSHOT_TAKEN;

    procedure WmMediaPlayerLengthChanged   (var m: TVlcMessage); message WM_MEDIA_PLAYER_LENGTH_CHANGED;

    procedure WmMediaPlayerVOutChanged     (var m: TVlcMessage); message WM_MEDIA_PLAYER_VOUT_CHANGED;
    procedure WmMediaPlayerScrambledChanged(var m: TVlcMessage); message WM_MEDIA_PLAYER_SCRAMBLED_CHNANGED;

  protected
  
    procedure SetHwnd();

  public
  
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function GetPlayerHandle(): libvlc_media_player_t_ptr;

    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;

    procedure PlayInWindow(newWindow: TWinControl = NIL);

    procedure Play(mrl: WideString);
    procedure PlayNormal(mrl: WideString);
    procedure PlayYoutube(mrl: WideString; timeout: Cardinal = 10000); overload;

    procedure PlayContinue();
    function  GetMediaMrl(): string;

    procedure Pause();
    procedure Resume();
    function  IsPlay(): Boolean;
    function  IsPause(): Boolean;
    procedure Stop();

    function  GetState(): TPasLibVlcPlayerState;
    function  GetStateName(): string;

    function  CanPlay(): Boolean;
    function  CanPause(): Boolean;
    function  CanSeek(): Boolean;

    function HasVout() : Boolean;
    function IsScrambled() : Boolean;

    function Snapshot(fileName: WideString): Boolean; overload;
    function Snapshot(fileName: WideString; width, height: LongWord): Boolean; overload;

    procedure NextFrame();

    procedure SetPlayRate(rate: Integer);
    function  GetPlayRate(): Integer;

    function  GetVideoWidth(): LongInt;
    function  GetVideoHeight(): LongInt;
    function  GetVideoDimension(var width, height: LongWord) : Boolean;
    function  GetVideoScaleInPercent(): Single;
    function  GetVideoAspectRatio(): string;

    procedure SetVideoScaleInPercent(newScaleInPercent: Single);
    procedure SetVideoAspectRatio(newAspectRatio: string);

    function  GetVideoLenInMs(): Int64;
    function  GetVideoPosInMs(): Int64;
    function  GetVideoPosInPercent(): Single;
    function  GetVideoFps(): Single;

    procedure SetVideoPosInMs(newPos: Int64);
    procedure SetVideoPosInPercent(newPos: Single);

    function GetVideoLenStr(fmt: string = 'hh:mm:ss'): string;
    function GetVideoPosStr(fmt: string = 'hh:mm:ss'): string;

    procedure SetTeleText(page: Integer);
    function  GetTeleText() : Integer;
    function  ShowTeleText() : Boolean;
    function  HideTeleText() : Boolean;

    function  GetAudioMute(): Boolean;
    procedure SetAudioMute(mute: Boolean);
    function  GetAudioVolume(): Integer;
    procedure SetAudioVolume(volumeLevel: Integer);

    function  GetAudioChannel(): libvlc_audio_output_channel_t;
    procedure SetAudioChannel(chanel: libvlc_audio_output_channel_t);

    function  GetAudioDelay(): Int64;
    procedure SetAudioDelay(delay: Int64);

    function  GetAudioTrackList(): TStringList;
    function  GetAudioTrackCount(): Integer;
    function  GetAudioTrackId(): Integer;
    procedure SetAudioTrackById(const track_id : Integer);
    function  GetAudioTrackNo(): Integer;
    procedure SetAudioTrackByNo(track_no : Integer);
    function  GetAudioTrackDescriptionById(const track_id : Integer): WideString;
    function  GetAudioTrackDescriptionByNo(track_no : Integer): WideString;

    function GetAudioOutputList(): TStringList;
    function GetAudioOutputDeviceList(aOut : WideString): TStringList;
    function GetAudioOutputDeviceEnum() : TStringList;

    function SetAudioOutput(aOut: WideString) : Boolean;
    procedure SetAudioOutputDevice(aOut: WideString; device_id: WideString); overload;
    procedure SetAudioOutputDevice(device_id: WideString); overload;

    {$IFDEF USE_VLC_DEPRECATED_API}
    function GetAudioOutputDeviceCount(aOut: WideString): Integer;
    function GetAudioOutputDeviceId(aOut: WideString; deviceIdx : Integer) : WideString;
    function GetAudioOutputDeviceName(aOut: WideString; deviceIdx : Integer): WideString;
    {$ENDIF}

    function EqualizerGetPresetList(): TStringList;
    function EqualizerGetBandCount(): Word;
    function EqualizerGetBandFrequency(bandIndex : Word): Single;

    function EqualizerCreate(APreset : Word = $FFFF) : TPasLibVlcEqualizer;
    procedure EqualizerApply(AEqualizer : TPasLibVlcEqualizer);
    procedure EqualizerSetPreset(APreset : Word = $FFFF);

    function  GetVideoChapter(): Integer;
    procedure SetVideoChapter(newChapter: Integer);
    function  GetVideoChapterCount(): Integer;
    function  GetVideoChapterCountByTitleId(const title_id : Integer): Integer;

    function  GetVideoSubtitleList(): TStringList;
    function  GetVideoSubtitleCount(): Integer;
    function  GetVideoSubtitleId(): Integer;
    procedure SetVideoSubtitleById(const subtitle_id : Integer);
    function  GetVideoSubtitleNo(): Integer;
    procedure SetVideoSubtitleByNo(subtitle_no : Integer);
    function  GetVideoSubtitleDescriptionById(const subtitle_id : Integer): WideString;
    function  GetVideoSubtitleDescriptionByNo(subtitle_no : Integer): WideString;
    procedure SetVideoSubtitleFile(subtitle_file : WideString);

    function  GetVideoTitleList() : TStringList;
    function  GetVideoTitleCount(): Integer;
    function  GetVideoTitleId():Integer;
    procedure SetVideoTitleById(const title_id:Integer);
    function  GetVideoTitleNo(): Integer;
    procedure SetVideoTitleByNo(title_no : Integer);
    function  GetVideoTitleDescriptionById(const track_id : Integer): WideString;
    function  GetVideoTitleDescriptionByNo(title_no : Integer): WideString;

    // https://wiki.videolan.org/Documentation:Modules/logo/
    procedure LogoSetFile(file_name : WideString);
    procedure LogoSetFiles(file_names : array of WideString; delay_ms : Integer = 1000; loop : Boolean = TRUE);
    procedure LogoSetPosition(position_x, position_y : Integer); overload;
    procedure LogoSetPosition(position : libvlc_position_t); overload;
    procedure LogoSetOpacity(opacity : libvlc_opacity_t);
    procedure LogoSetDelay(delay_ms : Integer = 1000);  // delay before show next logo file, default 1000
    procedure LogoSetRepeat(loop : boolean = TRUE); 
    procedure LogoSetEnable(enable : Integer);
    
    procedure LogoShowFile(file_name : WideString; position_x, position_y : Integer; opacity: libvlc_opacity_t = libvlc_opacity_full); overload;
    procedure LogoShowFile(file_name : WideString; position: libvlc_position_t = libvlc_position_top; opacity: libvlc_opacity_t = libvlc_opacity_full); overload;
    procedure LogoShowFiles(file_names : array of WideString; position_x, position_y : Integer; opacity: libvlc_opacity_t = libvlc_opacity_full; delay_ms : Integer = 1000; loop : Boolean = TRUE); overload;
    procedure LogoShowFiles(file_names : array of WideString; position: libvlc_position_t = libvlc_position_top; opacity: libvlc_opacity_t = libvlc_opacity_full; delay_ms : Integer = 1000; loop : Boolean = TRUE); overload;
    procedure LogoHide();

    // https://wiki.videolan.org/Documentation:Modules/marq/
    procedure MarqueeSetText(marquee_text : WideString);
    procedure MarqueeSetPosition(position_x, position_y : Integer); overload;
    procedure MarqueeSetPosition(position : libvlc_position_t); overload;
    procedure MarqueeSetColor(color : libvlc_video_marquee_color_t);
    procedure MarqueeSetFontSize(font_size: Integer);
    procedure MarqueeSetOpacity(opacity: libvlc_opacity_t);
    procedure MarqueeSetTimeOut(time_out_ms: Integer);
    procedure MarqueeSetRefresh(refresh_after_ms: Integer);
    procedure MarqueeSetEnable(enable : Integer);

    procedure MarqueeShowText(marquee_text : WideString; position_x, position_y : Integer; color : libvlc_video_marquee_color_t = libvlc_video_marquee_color_White; font_size: Integer = libvlc_video_marquee_default_font_size; opacity: libvlc_opacity_t = libvlc_opacity_full; time_out_ms: Integer = 0); overload;
    procedure MarqueeShowText(marquee_text : WideString; position : libvlc_position_t = libvlc_position_bottom; color : libvlc_video_marquee_color_t = libvlc_video_marquee_color_White; font_size: Integer = libvlc_video_marquee_default_font_size; opacity: libvlc_opacity_t = libvlc_opacity_full; time_out_ms: Integer = 0); overload;
    procedure MarqueeHide();

    procedure EventsDisable();
    procedure EventsEnable();

    property  VLC : TPasLibVlc read GetVlcInstance;
    
  published
  
    property Align;
    property Color  default clBlack;
    property Width  default 320;
    property Height default 240;

    property Constraints;
    property DragKind;
    property DragMode;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Visible;
    {$IFDEF DELPHI2005_UP}
    property OnAlignPosition;
    {$ENDIF}
    {$IFNDEF FPC}
    property OnCanResize;
    {$ENDIF}
    property OnClick;
    property OnConstrainedResize;
    {$IFDEF HAS_OnContextPopup}
    property OnContextPopup;
    {$ENDIF}
    property OnDockDrop;
    property OnDockOver;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGetSiteInfo;
    {$IFDEF DELPHI2005_UP}
    property OnMouseActivate;
    {$ENDIF}
    property OnMouseDown;
    {$IFDEF DELPHI2006_UP}
    property OnMouseEnter;
    property OnMouseLeave;
    {$ENDIF}
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnStartDock;
    property OnStartDrag;
    property OnUnDock;

    property SpuShow : Boolean
      read    FSpuShow
      write   SetSpuShow
      default TRUE;

    property OsdShow : Boolean
      read    FOsdShow
      write   SetOsdShow
      default TRUE;

    property TitleShow : Boolean
      read    FTitleShow
      write   SetTitleShow
      default FALSE;

    property TitleShowPos : TPasLibVlcTitlePosition
      read FTitleShowPos
      write SetTitleShowPos
      default plvPosCenter;

    property TitleShowTimeOut : LongWord
      read FTitleShowTimeOut
      write SetTitleShowTimeOut
      default 2000;

    property VideoOutput : TVideoOutput
      read FVideoOutput
      write FVideoOutput
      default voDefault;

    property AudioOutput : TAudioOutput
      read FAudioOutput
      write FAudioOutput
      default aoDefault;

    property VideoOnTop : Boolean
      read    FVideoOnTop
      write   SetVideoOnTop
      default FALSE;

    property UseOverlay : Boolean
      read    FUseOverlay
      write   SetUseOverlay
      default FALSE;

    property SnapShotFmt : string
      read    FSnapShotFmt
      write   SetSnapshotFmt;

    property SnapshotPrv : Boolean
      read    FSnapShotPrv
      write   SetSnapshotPrv
      default FALSE;

    property DeinterlaceFilter : TDeinterlaceFilter
      read    FDeinterlaceFilter
      write   SetDeinterlaceFilter
      default deOFF;

    property DeinterlaceModeName:  WideString
      read    GetDeinterlaceModeName;

    property DeinterlaceMode : TDeinterlaceMode
      read    FDeinterlaceMode
      write   SetDeinterlaceMode
      default dmDISCARD;

    property ViewTeletext : Boolean
      read    FViewTeleText
      write   SetViewTeleText
      default FALSE;

    property LastError: string
      read   FError
      write  FError;

    property StartOptions : TStringList
      read FStartOptions
      write SetStartOptions;

    property OnMediaPlayerMediaChanged : TNotifyMediaChanged
      read  FOnMediaPlayerMediaChanged
      write FOnMediaPlayerMediaChanged;

    property OnMediaPlayerNothingSpecial : TNotifyEvent
      read  FOnMediaPlayerNothingSpecial
      write FOnMediaPlayerNothingSpecial;

    property OnMediaPlayerOpening : TNotifyEvent
      read  FOnMediaPlayerOpening
      write FOnMediaPlayerOpening;

    property OnMediaPlayerBuffering : TNotifyEvent
      read  FOnMediaPlayerBuffering
      write FOnMediaPlayerBuffering;

    property OnMediaPlayerPlaying : TNotifyEvent
      read  FOnMediaPlayerPlaying
      write FOnMediaPlayerPlaying;

    property OnMediaPlayerPaused : TNotifyEvent
      read  FOnMediaPlayerPaused
      write FOnMediaPlayerPaused;

    property OnMediaPlayerStopped : TNotifyEvent
      read  FOnMediaPlayerStopped
      write FOnMediaPlayerStopped;

    property OnMediaPlayerForward : TNotifyEvent
      read  FOnMediaPlayerForward
      write FOnMediaPlayerForward;

    property OnMediaPlayerBackward : TNotifyEvent
      read  FOnMediaPlayerBackward
      write FOnMediaPlayerBackward;

    property OnMediaPlayerEndReached : TNotifyEvent
      read  FOnMediaPlayerEndReached
      write FOnMediaPlayerEndReached;

    property OnMediaPlayerEncounteredError : TNotifyEvent
      read  FOnMediaPlayerEncounteredError
      write FOnMediaPlayerEncounteredError;

    property OnMediaPlayerTimeChanged : TNotifyTimeChanged
      read  FOnMediaPlayerTimeChanged
      write FOnMediaPlayerTimeChanged;

    property OnMediaPlayerPositionChanged : TNotifyPositionChanged
      read  FOnMediaPlayerPositionChanged
      write FOnMediaPlayerPositionChanged;

    property OnMediaPlayerSeekableChanged : TNotifySeekableChanged
      read  FOnMediaPlayerSeekableChanged
      write FOnMediaPlayerSeekableChanged;

    property OnMediaPlayerPausableChanged : TNotifyPausableChanged
      read  FOnMediaPlayerPausableChanged
      write FOnMediaPlayerPausableChanged;

    property OnMediaPlayerTitleChanged : TNotifyTitleChanged
      read  FOnMediaPlayerTitleChanged
      write FOnMediaPlayerTitleChanged;

    property OnMediaPlayerSnapshotTaken : TNotifySnapshotTaken
      read  FOnMediaPlayerSnapshotTaken
      write FOnMediaPlayerSnapshotTaken;

    property OnMediaPlayerLengthChanged : TNotifyLengthChanged
      read  FOnMediaPlayerLengthChanged
      write FOnMediaPlayerLengthChanged;

    property OnMediaPlayerVideoOutChanged : TNotifyVideoOutChanged
      read  FOnMediaPlayerVideoOutChanged
      write FOnMediaPlayerVideoOutChanged;

    property OnMediaPlayerScrambledChanged : TNotifyScrambledChanged
      read  FOnMediaPlayerScrambledChanged
      write FOnMediaPlayerScrambledChanged;

    property OnMediaPlayerEvent	: TNotifyPlayerEvent
      read FOnMediaPlayerEvent
      write FOnMediaPlayerEvent;

    property UseEvents : boolean
      read FUseEvents
      write FUseEvents default TRUE;

    property MouseEventsHandler : TPasLibVlcPlayerMouseEventsHandler
      read FMouseEventsHandler
      write SetMouseEventHandler default mehComponent;
  end;

  TNotifyMediaListItem = procedure(Sender: TObject; mrl: WideString; item: Pointer; index: Integer) of object;

  TPasLibVlcMediaList = class(TComponent)

  private
    p_ml              : libvlc_media_list_t_ptr;
    p_mlp             : libvlc_media_list_player_t_ptr;

    p_ml_ev_mgr       : libvlc_event_manager_t_ptr;
    p_mlp_ev_mgr      : libvlc_event_manager_t_ptr;

    FCS               : {$IFDEF HAS_SYNCOBJS}SyncObjs.{$ENDIF}TCriticalSection;

    FPlayer           : TPasLibVlcPlayer;
    FError            : string;

    FOnItemAdded      : TNotifyMediaListItem;
    FOnWillAddItem    : TNotifyMediaListItem;
    FOnItemDeleted    : TNotifyMediaListItem;
    FOnWillDeleteItem : TNotifyMediaListItem;
    FOnNextItemSet    : TNotifyMediaListItem;
    
    FOnPlayed         : TNotifyEvent;
    FOnStopped        : TNotifyEvent;

    procedure SetPlayer(aPlayer: TPasLibVlcPlayer);

    procedure InternalHandleEventItemAdded(item: libvlc_media_t_ptr; index: Integer);
    procedure InternalHandleEventItemDeleted(item: libvlc_media_t_ptr; index: Integer);
    procedure InternalHandleEventWillAddItem(item: libvlc_media_t_ptr; index: Integer);
    procedure InternalHandleEventWillDeleteItem(item: libvlc_media_t_ptr; index: Integer);
    procedure InternalHandleEventPlayerNextItemSet(item: libvlc_media_t_ptr);
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure SetPlayModeNormal;
    procedure SetPlayModeLoop;
    procedure SetPlayModeRepeat;

    procedure Play;
    procedure Pause;
    procedure Stop;
    procedure Next;
    procedure Prev;

    function  IsPlay(): Boolean;
    function  IsPause(): Boolean;

    function  GetState(): TPasLibVlcPlayerState;
    function  GetStateName() : string;

    procedure PlayItem(item: libvlc_media_t_ptr);

    procedure Clear();
    procedure Add(mrl: WideString);
    function  Get(index: Integer): WideString;
    function  Count(): Integer;
    procedure Delete(index: Integer);
    procedure Insert(index: Integer; mrl: WideString);

    function GetItemAtIndex(index: Integer): libvlc_media_t_ptr;
    function IndexOfItem(item: libvlc_media_t_ptr): Integer;

    procedure EventsDisable();
    procedure EventsEnable();
    
  published
  
    property Player: TPasLibVlcPlayer
      read FPlayer
      write SetPlayer;
      
    property LastError: string
      read FError
      write FError;

    property OnItemAdded : TNotifyMediaListItem
      read  FOnItemAdded
      write FOnItemAdded;

    property OnWillAddItem : TNotifyMediaListItem
      read  FOnWillAddItem
      write FOnWillAddItem;

    property OnItemDeleted : TNotifyMediaListItem
      read  FOnItemDeleted
      write FOnItemDeleted;

    property OnWillDeleteItem : TNotifyMediaListItem
      read  FOnWillDeleteItem
      write FOnWillDeleteItem;

    property OnPlayed : TNotifyEvent
      read  FOnPlayed write FOnPlayed;

    property OnStopped : TNotifyEvent
      read  FOnStopped write FOnStopped;

    property OnNextItemSet : TNotifyMediaListItem
      read  FOnNextItemSet
      write FOnNextItemSet;
  end;

  function time2str(timeInMs: Int64; fmt: string = 'hh:mm:ss.ms'): string;

procedure Register;


implementation

{$R *.RES}

{$IFDEF DELPHI_XE6_UP}
uses
	System.AnsiStrings;
{$ENDIF}

{$IFDEF FPC}
procedure RegisterPasLibVlcPlayerUnit;
begin
  RegisterComponents('PasLibVlc', [TPasLibVlcPlayer, TPasLibVlcMediaList]);
end;

procedure Register;
begin
  RegisterUnit('PasLibVlcPlayerUnit', @RegisterPasLibVlcPlayerUnit);
end;
{$ELSE}
procedure Register;
begin
  RegisterComponents('PasLibVlc', [TPasLibVlcPlayer, TPasLibVlcMediaList]);
end;
{$ENDIF}

function w2s(w: word): string;
begin
  if (w < 10)  then Result := '0' + IntToStr(w)
  else              Result := IntToStr(w);
end;

function time2str(timeInMs: Int64; fmt: string = 'hh:mm:ss.ms'): string;
var
  dd, hh, mm, ss, ms: Word;
begin
  if (timeInMs < 0) then timeInMs := 0;

  ms := timeInMs mod 1000; timeInMs := timeInMs div 1000;
  ss := timeInMs mod 60;   timeInMs := timeInMs div 60;
  mm := timeInMs mod 60;   timeInMs := timeInMs div 60;
  hh := timeInMs mod 24;   timeInMs := timeInMs div 24;
  dd := timeInMs;

  Result := fmt;
  Result := StringReplace(Result, 'dd',  w2s(dd), [rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace(Result, 'hh',  w2s(hh), [rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace(Result, 'mm',  w2s(mm), [rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace(Result, 'ss',  w2s(ss), [rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace(Result, 'ms',  w2s(ms), [rfReplaceAll, rfIgnoreCase]);
end;

////////////////////////////////////////////////////////////////////////////////

procedure lib_vlc_player_event_hdlr(p_event: libvlc_event_t_ptr; data: Pointer); cdecl; forward;
procedure lib_vlc_media_list_event_hdlr(p_event: libvlc_event_t_ptr; data: Pointer); cdecl; forward;
procedure lib_vlc_media_list_player_event_hdlr(p_event: libvlc_event_t_ptr; data: Pointer); cdecl; forward;

////////////////////////////////////////////////////////////////////////////////

constructor TPasLibVlcMediaList.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  p_ml         := NIL;
  p_mlp        := NIL;
  
  p_ml_ev_mgr  := NIL;
  p_mlp_ev_mgr := NIL;

  FPlayer      := NIL;

  FCS := {$IFDEF HAS_SYNCOBJS}SyncObjs.{$ENDIF}TCriticalSection.Create;

  if (csDesigning in ComponentState) then exit;
end;

destructor TPasLibVlcMediaList.Destroy;
begin
  FCS.Enter;

  try
    EventsDisable();

    Sleep(100);
    
    if (p_mlp <> NIL) then
    begin
      libvlc_media_list_player_stop(p_mlp);
      while (libvlc_media_list_player_is_playing(p_mlp) <> 0) do
      begin
        Sleep(10);
      end;
    end;

    if (p_mlp <> NIL) then
    begin
      libvlc_media_list_player_release(p_mlp);
    end;

    if (p_ml <> NIL) then
    begin
      libvlc_media_list_release(p_ml);
    end;
  finally
    FCS.Leave;
  end;

  FCS.Free;

  inherited Destroy;
end;

procedure TPasLibVlcMediaList.EventsDisable();
begin
  if Assigned(p_mlp_ev_mgr) then
  begin
    libvlc_event_detach(p_mlp_ev_mgr, libvlc_MediaListPlayerNextItemSet, lib_vlc_media_list_player_event_hdlr, SELF);
    libvlc_event_detach(p_mlp_ev_mgr, libvlc_MediaListPlayerStopped,     lib_vlc_media_list_player_event_hdlr, SELF);
    libvlc_event_detach(p_mlp_ev_mgr, libvlc_MediaListPlayerPlayed,      lib_vlc_media_list_player_event_hdlr, SELF);
  end;

  if Assigned(p_ml_ev_mgr) then
  begin
    libvlc_event_detach(p_ml_ev_mgr, libvlc_MediaListWillDeleteItem, lib_vlc_media_list_event_hdlr, SELF);
    libvlc_event_detach(p_ml_ev_mgr, libvlc_MediaListItemDeleted,    lib_vlc_media_list_event_hdlr, SELF);
    libvlc_event_detach(p_ml_ev_mgr, libvlc_MediaListWillAddItem,    lib_vlc_media_list_event_hdlr, SELF);
    libvlc_event_detach(p_ml_ev_mgr, libvlc_MediaListItemAdded,      lib_vlc_media_list_event_hdlr, SELF);
  end;

  p_mlp_ev_mgr := NIL;
  p_ml_ev_mgr := NIL;
end;

procedure TPasLibVlcMediaList.EventsEnable();
begin
  EventsDisable();

  if (p_ml <> NIL) then
  begin
    p_ml_ev_mgr := libvlc_media_list_event_manager(p_ml);

    if Assigned(p_ml_ev_mgr) then
    begin
      libvlc_event_attach(p_ml_ev_mgr, libvlc_MediaListItemAdded,      lib_vlc_media_list_event_hdlr, SELF);
      libvlc_event_attach(p_ml_ev_mgr, libvlc_MediaListWillAddItem,    lib_vlc_media_list_event_hdlr, SELF);
      libvlc_event_attach(p_ml_ev_mgr, libvlc_MediaListItemDeleted,    lib_vlc_media_list_event_hdlr, SELF);
      libvlc_event_attach(p_ml_ev_mgr, libvlc_MediaListWillDeleteItem, lib_vlc_media_list_event_hdlr, SELF);
    end;

    p_mlp_ev_mgr := libvlc_media_list_player_event_manager(p_mlp);

    if Assigned(p_mlp_ev_mgr) then
    begin
      libvlc_event_attach(p_mlp_ev_mgr, libvlc_MediaListPlayerPlayed,      lib_vlc_media_list_player_event_hdlr, SELF);
      libvlc_event_attach(p_mlp_ev_mgr, libvlc_MediaListPlayerStopped,     lib_vlc_media_list_player_event_hdlr, SELF);
      libvlc_event_attach(p_mlp_ev_mgr, libvlc_MediaListPlayerNextItemSet, lib_vlc_media_list_player_event_hdlr, SELF);
    end;
  end;
end;

procedure TPasLibVlcMediaList.SetPlayer(aPlayer: TPasLibVlcPlayer);
begin
  FPlayer := aPlayer;

  if (csDesigning in ComponentState) then exit;

  if (FPlayer.VLC.Handle <> NIL) then
  begin
    p_ml  := libvlc_media_list_new(FPlayer.VLC.Handle);
    p_mlp := libvlc_media_list_player_new(FPlayer.VLC.Handle);

    libvlc_media_list_player_set_media_list(p_mlp, p_ml);

    EventsEnable();
  end;
end;

procedure TPasLibVlcMediaList.SetPlayModeNormal;
begin
  if not Assigned(FPlayer) then exit;

  if (p_mlp <> NIL) then
  begin
    libvlc_media_list_player_set_playback_mode(p_mlp, libvlc_playback_mode_default);
  end;
end;

procedure TPasLibVlcMediaList.SetPlayModeLoop;
begin
  if not Assigned(FPlayer) then exit;

  if (p_mlp <> NIL) then
  begin
    libvlc_media_list_player_set_playback_mode(p_mlp, libvlc_playback_mode_loop);
  end;
end;

procedure TPasLibVlcMediaList.SetPlayModeRepeat;
begin
  if not Assigned(FPlayer) then exit;

  if (p_mlp <> NIL) then
  begin
    libvlc_media_list_player_set_playback_mode(p_mlp, libvlc_playback_mode_repeat);
  end;
end;

procedure TPasLibVlcMediaList.Play;
begin
  if not Assigned(FPlayer) then exit;

  if (p_mlp <> NIL) then
  begin
    libvlc_media_list_player_set_media_player(p_mlp, FPlayer.GetPlayerHandle());
    FPlayer.SetHwnd();

    libvlc_media_list_player_play(p_mlp);
  end;
end;

procedure TPasLibVlcMediaList.PlayItem(item: libvlc_media_t_ptr);
begin
  if not Assigned(FPlayer) then exit;

  if (p_mlp <> NIL) then
  begin
    libvlc_media_list_player_set_media_player(p_mlp, FPlayer.GetPlayerHandle());
    FPlayer.SetHwnd();
    libvlc_media_list_player_play_item(p_mlp, item);
  end;
end;

procedure TPasLibVlcMediaList.Pause;
begin
  if not Assigned(FPlayer) then exit;

  if (p_mlp <> NIL) then
  begin
    libvlc_media_list_player_pause(p_mlp);
  end;
end;

procedure TPasLibVlcMediaList.Stop;
begin
  if not Assigned(FPlayer) then exit;

  if (p_mlp <> NIL) then
  begin
    libvlc_media_list_player_stop(p_mlp);
    while (libvlc_media_list_player_is_playing(p_mlp) <> 0) do
    begin
    end;
  end;
end;

procedure TPasLibVlcMediaList.Next;
begin
  if not Assigned(FPlayer) then exit;

  if (p_mlp <> NIL) then
  begin
    libvlc_media_list_player_set_media_player(p_mlp, FPlayer.GetPlayerHandle());
    FPlayer.SetHwnd();
    libvlc_media_list_player_next(p_mlp);
  end;
end;

procedure TPasLibVlcMediaList.Prev;
begin
  if not Assigned(FPlayer) then exit;

  if (p_mlp <> NIL) then
  begin
    libvlc_media_list_player_set_media_player(p_mlp, FPlayer.GetPlayerHandle());
    FPlayer.SetHwnd();
    libvlc_media_list_player_previous(p_mlp);
  end;
end;

function TPasLibVlcMediaList.IsPlay(): Boolean;
begin
  Result := FALSE;
  if not Assigned(FPlayer) then exit;

  if (p_mlp <> NIL) then
  begin
    Result := (libvlc_media_list_player_is_playing(p_mlp) <> 0);
  end;
end;

function TPasLibVlcMediaList.IsPause(): Boolean;
begin
  Result := FALSE;
  if not Assigned(FPlayer) then exit;

  if (p_mlp <> NIL) then
  begin
    Result := (libvlc_media_list_player_get_state(p_mlp) = libvlc_Paused);
  end;
end;

function TPasLibVlcMediaList.GetState(): TPasLibVlcPlayerState;
begin
  Result := plvPlayer_NothingSpecial;

  if not Assigned(FPlayer) then exit;
  
  if (p_mlp = NIL) then exit;

  case libvlc_media_list_player_get_state(p_mlp) of
    libvlc_NothingSpecial: Result := plvPlayer_NothingSpecial;
    libvlc_Opening:        Result := plvPlayer_Opening;
    libvlc_Buffering:      Result := plvPlayer_Buffering;
    libvlc_Playing:        Result := plvPlayer_Playing;
    libvlc_Paused:         Result := plvPlayer_Paused;
    libvlc_Stopped:        Result := plvPlayer_Stopped;
    libvlc_Ended:          Result := plvPlayer_Ended;
    libvlc_Error:          Result := plvPlayer_Error;
  end;
end;

function TPasLibVlcMediaList.GetStateName(): string;
begin
  if Assigned(FPlayer) then
  begin
    if (p_mlp <> NIL) then
    begin
      case GetState() of
        plvPlayer_NothingSpecial: Result := 'Nothing Special';
        plvPlayer_Opening:        Result := 'Opening';
        plvPlayer_Buffering:      Result := 'Buffering';
        plvPlayer_Playing:        Result := 'Playing';
        plvPlayer_Paused:         Result := 'Paused';
        plvPlayer_Stopped:        Result := 'Stopped';
        plvPlayer_Ended:          Result := 'Ended';
        plvPlayer_Error:          Result := 'Error';
        else                      Result := 'Invalid State';
      end;
    end
    else Result := 'VLC Media List not initialised';
  end
  else Result:='VLC Media List no player assigned';
end;

procedure TPasLibVlcMediaList.Clear();
begin
  if not Assigned(FPlayer) then exit;
  
  while (Count() > 0) do
  begin
    Delete(0);
  end;
end;

procedure TPasLibVlcMediaList.Add(mrl: WideString);
var
  media : TPasLibVlcMedia;
begin
  if not Assigned(FPlayer) then exit;

  if (p_ml = NIL) then SetPlayer(FPlayer);

  media := TPasLibVlcMedia.Create(FPlayer.VLC, mrl);
  if Assigned(SELF.FPlayer) then
  begin
    media.SetDeinterlaceFilter(SELF.FPlayer.FDeinterlaceFilter);
    media.SetDeinterlaceFilterMode(SELF.FPlayer.FDeinterlaceMode);
  end;

  if (p_ml <> NIL) then
  begin
    libvlc_media_list_lock(p_ml);
    libvlc_media_list_add_media(p_ml, media.MD);
    libvlc_media_list_unlock(p_ml);
  end;
  media.Free;
end;

function TPasLibVlcMediaList.Get(index: Integer): WideString;
var
  p_md : libvlc_media_t_ptr;
  mrl  : PAnsiChar;
begin
  Result := '';
  if not Assigned(FPlayer) then exit;
  
  p_md := GetItemAtIndex(index);
  if Assigned(p_md) then
  begin
    mrl := libvlc_media_get_mrl(p_md);
    Result := {$IFDEF DELPHI_XE2_UP}UTF8ToWideString{$ELSE}UTF8Decode{$ENDIF}(mrl);
  end;
end;

function TPasLibVlcMediaList.Count(): Integer;
begin
  Result := 0;
  if not Assigned(FPlayer) then exit;

  if (p_ml <> NIL) then
  begin
    libvlc_media_list_lock(p_ml);
    Result := libvlc_media_list_count(p_ml);
    libvlc_media_list_unlock(p_ml);
  end;
end;

procedure TPasLibVlcMediaList.Delete(index: Integer);
begin
  if not Assigned(FPlayer) then exit;

  if (p_ml <> NIL) then
  begin
    libvlc_media_list_lock(p_ml);
    libvlc_media_list_remove_index(p_ml, index);
    libvlc_media_list_unlock(p_ml);
  end;
end;

procedure TPasLibVlcMediaList.Insert(index: Integer; mrl: WideString);
var
  media: TPasLibVlcMedia;
begin
  if not Assigned(FPlayer) then exit;

  media := TPasLibVlcMedia.Create(FPlayer.VLC, mrl);

  media.SetDeinterlaceFilter(SELF.FPlayer.FDeinterlaceFilter);
  media.SetDeinterlaceFilterMode(SELF.FPlayer.FDeinterlaceMode);

  if (p_ml <> NIL) then
  begin
    libvlc_media_list_lock(p_ml);
    libvlc_media_list_insert_media(p_ml, media.MD, index);
    libvlc_media_list_unlock(p_ml);
  end;

  media.Free;
end;

function TPasLibVlcMediaList.GetItemAtIndex(index: Integer): libvlc_media_t_ptr;
begin
  Result := NIL;
  if not Assigned(FPlayer) then exit;

  if (p_ml <> NIL) then
  begin
    libvlc_media_list_lock(p_ml);
    Result := libvlc_media_list_item_at_index(p_ml, index);
    libvlc_media_list_unlock(p_ml);
  end;
end;

function TPasLibVlcMediaList.IndexOfItem(item: libvlc_media_t_ptr): Integer;
begin
  Result := -1;
  if not Assigned(FPlayer) then exit;

  if (p_ml <> NIL) then
  begin
    libvlc_media_list_lock(p_ml);
    Result := libvlc_media_list_index_of_item(p_ml, item);
    libvlc_media_list_unlock(p_ml);
  end;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TPasLibVlcMediaList.InternalHandleEventItemAdded(item: libvlc_media_t_ptr; index: Integer);
var
  mrl: WideString;
begin
  if Assigned(FOnItemAdded) then
  begin
    mrl := {$IFDEF DELPHI_XE2_UP}UTF8ToWideString{$ELSE}UTF8Decode{$ENDIF}(libvlc_media_get_mrl(item));
    OnItemAdded(SELF, mrl, item, index);
  end;
end;

procedure TPasLibVlcMediaList.InternalHandleEventItemDeleted(item: libvlc_media_t_ptr; index: Integer);
var
  mrl: WideString;
begin
  if Assigned(FOnItemDeleted) then
  begin
    mrl := {$IFDEF DELPHI_XE2_UP}UTF8ToWideString{$ELSE}UTF8Decode{$ENDIF}(libvlc_media_get_mrl(item));
    OnItemDeleted(SELF, mrl, item, index);
  end;
end;

procedure TPasLibVlcMediaList.InternalHandleEventWillAddItem(item: libvlc_media_t_ptr; index: Integer);
var
  mrl: WideString;
begin
  if Assigned(FOnWillAddItem) then
  begin
    mrl := {$IFDEF DELPHI_XE2_UP}UTF8ToWideString{$ELSE}UTF8Decode{$ENDIF}(libvlc_media_get_mrl(item));
    OnItemAdded(SELF, mrl, item, index);
  end;
end;

procedure TPasLibVlcMediaList.InternalHandleEventWillDeleteItem(item: libvlc_media_t_ptr; index: Integer);
var
  mrl: WideString;
begin
  if Assigned(FOnWillDeleteItem) then
  begin
    mrl := {$IFDEF DELPHI_XE2_UP}UTF8ToWideString{$ELSE}UTF8Decode{$ENDIF}(libvlc_media_get_mrl(item));
    OnWillDeleteItem(SELF, mrl, item, index);
  end;
end;

procedure TPasLibVlcMediaList.InternalHandleEventPlayerNextItemSet(item: libvlc_media_t_ptr);
var
  mrl: WideString;
  idx: Integer;
begin
  if Assigned(FOnNextItemSet) then
  begin
    mrl := {$IFDEF DELPHI_XE2_UP}UTF8ToWideString{$ELSE}UTF8Decode{$ENDIF}(libvlc_media_get_mrl(item));
    idx := IndexOfItem(item);
    OnNextItemSet(SELF, mrl, item, idx);
  end;
end;

////////////////////////////////////////////////////////////////////////////////

constructor TPasLibVlcPlayer.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  
  Color      := clBlack;
  Width      := 320;
  Height     := 240;

  FVideoOutput := voDefault;
  FAudioOutput := aoDefault;

  FTitleShow        := FALSE;
  FTitleShowPos     := plvPosCenter;
  FTitleShowTimeOut := 2000;

  FSnapshotFmt  := 'png';
  FSnapShotPrv  := FALSE;

  FSpuShow      := TRUE;
  FOsdShow      := TRUE;

  FUseOverlay   := FALSE;
  FVideoOnTop   := FALSE;

  FViewTeleText := FALSE;

  {$IFDEF HAS_ParentBackground}
  ParentBackground := False;
  {$ENDIF}

  Caption            := '';
  BevelOuter         := bvNone;
  p_mi               := NIL;
  p_mi_ev_mgr        := NIL;
  FMute              := FALSE;
  FPlayerWinCtrl     := NIL;
  FMouseEventWinCtrl := NIL;
  FVLC               := NIL;
  p_mi               := NIL;

  FUseEvents         := TRUE;

  FMouseEventsHandler := mehComponent;

  FStartOptions      := TStringList.Create;
  FCS                := {$IFDEF HAS_SYNCOBJS}SyncObjs.{$ENDIF}TCriticalSection.Create;

  if (csDesigning in ComponentState) then exit;

  FPlayerWinCtrl := TWinControl.Create(SELF);
  SELF.InsertControl(FPlayerWinCtrl);
  FPlayerWinCtrl.SetBounds(0, 0, SELF.Width, SELF.Height);

  FMouseEventWinCtrl := TPasLibVlcMouseEventWinCtrl.Create(SELF);
  SELF.InsertControl(FMouseEventWinCtrl);
  FMouseEventWinCtrl.SetBounds(0, 0, SELF.Width, SELF.Height);

  FMouseEventWinCtrl.OnClick         := InternalOnClick;
  FMouseEventWinCtrl.OnDblClick      := InternalOnDblClick;
  FMouseEventWinCtrl.OnMouseDown     := InternalOnMouseDown;
  FMouseEventWinCtrl.OnMouseMove     := InternalOnMouseMove;
  FMouseEventWinCtrl.OnMouseUp       := InternalOnMouseUp;
  {$IFDEF DELPHI2005_UP}
  FMouseEventWinCtrl.OnMouseActivate := InternalOnMouseActivate;
  {$ENDIF}
  {$IFDEF DELPHI2006_UP}
  FMouseEventWinCtrl.OnMouseEnter    := InternalOnMouseEnter;
  FMouseEventWinCtrl.OnMouseLeave    := InternalOnMouseLeave;
  {$ENDIF}
end;

procedure TPasLibVlcPlayer.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);

  if (Assigned(FPlayerWinCtrl)) then
  begin
    FPlayerWinCtrl.SetBounds(0, 0, SELF.Width, SELF.Height);
  end;

  if (Assigned(FMouseEventWinCtrl)) then
  begin
    if (FMouseEventsHandler = mehComponent) then
    begin
      FMouseEventWinCtrl.SetBounds(0, 0, SELF.Width, SELF.Height);
    end
    else
    begin
      FMouseEventWinCtrl.SetBounds(-1, -1, 1, 1);
    end;
  end;
end;

destructor TPasLibVlcPlayer.Destroy;
begin
  FCS.Enter;
  try
    EventsDisable();
    Sleep(10);
    
    if (p_mi <> NIL) then
    begin
      libvlc_media_player_stop(p_mi);
      while (libvlc_media_player_is_playing(p_mi) <> 0) do
      begin
        Sleep(10);
      end;
    end;

    p_mi_ev_mgr := NIL;

    if (p_mi <> NIL) then
    begin
      libvlc_media_player_release(p_mi);
    end;

    p_mi := NIL;
    
  finally
    FCS.Leave;
  end;

  FCS.Free;

  FStartOptions.Free;

  if Assigned(FVLC) then
  begin
    FVLC.Free;
  end;

  inherited Destroy;
end;

procedure TPasLibVlcPlayer.EventsEnable();
begin

  EventsDisable();
  
  if (p_mi <> NIL) then
  begin
    p_mi_ev_mgr := libvlc_media_player_event_manager(p_mi);

    if Assigned(p_mi_ev_mgr) then
    begin
      libvlc_event_attach(p_mi_ev_mgr, libvlc_MediaPlayerMediaChanged,     lib_vlc_player_event_hdlr, SELF);
      libvlc_event_attach(p_mi_ev_mgr, libvlc_MediaPlayerNothingSpecial,   lib_vlc_player_event_hdlr, SELF);
      libvlc_event_attach(p_mi_ev_mgr, libvlc_MediaPlayerOpening,          lib_vlc_player_event_hdlr, SELF);
      libvlc_event_attach(p_mi_ev_mgr, libvlc_MediaPlayerBuffering,        lib_vlc_player_event_hdlr, SELF);
      libvlc_event_attach(p_mi_ev_mgr, libvlc_MediaPlayerPlaying,          lib_vlc_player_event_hdlr, SELF);
      libvlc_event_attach(p_mi_ev_mgr, libvlc_MediaPlayerPaused,           lib_vlc_player_event_hdlr, SELF);
      libvlc_event_attach(p_mi_ev_mgr, libvlc_MediaPlayerStopped,          lib_vlc_player_event_hdlr, SELF);
      libvlc_event_attach(p_mi_ev_mgr, libvlc_MediaPlayerForward,          lib_vlc_player_event_hdlr, SELF);
      libvlc_event_attach(p_mi_ev_mgr, libvlc_MediaPlayerBackward,         lib_vlc_player_event_hdlr, SELF);
      libvlc_event_attach(p_mi_ev_mgr, libvlc_MediaPlayerEndReached,       lib_vlc_player_event_hdlr, SELF);
      libvlc_event_attach(p_mi_ev_mgr, libvlc_MediaPlayerEncounteredError, lib_vlc_player_event_hdlr, SELF);
      libvlc_event_attach(p_mi_ev_mgr, libvlc_MediaPlayerTimeChanged,      lib_vlc_player_event_hdlr, SELF);
      libvlc_event_attach(p_mi_ev_mgr, libvlc_MediaPlayerPositionChanged,  lib_vlc_player_event_hdlr, SELF);
      libvlc_event_attach(p_mi_ev_mgr, libvlc_MediaPlayerSeekableChanged,  lib_vlc_player_event_hdlr, SELF);
      libvlc_event_attach(p_mi_ev_mgr, libvlc_MediaPlayerPausableChanged,  lib_vlc_player_event_hdlr, SELF);
      libvlc_event_attach(p_mi_ev_mgr, libvlc_MediaPlayerTitleChanged,     lib_vlc_player_event_hdlr, SELF);
      libvlc_event_attach(p_mi_ev_mgr, libvlc_MediaPlayerSnapshotTaken,    lib_vlc_player_event_hdlr, SELF);
      libvlc_event_attach(p_mi_ev_mgr, libvlc_MediaPlayerLengthChanged,    lib_vlc_player_event_hdlr, SELF);
      libvlc_event_attach(p_mi_ev_mgr, libvlc_MediaPlayerVout,             lib_vlc_player_event_hdlr, SELF);
      libvlc_event_attach(p_mi_ev_mgr, libvlc_MediaPlayerScrambledChanged, lib_vlc_player_event_hdlr, SELF);
    end;
  end;
end;

procedure TPasLibVlcPlayer.EventsDisable();
begin
  if Assigned(p_mi_ev_mgr) then
  begin
    libvlc_event_detach(p_mi_ev_mgr, libvlc_MediaPlayerScrambledChanged, lib_vlc_player_event_hdlr, SELF);
    libvlc_event_detach(p_mi_ev_mgr, libvlc_MediaPlayerVout,             lib_vlc_player_event_hdlr, SELF);
    libvlc_event_detach(p_mi_ev_mgr, libvlc_MediaPlayerLengthChanged,    lib_vlc_player_event_hdlr, SELF);
    libvlc_event_detach(p_mi_ev_mgr, libvlc_MediaPlayerSnapshotTaken,    lib_vlc_player_event_hdlr, SELF);
    libvlc_event_detach(p_mi_ev_mgr, libvlc_MediaPlayerTitleChanged,     lib_vlc_player_event_hdlr, SELF);
    libvlc_event_detach(p_mi_ev_mgr, libvlc_MediaPlayerPausableChanged,  lib_vlc_player_event_hdlr, SELF);
    libvlc_event_detach(p_mi_ev_mgr, libvlc_MediaPlayerSeekableChanged,  lib_vlc_player_event_hdlr, SELF);
    libvlc_event_detach(p_mi_ev_mgr, libvlc_MediaPlayerPositionChanged,  lib_vlc_player_event_hdlr, SELF);
    libvlc_event_detach(p_mi_ev_mgr, libvlc_MediaPlayerTimeChanged,      lib_vlc_player_event_hdlr, SELF);
    libvlc_event_detach(p_mi_ev_mgr, libvlc_MediaPlayerEncounteredError, lib_vlc_player_event_hdlr, SELF);
    libvlc_event_detach(p_mi_ev_mgr, libvlc_MediaPlayerEndReached,       lib_vlc_player_event_hdlr, SELF);
    libvlc_event_detach(p_mi_ev_mgr, libvlc_MediaPlayerBackward,         lib_vlc_player_event_hdlr, SELF);
    libvlc_event_detach(p_mi_ev_mgr, libvlc_MediaPlayerForward,          lib_vlc_player_event_hdlr, SELF);
    libvlc_event_detach(p_mi_ev_mgr, libvlc_MediaPlayerStopped,          lib_vlc_player_event_hdlr, SELF);
    libvlc_event_detach(p_mi_ev_mgr, libvlc_MediaPlayerPaused,           lib_vlc_player_event_hdlr, SELF);
    libvlc_event_detach(p_mi_ev_mgr, libvlc_MediaPlayerPlaying,          lib_vlc_player_event_hdlr, SELF);
    libvlc_event_detach(p_mi_ev_mgr, libvlc_MediaPlayerBuffering,        lib_vlc_player_event_hdlr, SELF);
    libvlc_event_detach(p_mi_ev_mgr, libvlc_MediaPlayerOpening,          lib_vlc_player_event_hdlr, SELF);
    libvlc_event_detach(p_mi_ev_mgr, libvlc_MediaPlayerNothingSpecial,   lib_vlc_player_event_hdlr, SELF);
    libvlc_event_detach(p_mi_ev_mgr, libvlc_MediaPlayerMediaChanged,     lib_vlc_player_event_hdlr, SELF);
  end;
end;

procedure TPasLibVlcPlayer.SetSnapshotFmt(aFormat: string);
begin
  FSnapShotFmt := 'png';
  aFormat := AnsiLowerCase(aFormat);
  if ((aFormat = 'png') or (aFormat = 'jpg')) then
  begin
    FSnapShotFmt := aFormat;
  end;
end;

procedure TPasLibVlcPlayer.SetSnapshotPrv(aValue: Boolean);
begin
  if (FSnapshotPrv <> aValue) then
  begin
    FSnapshotPrv := aValue;
  end;
end;

procedure TPasLibVlcPlayer.SetSpuShow(aValue: Boolean);
begin
  if (FSpuShow <> aValue) then
  begin
    FSpuShow := aValue;
  end;
end;

procedure TPasLibVlcPlayer.SetOsdShow(aValue: Boolean);
begin
  if (FOsdShow <> aValue) then
  begin
    FOsdShow := aValue;
  end;
end;

procedure TPasLibVlcPlayer.UpdateTitleShow();
begin
  if (p_mi <> NIL) and (VLC.VersionBin >= $020100) then
  begin
    if FTitleShow then
    begin
      case FTitleShowPos of
        plvPosCenter:      libvlc_media_player_set_video_title_display(p_mi, libvlc_position_center,       FTitleShowTimeOut);
        plvPosLeft:        libvlc_media_player_set_video_title_display(p_mi, libvlc_position_left,         FTitleShowTimeOut);
        plvPosRight:       libvlc_media_player_set_video_title_display(p_mi, libvlc_position_right,        FTitleShowTimeOut);
        plvPosTop:         libvlc_media_player_set_video_title_display(p_mi, libvlc_position_top,          FTitleShowTimeOut);
        plvPosTopLeft:     libvlc_media_player_set_video_title_display(p_mi, libvlc_position_top_left,     FTitleShowTimeOut);
        plvPosTopRight:    libvlc_media_player_set_video_title_display(p_mi, libvlc_position_top_right,    FTitleShowTimeOut);
        plvPosBottom:      libvlc_media_player_set_video_title_display(p_mi, libvlc_position_bottom,       FTitleShowTimeOut);
        plvPosBottomLeft:  libvlc_media_player_set_video_title_display(p_mi, libvlc_position_bottom_left,  FTitleShowTimeOut);
        plvPosBottomRight: libvlc_media_player_set_video_title_display(p_mi, libvlc_position_bottom_right, FTitleShowTimeOut);
      end;
    end
    else
    begin
      libvlc_media_player_set_video_title_display(p_mi, libvlc_position_disable, FTitleShowTimeOut);
    end;
  end;
end;

procedure TPasLibVlcPlayer.SetTitleShow(aValue: Boolean);
begin
  if (FTitleShow <> aValue) then
  begin
    FTitleShow := aValue;
    UpdateTitleShow();
  end;
end;

procedure TPasLibVlcPlayer.SetTitleShowPos(aValue: TPasLibVlcTitlePosition);
begin
  if (FTitleShowPos <> aValue) then
  begin
    FTitleShowPos := aValue;
    UpdateTitleShow();
  end;
end;

procedure TPasLibVlcPlayer.SetTitleShowTimeOut(aValue: LongWord);
begin
  if (FTitleShowTimeOut <> aValue) then
  begin
    FTitleShowTimeOut := aValue;
    UpdateTitleShow();
  end;
end;

procedure TPasLibVlcPlayer.SetVideoOnTop(aValue : Boolean);
begin
  if (FVideoOnTop <> aValue) then
  begin
    FVideoOnTop := aValue;
  end;
end;

procedure TPasLibVlcPlayer.SetUseOverlay(aValue : Boolean);
begin
  if (FUseOverlay <> aValue) then
  begin
    FUseOverlay := aValue;
  end;
end;

procedure TPasLibVlcPlayer.SetViewTeleText(aValue : Boolean);
begin
  if (FViewTeleText <> aValue) then
  begin
    if aValue then ShowTeleText() else HideTeleText();
  end;
end;

procedure TPasLibVlcPlayer.UpdateDeInterlace();
var
  dm: string;
begin
  if (p_mi = NIL) then exit;

  if (FDeinterlaceFilter = deON) then
  begin
    dm := vlcDeinterlaceModeNames[FDeinterlaceMode];
  end
  else
  begin
    dm := '';
  end;

  if (dm <> '') then
  begin
    libvlc_video_set_deinterlace(p_mi, PAnsiChar(Utf8Encode(dm)));
  end
  else
  begin
    libvlc_video_set_deinterlace(p_mi, NIL);
  end;
end;

function TPasLibVlcPlayer.GetDeinterlaceModeName(): WideString;
begin
  Result := vlcDeinterlaceModeNames[FDeinterlaceMode];
end;

procedure TPasLibVlcPlayer.SetDeinterlaceFilter(aValue: TDeinterlaceFilter);
begin
  if (FDeinterlaceFilter <> aValue) then
  begin
    FDeinterlaceFilter := aValue;
    UpdateDeInterlace();
  end;
end;

procedure TPasLibVlcPlayer.SetDeinterlaceMode(aValue: TDeinterlaceMode);
begin
  if (FDeinterlaceMode <> aValue) then
  begin
    FDeinterlaceMode := aValue;
    UpdateDeInterlace();
  end;
end;

procedure TPasLibVlcPlayer.SetHwnd();
begin
  if (p_mi <> NIL) then
  begin
    libvlc_media_player_set_display_window(p_mi, FPlayerWinCtrl.Handle);
  end;
end;

function TPasLibVlcPlayer.GetVlcInstance() : TPasLibVlc;
var
  oIdx : Integer;
begin
  if not Assigned(FVLC) then
  begin
    FVLC := TPasLibVlc.Create;

    for oIdx := 0 to FStartOptions.Count - 1 do
    begin
      FVLC.AddOption(FStartOptions.Strings[oIdx]);
    end;

    FVLC.AddOption('--ignore-config');
    FVLC.AddOption('--no-one-instance');
    FVLC.AddOption('--intf=dummy');
    FVLC.AddOption('--quiet');
    FVLC.AddOption('--drop-late-frames');

    // for versions before 2.1.0
    FVLC.TitleShow := FTitleShow;

    if not FSpuShow     then FVLC.AddOption('--no-spu')              else FVLC.AddOption('--spu');
    if not FOsdShow     then FVLC.AddOption('--no-osd')              else FVLC.AddOption('--osd');
    if not FVideoOnTop  then FVLC.AddOption('--no-video-on-top')     else FVLC.AddOption('--video-on-top');
    if not FUseOverlay  then FVLC.AddOption('--no-overlay')          else FVLC.AddOption('--overlay');
    if not FSnapshotPrv then FVLC.AddOption('--no-snapshot-preview') else FVLC.AddOption('--snapshot-preview');

    if (FVideoOutput <> voDefault) then FVLC.AddOption('--vout=' + vlcVideoOutputNames[FVideoOutput]);
    if (FAudioOutput <> aoDefault) then FVLC.AddOption('--aout=' + vlcAudioOutputNames[FAudioOutput]);
  end;
  Result := FVLC;
end;

procedure TPasLibVlcPlayer.SetStartOptions(Value: TStringList);
begin
  FStartOptions.Assign(Value);
end;

procedure TPasLibVlcPlayer.SetMouseEventHandler(aValue : TPasLibVlcPlayerMouseEventsHandler);
begin
  FMouseEventsHandler := aValue;

  if Assigned(FMouseEventWinCtrl) then
  begin
    if (FMouseEventsHandler = mehComponent) then
    begin
      FMouseEventWinCtrl.SetBounds(0, 0, SELF.Width, SELF.Height);
    end
    else
    begin
      FMouseEventWinCtrl.SetBounds(-1, -1, 1, 1);
    end;
  end;
end;

function TPasLibVlcPlayer.GetPlayerHandle(): libvlc_media_player_t_ptr;
var
   p_instance : libvlc_instance_t_ptr;
begin
  
  if (p_mi = NIL) then
  begin
    // get instance
    p_instance := VLC.Handle;

    if (p_instance <> NIL) then
    begin
      // create media player
      p_mi := libvlc_media_player_new(p_instance);

      // handling mouse events by vlc ???
      if (p_mi <> NIL) then
      begin
        libvlc_video_set_mouse_input(p_mi, 1);
        libvlc_video_set_key_input(p_mi, 1);
      end;
    end;

  end;

  UpdateTitleShow();

  if FUseEvents then EventsEnable();

  Result := p_mi;
end;

function GetToSep(var str : WideString; sep : WideString) : WideString;
var
  p : Integer;
begin
  p := Pos(sep, str);
  if (p > 0) then
  begin
    Result := Copy(str, 1, p - 1);
    Delete(str, 1, p - 1 + Length(sep));
  end
  else
  begin
    Result := str;
    str := '';
  end;
end;

(*
 * mrl - media resource location
 *
 * This can be file: c:\movie.avi
 *              ulr: http://host/movie.avi
 *              rtp: rstp://host/movie
 *)

procedure TPasLibVlcPlayer.Play(mrl: WideString);
var
  lcMRL : WideString;
  proto : WideString;
  host  : WideString;
begin
  lcMRL := Trim(LowerCase(mrl));

  // get media protocol, http, rtp, file, etc.
  proto := GetToSep(lcMRL, '://');

  if (proto = 'http') or (proto = 'https') then
  begin
    host  := GetToSep(lcMRL, '/');
    if (host = 'youtube.com') or (host = 'www.youtube.com') then
    begin
      PlayYoutube(mrl);
      exit;
    end;
  end;
  
  PlayNormal(mrl);
end;

(*
 * mrl - media resource location
 *
 * This can be file: c:\movie.avi
 *              ulr: http://host/movie.avi
 *              rtp: rstp://host/movie
 *)

procedure TPasLibVlcPlayer.PlayNormal(mrl: WideString);
var
  media : TPasLibVlcMedia;
begin
  if (SELF.Parent = NIL) then
  begin
    SELF.Parent := SELF.Owner as TWinControl;
  end;

  if (SELF.Parent = NIL) then exit;

  GetPlayerHandle();

  if (p_mi = NIL) then exit;

  // stop
  libvlc_media_player_stop(p_mi);

  while (libvlc_media_player_is_playing(p_mi) <> 0) do
  begin
    Sleep(10);
  end;

  // create media
  media := TPasLibVlcMedia.Create(VLC, mrl);
//    media.AddOption('http-caching=1000');
//    media.AddOption('network-caching=1000');
  media.SetDeinterlaceFilter(FDeinterlaceFilter);
  media.SetDeinterlaceFilterMode(FDeinterlaceMode);

// char mp4_high[] = "#transcode{vcodec=h264,venc=x264{cfr=16},scale=1,acodec=mp4a,ab=160,channels=2,samplerate=44100}";
// char mp4_low[]  = "#transcode{vcodec=h264,venc=x264{cfr=40},scale=1,acodec=mp4a,ab=96,channels=2,samplerate=44100}";

// display and file, transcode before
//  media.AddOption(':sout=#transcode{}:duplicate{dst=display,dst=std{access=file,mux=avi,dst="c:\test.avi"}}');

// display and file, no transcode
//  media.AddOption(':sout=#duplicate{dst=display,dst=std{access=file,mux=avi,dst="c:\test.avi"}}');

// display and output at rtp://127.0.0.1:1234
//  media.AddOption(':sout=#duplicate{dst=display,dst=rtp{dst=127.0.0.1,port=1234,mux=ts}}');

// no display, file with transcode to mp4
//  media.AddOption(':sout=#transcode{vcodec=h264,vb=1024,fps=25,scale=1,acodec=mp3}:std{access=file,mux=mp4,dst="c:\test.mp4"}');

  // assign media to player
  libvlc_media_player_set_media(p_mi, media.MD);

  // release media
  media.Free;

  SetHwnd();

  UpdateTitleShow();

  // play
  libvlc_media_player_play(p_mi);

  FMute := FALSE;
end;

procedure TPasLibVlcPlayer.PlayYoutube(mrl: WideString; timeout: Cardinal = 10000);
begin
  // http://www.youtube.com/watch?feature=player_detailpage&v=ZHHOYmERmDc
  PlayNormal(mrl);

  // wait for media switch, for example
  while (timeout > 0) do
  begin
    Sleep(10);
    Dec(timeout, 10);
    if (GetState() = plvPlayer_Ended) then
    begin
      // if media ended, then check subitem list and
      // try continue play with first subitem mrl
      // for example:
      // http://r2---sn-4g57kn6z.googlevideo.com/videoplayback?sver=3&ipbits=0&itag=22&ip=83.31.142.43&sparams=id%2Cip%2Cipbits%2Citag%2Cratebypass%2Csource%2Cupn%2Cexpire&fexp=900064%2C902408%2C924222%2C930008%2C934030%2C946020&upn=PPuY3_P4Og8&mv=m&ms=au&id=o-ANEBC2i5aojuRlQK5Kj-nfzUUQQbvGvG3MI2udImzhm9&mws=yes&key=yt5&signature=80D290D0D7957DBC3013E7A225B64B0AE7A561CA.EE07EA42ACCCF387DACA6FF59D81135E823ED161&mt=1403761633&expire=1403784000&ratebypass=yes&source=youtube
      PlayContinue();
      break;
    end;
  end;
end;

procedure TPasLibVlcPlayer.PlayContinue();
var
  p_md     : libvlc_media_t_ptr;
  p_ml     : libvlc_media_list_t_ptr;
  sub_p_md : libvlc_media_t_ptr;
  cnt      : Integer;
  mrl      : String; 
begin
  mrl := '';

  if (p_mi = NIL) then exit;
  
  p_md := libvlc_media_player_get_media(p_mi);
  if (p_md <> NIL) then
  begin
    p_ml := libvlc_media_subitems(p_md);
    if (p_ml <> NIL) then
    begin
      libvlc_media_list_lock(p_ml);
      cnt := libvlc_media_list_count(p_ml);
      if (cnt > 0) then
      begin
        sub_p_md := libvlc_media_list_item_at_index(p_ml, 0);
        mrl := {$IFDEF DELPHI_XE2_UP}UTF8ToWideString{$ELSE}UTF8Decode{$ENDIF}(libvlc_media_get_mrl(sub_p_md));
        libvlc_media_release(sub_p_md);
      end;
      libvlc_media_list_unlock(p_ml);
      libvlc_media_list_release(p_ml);
    end;
    libvlc_media_release(p_md);
  end;

  if (mrl <> '') then Play(mrl);
end;

function TPasLibVlcPlayer.GetMediaMrl(): string;
var
  p_md     : libvlc_media_t_ptr;
  p_ml     : libvlc_media_list_t_ptr;
  sub_p_md : libvlc_media_t_ptr;
  cnt      : Integer;
begin
  if (p_mi = NIL) then exit;

  p_md := libvlc_media_player_get_media(p_mi);
  if (p_md <> NIL) then
  begin
    p_ml := libvlc_media_subitems(p_md);
    if (p_ml <> NIL) then
    begin
      libvlc_media_list_lock(p_ml);
      cnt := libvlc_media_list_count(p_ml);
      if (cnt > 0) then
      begin
        sub_p_md := libvlc_media_list_item_at_index(p_ml, 0);
        Result := {$IFDEF DELPHI_XE2_UP}UTF8ToWideString{$ELSE}UTF8Decode{$ENDIF}(libvlc_media_get_mrl(sub_p_md));
        libvlc_media_release(sub_p_md);
      end;
      libvlc_media_list_unlock(p_ml);
      libvlc_media_list_release(p_ml);
    end
    else
    begin
      Result := {$IFDEF DELPHI_XE2_UP}UTF8ToWideString{$ELSE}UTF8Decode{$ENDIF}(libvlc_media_get_mrl(p_md));
    end;
    libvlc_media_release(p_md);
  end;
end;

procedure TPasLibVlcPlayer.Pause();
begin
  if (p_mi = NIL) then exit;

  if (GetState() = plvPlayer_Playing) then
  begin
    libvlc_media_player_pause(p_mi);
  end;
end;

procedure TPasLibVlcPlayer.Resume();
begin
  if (p_mi = NIL) then exit;

  if (GetState() = plvPlayer_Paused)  then
  begin
    libvlc_media_player_play(p_mi);
  end;
end;

function TPasLibVlcPlayer.IsPlay(): Boolean;
begin
  Result := (GetState() = plvPlayer_Playing);
end;

function TPasLibVlcPlayer.IsPause(): Boolean;
begin
  Result := (GetState() = plvPlayer_Paused);
end;

procedure TPasLibVlcPlayer.Stop();
begin
  if (p_mi <> NIL) then
  begin
    libvlc_media_player_stop(p_mi);
    while (libvlc_media_player_is_playing(p_mi) <> 0) do
    begin
      Sleep(10);
    end;
  end;
end;

function TPasLibVlcPlayer.GetState(): TPasLibVlcPlayerState;
begin
  Result := plvPlayer_NothingSpecial;

  if (p_mi = NIL) then exit;
  
  case libvlc_media_player_get_state(p_mi) of
    libvlc_NothingSpecial: Result := plvPlayer_NothingSpecial;
    libvlc_Opening:        Result := plvPlayer_Opening;
    libvlc_Buffering:      Result := plvPlayer_Buffering;
    libvlc_Playing:        Result := plvPlayer_Playing;
    libvlc_Paused:         Result := plvPlayer_Paused;
    libvlc_Stopped:        Result := plvPlayer_Stopped;
    libvlc_Ended:          Result := plvPlayer_Ended;
    libvlc_Error:          Result := plvPlayer_Error;
  end;
end;

function TPasLibVlcPlayer.GetStateName(): string;
begin
  if (p_mi <> NIL) then
  begin
    case GetState of
      plvPlayer_NothingSpecial: Result := 'Nothing Special';
      plvPlayer_Opening:        Result := 'Opening';
      plvPlayer_Buffering:      Result := 'Buffering';
      plvPlayer_Playing:        Result := 'Playing';
      plvPlayer_Paused:         Result := 'Paused';
      plvPlayer_Stopped:        Result := 'Stopped';
      plvPlayer_Ended:          Result := 'Ended';
      plvPlayer_Error:          Result := 'Error';
      else                      Result := 'Invalid State';
    end;
  end
  else Result := 'Player not initialised';
end;

(*
 * Get current video width in pixels
 * If autoscale (scale = 0) then return original video width
 * If not autoscale (scale = xxx) then return video width * scale
 *)

function TPasLibVlcPlayer.GetVideoWidth(): LongInt;
var
  px, py: LongWord;
begin
  px := 0;
  py := 0;

  if (Assigned(p_mi) and (libvlc_video_get_size(p_mi, 0, px, py) = 0)) then
  begin
    Result  := px;
  end
  else
  begin
    Result := 0;
  end;
end;

(*
 * Get current video height in pixels
 * If autoscale (scale = 0) then return original video height
 * If not autoscale (scale = xxx) then return video height * scale
 *)

function TPasLibVlcPlayer.GetVideoHeight(): LongInt;
var
  px, py: LongWord;
begin
  px := 0;
  py := 0;

  if (Assigned(p_mi) and (libvlc_video_get_size(p_mi, 0, px, py) = 0)) then
  begin
    Result  := py;
  end
  else
  begin
    Result := 0;
  end;
end;

function TPasLibVlcPlayer.GetVideoDimension(var width, height: LongWord) : Boolean;
begin
  width := 0;
  height := 0;
  Result := (Assigned(p_mi) and (libvlc_video_get_size(p_mi, 0, width, height) = 0));
end;

(*
 * Get current video scale
 * I scale this by 100 (lib vlc return this im range 0..1)
 * If autoscale is on then return 0 else return actual scale
 *
 *)

function TPasLibVlcPlayer.GetVideoScaleInPercent(): Single;
begin
  Result := -1;
  if (p_mi = NIL) then exit;
  Result := libvlc_video_get_scale(p_mi) * 100;
end;

(*
 * Set current video scale
 * I scale this by 100 (lib vlc return this im range 0..1)
 * If return 0 then autoscale is on
 *
 *)

procedure TPasLibVlcPlayer.SetVideoScaleInPercent(newScaleInPercent: Single);
begin
  if (p_mi = NIL) then exit;
  libvlc_video_set_scale(p_mi, newScaleInPercent / 100);
end;

function TPasLibVlcPlayer.GetVideoAspectRatio(): string;
var
  libvlcaspect : PAnsiChar;
begin
  Result := '';
  if (p_mi = NIL) then exit;
  libvlcaspect := libvlc_video_get_aspect_ratio(p_mi);
  if (libvlcaspect <> NIL) then
  begin
    Result := {$IFDEF DELPHI_XE2_UP}UTF8ToWideString{$ELSE}UTF8Decode{$ENDIF}(AnsiString(libvlcaspect));
    libvlc_free(libvlcaspect);
  end;
end;

procedure TPasLibVlcPlayer.SetVideoAspectRatio(newAspectRatio: string);
begin
  if (p_mi = NIL) then exit;
  libvlc_video_set_aspect_ratio(p_mi, PAnsiChar(AnsiString(newAspectRatio)));
end;

(*
 * Return video time length in miliseconds
 *)
 
function TPasLibVlcPlayer.GetVideoLenInMs(): Int64;
begin
  Result := 0;
  if (p_mi = NIL) then exit;
  Result := libvlc_media_player_get_length(p_mi);
end;

(*
 * Return current video time length as string hh:mm:ss
 *)

function TPasLibVlcPlayer.GetVideoLenStr(fmt: string = 'hh:mm:ss'): string;
begin
  Result := time2str(GetVideoLenInMs(), fmt);
end;

(*
 * Return current video time position in miliseconds
 *)

function TPasLibVlcPlayer.GetVideoPosInMs(): Int64;
begin
  Result := 0;
  if (p_mi = NIL) then exit;
  Result := libvlc_media_player_get_time(p_mi);
end;

(*
 * Return current video time position as string hh:mm:ss
 *)

function TPasLibVlcPlayer.GetVideoPosStr(fmt: string = 'hh:mm:ss'): string;
begin
  Result := time2str(GetVideoPosInMs(), fmt);
end;

(*
 * Set current video time position in miliseconds
 * Not working for all media
 *)

procedure TPasLibVlcPlayer.SetVideoPosInMs(newPos: Int64);
begin
  if (p_mi = NIL) then exit;
  libvlc_media_player_set_time(p_mi, newPos);
  if (GetState() <> plvPlayer_Playing) then
  	if Assigned(FOnMediaPlayerTimeChanged) then
	    FOnMediaPlayerTimeChanged(Self, newPos);
end;

(*
 * Return current video position where 0 - start, 100 - end
 * I scale this by 100 (lib vlc return this in range 0..1)
 *)

function TPasLibVlcPlayer.GetVideoPosInPercent(): Single;
begin
  Result := 0;
  if (p_mi = NIL) then exit;
  Result := libvlc_media_player_get_position(p_mi) * 100;
end;

(*
 * Set current video position where 0 - start, 100 - end
 * I scale this by 100 (lib vlc return this in range 0..1)
 * Not working for all media
 *)

procedure TPasLibVlcPlayer.SetVideoPosInPercent(newPos: Single);
begin
  if (p_mi = NIL) then exit;
  libvlc_media_player_set_position(p_mi, newPos / 100);
  if (GetState() <> plvPlayer_Playing) then
    if Assigned(FOnMediaPlayerPositionChanged) then
      FOnMediaPlayerPositionChanged(Self, newPos / 100);
end;

(*
 * Return frames per second
 *)

function TPasLibVlcPlayer.GetVideoFps(): Single;
begin
  Result := -1;
  if (p_mi = NIL) then exit;
  Result := libvlc_media_player_get_fps(p_mi);
end;

(*
 * Return true if player can play
 *)

function TPasLibVlcPlayer.CanPlay(): Boolean;
begin
  Result := FALSE;
  if (p_mi = NIL) then exit;
  Result := (libvlc_media_player_will_play(p_mi) > 0);
end;

(*
 * Return true if player can pause
 *)

function TPasLibVlcPlayer.CanPause(): Boolean;
begin
  Result := FALSE;
  if (p_mi = NIL) then exit;
  Result := (libvlc_media_player_can_pause(p_mi) > 0);
end;

(*
 * Return true if player can seek (can set time or percent position)
 *)

function TPasLibVlcPlayer.CanSeek(): Boolean;
begin
  Result := FALSE;
  if (p_mi = NIL) then exit;
  Result := (libvlc_media_player_is_seekable(p_mi) > 0);
end;

(*
 * Return true if player has video output
 *)
function TPasLibVlcPlayer.HasVout() : Boolean;
begin
  Result := FALSE;
  if (p_mi = NIL) then exit;
  Result := (libvlc_media_player_has_vout(p_mi) > 0);
end;

(*
 * Return true if video is scrambled
 *)
function TPasLibVlcPlayer.IsScrambled() : Boolean;
begin
  Result := FALSE;
  if (p_mi = NIL) then exit;
  Result := (libvlc_media_player_program_scrambled(p_mi) > 0)
end;

(*
 * Create snapshot of current video frame to specified fileName
 * The file is in PNG format
 *)
 
function TPasLibVlcPlayer.Snapshot(fileName: WideString): Boolean;
var
  i_width, i_height: LongWord;
begin
  Result := FALSE;
  if (p_mi = NIL) then exit;
  i_width := 0;
  i_height := 0;
  if (libvlc_video_get_size(p_mi, 0, i_width, i_height) <> 0) then exit;
  Result := (libvlc_video_take_snapshot(p_mi, 0, PAnsiChar(Utf8Encode(fileName)), i_width, i_height) = 0);
end;

(*
 * Create snapshot of current video frame
 * to specified fileName with size width x heght
 * The file is in PNG format
 *)

function TPasLibVlcPlayer.Snapshot(fileName: WideString; width, height: LongWord): Boolean;
begin
  Result := FALSE;
  if (p_mi = NIL) then exit;
  Result := (libvlc_video_take_snapshot(p_mi, 0, PAnsiChar(Utf8Encode(fileName)), width, height) = 0);
end;

procedure TPasLibVlcPlayer.NextFrame();
begin
  if (p_mi = NIL) then exit;
  libvlc_media_player_next_frame(p_mi);
end;

function TPasLibVlcPlayer.GetAudioMute(): Boolean;
begin
  Result := FMute;
end;

procedure TPasLibVlcPlayer.SetAudioMute(mute: Boolean);
begin
  if (p_mi = NIL) then exit;
  if mute then libvlc_audio_set_mute(p_mi, 1)
  else         libvlc_audio_set_mute(p_mi, 0);
  FMute := mute;
end;

function TPasLibVlcPlayer.GetAudioVolume(): Integer;
begin
  Result := -1;
  if (p_mi = NIL) then exit;
  Result := libvlc_audio_get_volume(p_mi);
end;

procedure TPasLibVlcPlayer.SetAudioVolume(volumeLevel: Integer);
begin
  if (p_mi = NIL) then exit;
  if (volumeLevel < 0) then exit;
  if (volumeLevel > 200) then exit;
//  if (FVLC.VersionBin < $020100) then
  begin
    libvlc_audio_set_volume(p_mi, volumeLevel);
  end;
end;

procedure TPasLibVlcPlayer.SetPlayRate(rate: Integer);
begin
  if (p_mi = NIL) then exit;
  if (rate < 1) then exit;
  if (rate > 1000) then exit;  
  libvlc_media_player_set_rate(p_mi, rate / 100);
end;

function TPasLibVlcPlayer.GetPlayRate(): Integer;
begin
  Result := -1;
  if (p_mi = NIL) then exit;
  Result := Round(100 * libvlc_media_player_get_rate(p_mi));
end;

procedure TPasLibVlcPlayer.PlayInWindow(newWindow: TWinControl = NIL);
begin
  if (p_mi = NIL) then exit;
  
  if Assigned(newWindow) then
  begin
    libvlc_media_player_set_display_window(p_mi, newWindow.Handle);
  end
  else
  begin
    SetHwnd();
  end;
end;

////////////////////////////////////////////////////////////////////////////////

function TPasLibVlcPlayer.GetAudioTrackList() : TStringList;
var
  p_track : libvlc_track_description_t_ptr;
begin
  Result := TStringList.Create;
  if (p_mi = NIL) then exit;

  p_track := libvlc_audio_get_track_description(p_mi);

  while (p_track <> NIL) do
  begin
    if (p_track^.psz_name <> NIL) then
    begin
      Result.AddObject(
        {$IFDEF DELPHI_XE2_UP}UTF8ToWideString{$ELSE}UTF8Decode{$ENDIF}(p_track^.psz_name),
        TObject(p_track^.i_id));
    end;
    p_track := p_track^.p_next;
  end;
end;

function TPasLibVlcPlayer.GetAudioTrackCount(): Integer;
begin
  Result := -1;
  if (p_mi = NIL) then exit;
  Result := libvlc_audio_get_track_count(p_mi);
end;

function TPasLibVlcPlayer.GetAudioTrackId(): Integer;
begin
  Result := -1;
  if (p_mi = NIL) then exit;
  Result := libvlc_audio_get_track(p_mi);
end;

procedure TPasLibVlcPlayer.SetAudioTrackById(const track_id : Integer);
begin
  if (p_mi = NIL) then exit;
  if (track_id < 0) then exit;
  
  libvlc_audio_set_track(p_mi, track_id);
end;

function TPasLibVlcPlayer.GetAudioTrackNo(): Integer;
var
  track_id : Integer;
  p_track  : libvlc_track_description_t_ptr;
begin
  Result := 0;

  if not Assigned(p_mi) then exit;

  track_id := libvlc_audio_get_track(p_mi);

  p_track := libvlc_audio_get_track_description(p_mi);

  while (p_track <> NIL) do
  begin
    if (p_track^.i_id = track_id) then exit;
    Inc(Result);
    p_track := p_track^.p_next;
  end;

  Result := -1;
end;

procedure TPasLibVlcPlayer.SetAudioTrackByNo(track_no : Integer);
var
  p_track : libvlc_track_description_t_ptr;
begin
  if (p_mi = NIL) then exit;
  if (track_no < 0) then exit;

  p_track := libvlc_audio_get_track_description(p_mi);

  while ((track_no > 0) and (p_track <> NIL)) do
  begin
    Dec(track_no);
    p_track := p_track^.p_next;
  end;

  if (p_track <> NIL) then
  begin
    libvlc_audio_set_track(p_mi, p_track^.i_id);
  end;
end;

function TPasLibVlcPlayer.GetAudioTrackDescriptionById(const track_id : Integer): WideString;
var
  p_track : libvlc_track_description_t_ptr;
begin
  Result := '';

  if (track_id < 0) then exit;
  
  if not Assigned(p_mi) then exit;

  p_track := libvlc_audio_get_track_description(p_mi);

  while (p_track <> NIL) do
  begin
    if (p_track^.i_id = track_id) then
    begin
      if (p_track^.psz_name <> NIL) then
      begin
        Result := {$IFDEF DELPHI_XE2_UP}UTF8ToWideString{$ELSE}UTF8Decode{$ENDIF}(p_track^.psz_name);
      end;
      break;
    end;
    p_track := p_track^.p_next;
  end;
end;

function TPasLibVlcPlayer.GetAudioTrackDescriptionByNo(track_no: Integer): WideString;
var
  p_track : libvlc_track_description_t_ptr;
begin
  Result := '';

  if (track_no < 0) then exit;

  if not Assigned(p_mi) then exit;

  p_track := libvlc_audio_get_track_description(p_mi);

  while ((track_no > 0) and (p_track <> NIL)) do
  begin
    Dec(track_no);
    p_track := p_track^.p_next;
  end;

  if (p_track <> NIL) then
  begin
    if (p_track^.psz_name <> NIL) then
    begin
      Result := {$IFDEF DELPHI_XE2_UP}UTF8ToWideString{$ELSE}UTF8Decode{$ENDIF}(p_track^.psz_name);
    end;
  end;
end;

////////////////////////////////////////////////////////////////////////////////

function TPasLibVlcPlayer.EqualizerGetPresetList(): TStringList;
var
  preset : PAnsiChar;
  count  : Word;
  index  : Word;
begin
  Result := TStringList.Create;

  if (VLC.Handle = NIL) then exit;

  count := libvlc_audio_equalizer_get_preset_count();
  index := 0;
  while (index < count) do
  begin
    preset := libvlc_audio_equalizer_get_preset_name(index);
    if ((preset <> NIL) and (preset <> '')) then
    begin
      Result.AddObject(
        {$IFDEF DELPHI_XE2_UP}UTF8ToWideString{$ELSE}UTF8Decode{$ENDIF}(preset),
        TObject(index)
      );
    end;
    Inc(index);
  end;
end;

function TPasLibVlcPlayer.EqualizerGetBandCount(): Word;
begin
  Result := 0;
  if (VLC.Handle = NIL) then exit;
  Result := libvlc_audio_equalizer_get_band_count();
end;

function TPasLibVlcPlayer.EqualizerGetBandFrequency(bandIndex : Word): Single;
begin
  Result := 0;
  if (VLC.Handle = NIL) then exit;
  Result := libvlc_audio_equalizer_get_band_frequency(bandIndex);
end;

function TPasLibVlcPlayer.EqualizerCreate(APreset : Word = $FFFF) : TPasLibVlcEqualizer;
begin
  Result := TPasLibVlcEqualizer.Create(FVLC, APreset);
end;

procedure TPasLibVlcPlayer.EqualizerApply(AEqualizer : TPasLibVlcEqualizer);
begin
  if (VLC.Handle = NIL) then exit;
  GetPlayerHandle();
  if not Assigned(p_mi) then exit;

  if (AEqualizer <> NIL) then
  begin
    libvlc_media_player_set_equalizer(p_mi, AEqualizer.GetHandle());
  end
  else
  begin
    libvlc_media_player_set_equalizer(p_mi, NIL);
  end;
end;

procedure TPasLibVlcPlayer.EqualizerSetPreset(APreset : Word = $FFFF);
var
  equalizer : TPasLibVlcEqualizer;
begin
  if (VLC.Handle = NIL) then exit;
  GetPlayerHandle();
  if not Assigned(p_mi) then exit;
  if (APreset <> $FFFF) then
  begin
    equalizer := TPasLibVlcEqualizer.Create(FVLC, APreset);
    libvlc_media_player_set_equalizer(p_mi, equalizer.GetHandle());
    equalizer.Free;
  end
  else
  begin
    libvlc_media_player_set_equalizer(p_mi, NIL);
  end;
end;

////////////////////////////////////////////////////////////////////////////////

function TPasLibVlcPlayer.GetAudioOutputList(): TStringList;
var
  p_list_head : libvlc_audio_output_t_ptr;
  p_list_item : libvlc_audio_output_t_ptr;
begin
  Result := TStringList.Create;
  p_list_head := libvlc_audio_output_list_get(VLC.Handle);

  if (p_list_head <> NIL) then
  begin
    p_list_item := p_list_head;
    while (p_list_item <> NIL) do
    begin
      if (p_list_item^.psz_name <> NIL) then
      begin
        Result.Add(
          {$IFDEF DELPHI_XE2_UP}UTF8ToWideString{$ELSE}UTF8Decode{$ENDIF}(p_list_item^.psz_name)
//          + '|' +
//          {$IFDEF DELPHI_XE2_UP}UTF8ToWideString{$ELSE}UTF8Decode{$ENDIF}(p_list_item^.psz_description)
        );
      end;
      p_list_item := p_list_item^.p_next;
    end;
    libvlc_audio_output_list_release(p_list_head);
  end;
end;

function TPasLibVlcPlayer.GetAudioOutputDeviceList(aOut : WideString): TStringList;
var
  p_list_head : libvlc_audio_output_device_t_ptr;
  p_list_item : libvlc_audio_output_device_t_ptr;
begin
  Result := TStringList.Create;
  p_list_head := libvlc_audio_output_device_list_get(VLC.Handle, PAnsiChar(Utf8Encode(aOut)));

  if (p_list_head <> NIL) then
  begin
    p_list_item := p_list_head;
    while (p_list_item <> NIL) do
    begin
      if (p_list_item^.psz_device <> NIL) then
      begin
        Result.Add(
          {$IFDEF DELPHI_XE2_UP}UTF8ToWideString{$ELSE}UTF8Decode{$ENDIF}(p_list_item^.psz_device)
//          + '|' +
//          {$IFDEF DELPHI_XE2_UP}UTF8ToWideString{$ELSE}UTF8Decode{$ENDIF}(p_list_item^.psz_description)
        );
      end;
      p_list_item := p_list_item^.p_next;
    end;
    libvlc_audio_output_device_list_release(p_list_head);
  end;
end;

function TPasLibVlcPlayer.GetAudioOutputDeviceEnum() : TStringList;
var
  p_list_head : libvlc_audio_output_device_t_ptr;
  p_list_item : libvlc_audio_output_device_t_ptr;
begin
  Result := TStringList.Create;

  if (p_mi = NIL) then GetPlayerHandle();
  
  if not Assigned(p_mi) then exit;
  
  p_list_head := libvlc_audio_output_device_enum(p_mi);

  if (p_list_head <> NIL) then
  begin
    p_list_item := p_list_head;
    while (p_list_item <> NIL) do
    begin
      if (p_list_item^.psz_device <> NIL) then
      begin
        Result.Add(
          {$IFDEF DELPHI_XE2_UP}UTF8ToWideString{$ELSE}UTF8Decode{$ENDIF}(p_list_item^.psz_device)
//          + '|' +
//          {$IFDEF DELPHI_XE2_UP}UTF8ToWideString{$ELSE}UTF8Decode{$ENDIF}(p_list_item^.psz_description)
        );
      end;
      p_list_item := p_list_item^.p_next;
    end;
    libvlc_audio_output_device_list_release(p_list_head);
  end;
end;

function TPasLibVlcPlayer.SetAudioOutput(aOut: WideString) : Boolean;
begin
  Result := FALSE;
  if (p_mi = NIL) then GetPlayerHandle();
  if (p_mi <> NIL) then
  begin
    Result := (libvlc_audio_output_set(p_mi, PAnsiChar(Utf8Encode(aOut))) = 0);
  end;
end;

procedure TPasLibVlcPlayer.SetAudioOutputDevice(aOut: WideString; device_id: WideString);
begin
  if (p_mi = NIL) then GetPlayerHandle();
  if (p_mi <> NIL) then
  begin
    if (aOut <> '') then
    begin
      libvlc_audio_output_device_set(p_mi, PAnsiChar(Utf8Encode(aOut)), PAnsiChar(Utf8Encode(device_id)));
    end
    else
    begin
      libvlc_audio_output_device_set(p_mi, NIL, PAnsiChar(Utf8Encode(device_id)));
    end;
  end;
end;

procedure TPasLibVlcPlayer.SetAudioOutputDevice(device_id: WideString);
begin
  if (p_mi = NIL) then GetPlayerHandle();
  if (p_mi <> NIL) then
  begin
    libvlc_audio_output_device_set(p_mi, NIL, PAnsiChar(Utf8Encode(device_id)));
  end;
end;

{$IFDEF USE_VLC_DEPRECATED_API}
function TPasLibVlcPlayer.GetAudioOutputDeviceCount(aOut: WideString): Integer;
begin
  Result := libvlc_audio_output_device_count(VLC.Handle, PAnsiChar(Utf8Encode(aOut)));
end;

function TPasLibVlcPlayer.GetAudioOutputDeviceId(aOut: WideString; deviceIdx : Integer) : WideString;
var
  device_id : PAnsiChar;
begin
  Result := '';
  device_id := libvlc_audio_output_device_id(VLC.Handle, PAnsiChar(Utf8Encode(aOut)), deviceIdx);
  if (device_id <> NIL) then
  begin
    Result := {$IFDEF DELPHI_XE2_UP}UTF8ToWideString{$ELSE}UTF8Decode{$ENDIF}(device_id);
    libvlc_free(device_id);
  end;
end;

function TPasLibVlcPlayer.GetAudioOutputDeviceName(aOut: WideString; deviceIdx : Integer): WideString;
var
  device_name : PAnsiChar;
begin
  device_name := libvlc_audio_output_device_longname(VLC.Handle, PAnsiChar(Utf8Encode(aOut)), deviceIdx);
  Result := '';
  if (device_name <> NIL) then
  begin
    Result := {$IFDEF DELPHI_XE2_UP}UTF8ToWideString{$ELSE}UTF8Decode{$ENDIF}(device_name);
//    libvlc_free(device_name);
  end;
end;
{$ENDIF}

////////////////////////////////////////////////////////////////////////////////

function TPasLibVlcPlayer.GetVideoChapter(): Integer;
begin
  Result := -1;
  if (p_mi = NIL) then exit;
  Result := libvlc_media_player_get_chapter(p_mi);
end;

procedure TPasLibVlcPlayer.SetVideoChapter(newChapter: Integer);
begin
  if (p_mi = NIL) then exit;
  libvlc_media_player_set_chapter(p_mi, newChapter);
end;

function TPasLibVlcPlayer.GetVideoChapterCount(): Integer;
begin
  Result := -1;
  if (p_mi = NIL) then exit;
  Result := libvlc_media_player_get_chapter_count(p_mi);
end;

function TPasLibVlcPlayer.GetVideoChapterCountByTitleId(const title_id : Integer): Integer;
begin
  Result := -1;
  if (p_mi = NIL) then exit;
  Result := libvlc_media_player_get_chapter_count_for_title(p_mi, title_id);
end;

////////////////////////////////////////////////////////////////////////////////

function TPasLibVlcPlayer.GetVideoSubtitleList(): TStringList;
var
  p_track : libvlc_track_description_t_ptr;
begin
  Result := TStringList.Create;
  if (p_mi = NIL) then exit;

  p_track := libvlc_video_get_spu_description(p_mi);

  while (p_track <> NIL) do
  begin
    if (p_track^.psz_name <> NIL) then
    begin
      Result.AddObject(
        {$IFDEF DELPHI_XE2_UP}UTF8ToWideString{$ELSE}UTF8Decode{$ENDIF}(p_track^.psz_name),
        TObject(p_track^.i_id));
    end;
    p_track := p_track^.p_next;
  end;
end;

function TPasLibVlcPlayer.GetVideoSubtitleCount(): Integer;
begin
  Result := -1;
  if (p_mi = NIL) then exit;
  Result := libvlc_video_get_spu_count(p_mi);
end;

function TPasLibVlcPlayer.GetVideoSubtitleId(): Integer;
begin
  Result := -1;
  if (p_mi = NIL) then Exit;
  Result := libvlc_video_get_spu(p_mi);
end;

procedure TPasLibVlcPlayer.SetVideoSubtitleById(const subtitle_id : Integer);
begin
  if (p_mi = NIL) then exit;
  libvlc_video_set_spu(p_mi, subtitle_id);
end;

function TPasLibVlcPlayer.GetVideoSubtitleNo(): Integer;
var
  track_id : Integer;
  p_track  : libvlc_track_description_t_ptr;
begin
  Result := 0;

  if not Assigned(p_mi) then exit;

  track_id := libvlc_video_get_spu(p_mi);

  p_track := libvlc_video_get_spu_description(p_mi);

  while (p_track <> NIL) do
  begin
    if (p_track^.i_id = track_id) then exit;
    Inc(Result);
    p_track := p_track^.p_next;
  end;

  Result := -1;
end;

procedure TPasLibVlcPlayer.SetVideoSubtitleByNo(subtitle_no: Integer);
var
  p_track: libvlc_track_description_t_ptr;
begin
  if (p_mi = NIL) then exit;
  if (subtitle_no < 0) then exit;

  p_track := libvlc_video_get_spu_description(p_mi);

  while ((subtitle_no > 0) and (p_track <> NIL)) do
  begin
    Dec(subtitle_no);
    p_track := p_track^.p_next;
  end;

  if (p_track <> NIL) then
  begin
    libvlc_video_set_spu(p_mi, p_track^.i_id);
  end;
end;

function TPasLibVlcPlayer.GetVideoSubtitleDescriptionById(const subtitle_id : Integer): WideString;
var
  p_track: libvlc_track_description_t_ptr;
begin
  Result := '';

  if (subtitle_id < 0) then exit;
  
  if not Assigned(p_mi) then exit;

  p_track := libvlc_video_get_spu_description(p_mi);

  while (p_track <> NIL) do
  begin
    if (p_track^.i_id = subtitle_id) then
    begin
      if (p_track^.psz_name <> NIL) then
      begin
        Result := {$IFDEF DELPHI_XE2_UP}UTF8ToWideString{$ELSE}UTF8Decode{$ENDIF}(p_track^.psz_name);
      end;
      break;
    end;
    p_track := p_track^.p_next;
  end;
end;

function TPasLibVlcPlayer.GetVideoSubtitleDescriptionByNo(subtitle_no: Integer): WideString;
var
  p_track: libvlc_track_description_t_ptr;
begin
  Result := '';

  if (subtitle_no < 0) then exit;

  if not Assigned(p_mi) then exit;

  p_track := libvlc_video_get_spu_description(p_mi);

  while ((subtitle_no > 0) and (p_track <> NIL)) do
  begin
    Dec(subtitle_no);
    p_track := p_track^.p_next;
  end;

  if (p_track <> NIL) then
  begin
    if (p_track^.psz_name <> NIL) then
    begin
      Result := {$IFDEF DELPHI_XE2_UP}UTF8ToWideString{$ELSE}UTF8Decode{$ENDIF}(p_track^.psz_name);
    end;
  end;
end;

procedure TPasLibVlcPlayer.SetVideoSubtitleFile(subtitle_file : WideString);
begin
  if (p_mi = NIL) then exit;
  libvlc_video_set_subtitle_file(p_mi, PAnsiChar(UTF8Encode(subtitle_file)));
end;

////////////////////////////////////////////////////////////////////////////////

function TPasLibVlcPlayer.GetVideoTitleList(): TStringList;
var
  p_track : libvlc_track_description_t_ptr;
begin
  Result := TStringList.Create;
  if (p_mi = NIL) then exit;

  p_track := libvlc_video_get_title_description(p_mi);

  while (p_track <> NIL) do
  begin
    if (p_track^.psz_name <> NIL) then
    begin
      Result.AddObject(
        {$IFDEF DELPHI_XE2_UP}UTF8ToWideString{$ELSE}UTF8Decode{$ENDIF}(p_track^.psz_name),
        TObject(p_track^.i_id));
    end;
    p_track := p_track^.p_next;
  end;
end;

function  TPasLibVlcPlayer.GetVideoTitleCount(): Integer;
begin
  Result := -1;
  if (p_mi = NIL) then exit;
  Result := libvlc_media_player_get_title_count(p_mi);
end;

function  TPasLibVlcPlayer.GetVideoTitleId():Integer;
begin
  Result := -1;
  if (p_mi = NIL) then exit;
  Result := libvlc_media_player_get_title(p_mi);
end;

procedure TPasLibVlcPlayer.SetVideoTitleById(const title_id:Integer);
begin
  if (p_mi = NIL) then exit;
  libvlc_media_player_set_title(p_mi, title_id);
end;

function TPasLibVlcPlayer.GetVideoTitleNo(): Integer;
var
  title_id : Integer;
  p_track  : libvlc_track_description_t_ptr;
begin
  Result := 0;

  if not Assigned(p_mi) then exit;

  title_id := libvlc_media_player_get_title(p_mi);

  p_track := libvlc_video_get_title_description(p_mi);

  while (p_track <> NIL) do
  begin
    if (p_track^.i_id = title_id) then exit;
    Inc(Result);
    p_track := p_track^.p_next;
  end;

  Result := -1;
end;

procedure TPasLibVlcPlayer.SetVideoTitleByNo(title_no : Integer);
var
  p_track: libvlc_track_description_t_ptr;
begin
  if (p_mi = NIL) then exit;
  if (title_no < 0) then exit;

  p_track := libvlc_video_get_title_description(p_mi);

  while ((title_no > 0) and (p_track <> NIL)) do
  begin
    Dec(title_no);
    p_track := p_track^.p_next;
  end;

  if (p_track <> NIL) then
  begin
    libvlc_media_player_set_title(p_mi, p_track^.i_id);
  end;
end;

function TPasLibVlcPlayer.GetVideoTitleDescriptionById(const track_id : Integer): WideString;
var
  p_track: libvlc_track_description_t_ptr;
begin
  Result := '';

  if (track_id < 0) then exit;
  
  if not Assigned(p_mi) then exit;

  p_track := libvlc_video_get_title_description(p_mi);

  while (p_track <> NIL) do
  begin
    if (p_track^.i_id = track_id) then
    begin
      if (p_track^.psz_name <> NIL) then
      begin
        Result := {$IFDEF DELPHI_XE2_UP}UTF8ToWideString{$ELSE}UTF8Decode{$ENDIF}(p_track^.psz_name);
      end;
      break;
    end;
    p_track := p_track^.p_next;
  end;
end;

function TPasLibVlcPlayer.GetVideoTitleDescriptionByNo(title_no : Integer): WideString;
var
  p_track: libvlc_track_description_t_ptr;
begin
  Result := '';

  if (title_no < 0) then exit;

  if not Assigned(p_mi) then exit;

  p_track := libvlc_video_get_title_description(p_mi);

  while ((title_no > 0) and (p_track <> NIL)) do
  begin
    Dec(title_no);
    p_track := p_track^.p_next;
  end;

  if (p_track <> NIL) then
  begin
    if (p_track^.psz_name <> NIL) then
    begin
      Result := {$IFDEF DELPHI_XE2_UP}UTF8ToWideString{$ELSE}UTF8Decode{$ENDIF}(p_track^.psz_name);
    end;
  end;
end;

////////////////////////////////////////////////////////////////////////////////

function TPasLibVlcPlayer.GetAudioChannel(): libvlc_audio_output_channel_t;
begin
  Result := libvlc_AudioChannel_Error;
  if not Assigned(p_mi) then exit;
  Result := libvlc_audio_get_channel(p_mi);
end;

procedure TPasLibVlcPlayer.SetAudioChannel(chanel: libvlc_audio_output_channel_t);
begin
  if not Assigned(p_mi) then exit;
  libvlc_audio_set_channel(p_mi, chanel);
end;

function  TPasLibVlcPlayer.GetAudioDelay(): Int64;
begin
  Result := 0;
  if not Assigned(p_mi) then exit;
  Result := libvlc_audio_get_delay(p_mi);
end;

procedure TPasLibVlcPlayer.SetAudioDelay(delay: Int64);
begin
  if not Assigned(p_mi) then exit;
  libvlc_audio_set_delay(p_mi, delay);
end;

////////////////////////////////////////////////////////////////////////////////

procedure TPasLibVlcPlayer.SetTeleText(page: Integer);
begin
  if not Assigned(p_mi) then exit;
  libvlc_video_set_teletext(p_mi, page);
end;

function TPasLibVlcPlayer.GetTeleText() : Integer;
begin
  Result := -1;
  if not Assigned(p_mi) then exit;
  Result := libvlc_video_get_teletext(p_mi);
end;

function TPasLibVlcPlayer.ShowTeleText() : Boolean;
begin
  Result := FViewTeleText;
  if FViewTeleText then exit;
  if not Assigned(p_mi) then exit;
  if (libvlc_media_player_is_playing(p_mi) = 0) then exit;
  libvlc_toggle_teletext(p_mi);
  Result := FViewTeleText;
end;

function TPasLibVlcPlayer.HideTeleText() : Boolean;
begin
  Result := FViewTeleText;
  if not FViewTeleText then exit;
  if not Assigned(p_mi) then exit;
  if (libvlc_media_player_is_playing(p_mi) = 0) then exit;
  libvlc_toggle_teletext(p_mi);
  Result := FViewTeleText;
end;

////////////////////////////////////////////////////////////////////////////////
//
// https://wiki.videolan.org/Documentation:Modules/logo/
//
////////////////////////////////////////////////////////////////////////////////

procedure TPasLibVlcPlayer.LogoSetFile(file_name : WideString);
begin
  if not Assigned(p_mi) then exit;
  libvlc_video_set_logo_string(p_mi, libvlc_logo_File, PAnsiChar(UTF8Encode(file_name)));
end;

procedure TPasLibVlcPlayer.LogoSetFiles(file_names : array of WideString; delay_ms : Integer = 1000; loop : Boolean = TRUE);
var
  file_name : WideString;
  file_indx : Integer;
begin
  file_name := '';
  for file_indx := Low(file_names) to High(file_names) do
  begin
    file_name := file_name + file_names[file_indx] + {$IFDEF MSWINDOWS} ';'; {$ELSE} ':'; {$ENDIF};
  end;
  // remove last PATH_SEPARATOR;
  if (file_name <> '') then SetLength(file_name, Length(file_name)-1);
  LogoSetFile(file_name);
  LogoSetDelay(delay_ms);
  LogoSetRepeat(loop);
end;

procedure TPasLibVlcPlayer.LogoSetPosition(position_x, position_y : Integer);
begin
  if not Assigned(p_mi) then exit;
  libvlc_video_set_logo_int(p_mi, libvlc_logo_X, position_x);
  libvlc_video_set_logo_int(p_mi, libvlc_logo_Y, position_y);
end;

procedure TPasLibVlcPlayer.LogoSetPosition(position : libvlc_position_t);
begin
  if not Assigned(p_mi) then exit;
  libvlc_video_set_logo_int(p_mi, libvlc_logo_Position, Ord(position));
end;

procedure TPasLibVlcPlayer.LogoSetOpacity(opacity : libvlc_opacity_t);
begin
  if not Assigned(p_mi) then exit;
  libvlc_video_set_logo_int(p_mi, libvlc_logo_Opacity, opacity);
end;

procedure TPasLibVlcPlayer.LogoSetDelay(delay_ms : Integer = 1000); // delay before show next logo file, default 1000
begin
  if not Assigned(p_mi) then exit;
  libvlc_video_set_logo_int(p_mi, libvlc_logo_Delay, delay_ms);
end;

procedure TPasLibVlcPlayer.LogoSetRepeat(loop : Boolean = TRUE);
begin
  if not Assigned(p_mi) then exit;
  if loop then libvlc_video_set_logo_int(p_mi, libvlc_logo_Repeat, -1) // -1 = loop,
  else         libvlc_video_set_logo_int(p_mi, libvlc_logo_Repeat, 0); // 0 - disable
end;

procedure TPasLibVlcPlayer.LogoSetEnable(enable : Integer);
begin
  if not Assigned(p_mi) then exit;
  libvlc_video_set_logo_int(p_mi, libvlc_logo_Enable, enable); // not work
end;

procedure TPasLibVlcPlayer.LogoShowFile(file_name : WideString; position_x, position_y : Integer; opacity: libvlc_opacity_t = libvlc_opacity_full);
begin
  LogoSetFile(file_name);
  LogoSetPosition(position_x, position_y);
  LogoSetOpacity(opacity);
  LogoSetEnable(1);
end;

procedure TPasLibVlcPlayer.LogoShowFile(file_name : WideString; position: libvlc_position_t = libvlc_position_top; opacity: libvlc_opacity_t = libvlc_opacity_full);
begin
  LogoSetFile(file_name);
  LogoSetPosition(position);
  LogoSetOpacity(opacity);
  LogoSetEnable(1);
end;

procedure TPasLibVlcPlayer.LogoShowFiles(file_names : array of WideString; position_x, position_y : Integer; opacity: libvlc_opacity_t = libvlc_opacity_full; delay_ms : Integer = 1000; loop : Boolean = TRUE);
begin
  LogoSetFiles(file_names);
  LogoSetPosition(position_x, position_y);
  LogoSetOpacity(opacity);
  LogoSetDelay(delay_ms);
  LogoSetRepeat(loop);
  LogoSetEnable(1);
end;

procedure TPasLibVlcPlayer.LogoShowFiles(file_names : array of WideString; position: libvlc_position_t = libvlc_position_top; opacity: libvlc_opacity_t = libvlc_opacity_full; delay_ms : Integer = 1000; loop : Boolean = TRUE);
begin
  LogoSetFiles(file_names);
  LogoSetPosition(position);
  LogoSetOpacity(opacity);
  LogoSetDelay(delay_ms);
  LogoSetRepeat(loop);
  LogoSetEnable(1);
end;

procedure TPasLibVlcPlayer.LogoHide();
begin
  if not Assigned(p_mi) then exit;
  libvlc_video_set_logo_int   (p_mi, libvlc_logo_Enable, 1); // not work
  libvlc_video_set_logo_string(p_mi, libvlc_logo_File,   NIL); // this work
end;

////////////////////////////////////////////////////////////////////////////////
//
// https://wiki.videolan.org/Documentation:Modules/marq/
//
////////////////////////////////////////////////////////////////////////////////

procedure TPasLibVlcPlayer.MarqueeSetText(marquee_text : WideString);
begin
  if not Assigned(p_mi) then exit;
  if (marquee_text = '') then libvlc_video_set_marquee_string(p_mi, libvlc_marquee_Text, NIL)
  else libvlc_video_set_marquee_string(p_mi, libvlc_marquee_Text, PAnsiChar(UTF8Encode(marquee_text)));
end;

procedure TPasLibVlcPlayer.MarqueeSetPosition(position_x, position_y : Integer); 
begin
  if not Assigned(p_mi) then exit;
  libvlc_video_set_marquee_int(p_mi, libvlc_marquee_X, position_x);
  libvlc_video_set_marquee_int(p_mi, libvlc_marquee_Y, position_y);
end;

procedure TPasLibVlcPlayer.MarqueeSetPosition(position : libvlc_position_t);
begin
  if not Assigned(p_mi) then exit;
  libvlc_video_set_marquee_int(p_mi, libvlc_marquee_Position, Ord(position));
end;

procedure TPasLibVlcPlayer.MarqueeSetColor(color : libvlc_video_marquee_color_t);
begin
  if not Assigned(p_mi) then exit;
  libvlc_video_set_marquee_int(p_mi, libvlc_marquee_Color, color);
end;

procedure TPasLibVlcPlayer.MarqueeSetFontSize(font_size: Integer);
begin
  if not Assigned(p_mi) then exit;
  libvlc_video_set_marquee_int(p_mi, libvlc_marquee_Size, font_size);
end;

procedure TPasLibVlcPlayer.MarqueeSetOpacity(opacity: libvlc_opacity_t);
begin
  if not Assigned(p_mi) then exit;
  libvlc_video_set_marquee_int(p_mi, libvlc_marquee_Opacity, opacity);
end;

procedure TPasLibVlcPlayer.MarqueeSetTimeOut(time_out_ms: Integer);
begin
  if not Assigned(p_mi) then exit;
  libvlc_video_set_marquee_int(p_mi, libvlc_marquee_Timeout, time_out_ms);
end;

procedure TPasLibVlcPlayer.MarqueeSetRefresh(refresh_after_ms: Integer);
begin
  if not Assigned(p_mi) then exit;
  libvlc_video_set_marquee_int(p_mi, libvlc_marquee_Refresh, refresh_after_ms);
end;

procedure TPasLibVlcPlayer.MarqueeSetEnable(enable : Integer);
begin
  if not Assigned(p_mi) then exit;
  libvlc_video_set_marquee_int(p_mi, libvlc_marquee_Enable, enable); // not work
end;

procedure TPasLibVlcPlayer.MarqueeShowText(marquee_text : WideString; position_x, position_y : Integer; color : libvlc_video_marquee_color_t = libvlc_video_marquee_color_White; font_size: Integer = libvlc_video_marquee_default_font_size; opacity: libvlc_opacity_t = libvlc_opacity_full; time_out_ms: Integer = 0);
begin
  MarqueeSetText(marquee_text);
  MarqueeSetPosition(position_x, position_y);
  MarqueeSetColor(color);
  MarqueeSetOpacity(opacity);
  MarqueeSetFontSize(font_size);
  MarqueeSetTimeOut(time_out_ms); // hide after timeout ms, 0 - show always
  MarqueeSetRefresh(0);
  MarqueeSetEnable(1);

  // handle dynamic strings in form %H:%M:%S
  if (Pos(WideString('%H'), marquee_text) > 0) then MarqueeSetRefresh(3600 * 1000);
  if (Pos(WideString('%M'), marquee_text) > 0) then MarqueeSetRefresh(  60 * 1000);
  if (Pos(WideString('%S'), marquee_text) > 0) then MarqueeSetRefresh(       1000);
end;

procedure TPasLibVlcPlayer.MarqueeShowText(marquee_text : WideString; position : libvlc_position_t = libvlc_position_bottom; color : libvlc_video_marquee_color_t = libvlc_video_marquee_color_White; font_size: Integer = libvlc_video_marquee_default_font_size; opacity: libvlc_opacity_t = libvlc_opacity_full; time_out_ms: Integer = 0);
begin
  MarqueeSetText(marquee_text);
  MarqueeSetPosition(position);
  MarqueeSetColor(color);
  MarqueeSetOpacity(opacity);
  MarqueeSetFontSize(font_size);
  MarqueeSetTimeOut(time_out_ms); // hide after timeout ms, 0 - show always
  MarqueeSetRefresh(0);
  MarqueeSetEnable(1);

  // handle dynamic strings in form %H:%M:%S
  if (Pos(WideString('%H'), marquee_text) > 0) then MarqueeSetRefresh(3600 * 1000);
  if (Pos(WideString('%M'), marquee_text) > 0) then MarqueeSetRefresh(  60 * 1000);
  if (Pos(WideString('%S'), marquee_text) > 0) then MarqueeSetRefresh(       1000);
end;

procedure TPasLibVlcPlayer.MarqueeHide();
begin
  MarqueeSetEnable(0);
  MarqueeSetRefresh(0);
  MarqueeSetText('');
end;

////////////////////////////////////////////////////////////////////////////////

procedure TPasLibVlcPlayer.InternalOnClick(Sender: TObject);
begin
  if Assigned(OnClick) then
    OnClick(SELF);
end;

procedure TPasLibVlcPlayer.InternalOnDblClick(Sender: TObject);
begin
  if Assigned(OnDblClick) then
    OnDblClick(SELF);
end;

procedure TPasLibVlcPlayer.InternalOnMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Assigned(OnMouseDown) then
    OnMouseDown(SELF, Button, Shift, X, Y);
end;

procedure TPasLibVlcPlayer.InternalOnMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if Assigned(OnMouseMove) then
    OnMouseMove(SELF, Shift, X, Y);
end;

procedure TPasLibVlcPlayer.InternalOnMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Assigned(OnMouseUp) then
    OnMouseUp(SELF, Button, Shift, X, Y);
end;

{$IFDEF DELPHI2005_UP}
procedure TPasLibVlcPlayer.InternalOnMouseActivate(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y, HitTest: Integer;
  var MouseActivate: TMouseActivate);
begin
  if Assigned(OnMouseActivate) then
    OnMouseActivate(SELF, Button, Shift, X, Y, HitTest, MouseActivate);
end;
{$ENDIF}

{$IFDEF DELPHI2006_UP}
procedure TPasLibVlcPlayer.InternalOnMouseEnter(Sender: TObject);
begin
  if Assigned(OnMouseEnter) then
    OnMouseEnter(SELF);
end;

procedure TPasLibVlcPlayer.InternalOnMouseLeave(Sender: TObject);
begin
  if Assigned(OnMouseLeave) then
    OnMouseLeave(SELF);
end;
{$ENDIF}

////////////////////////////////////////////////////////////////////////////////

procedure TPasLibVlcPlayer.WmMediaPlayerMediaChanged(var m: TVlcMessage);
var
  {$IFNDEF CPUX64}
  data : Int64;
  {$ENDIF}
  p_md : libvlc_media_t_ptr;
  tmp  : PAnsiChar;
  mrl  : string;
begin
  if Assigned(FOnMediaPlayerMediaChanged) then
  begin
    {$IFDEF CPUX64}
    p_md := libvlc_media_t_ptr(m.WParam);
    {$ELSE}
    data := (Int64(m.WParam) shl 32) or Int64(m.LParam);
    p_md := libvlc_media_t_ptr(data);
    {$ENDIF}
    if (p_md <> NIL) then
    begin
      tmp := libvlc_media_get_mrl(p_md);
      mrl := {$IFDEF DELPHI_XE2_UP}UTF8ToWideString{$ELSE}UTF8Decode{$ENDIF}(tmp);
    end
    else
    begin
      mrl := '';
    end;
    FOnMediaPlayerMediaChanged(SELF, mrl);
  end;
  m.Result := 0;
end;

procedure TPasLibVlcPlayer.WmMediaPlayerNothingSpecial(var m: TVlcMessage);
begin
  if Assigned(FOnMediaPlayerNothingSpecial) then
    FOnMediaPlayerNothingSpecial(SELF);
  m.Result := 0;
end;

procedure TPasLibVlcPlayer.WmMediaPlayerOpening(var m: TVlcMessage);
begin
  if Assigned(FOnMediaPlayerOpening) then
    FOnMediaPlayerOpening(SELF);
  m.Result := 0;
end;

procedure TPasLibVlcPlayer.WmMediaPlayerBuffering(var m: TVlcMessage);
begin
  if Assigned(FOnMediaPlayerBuffering) then
    FOnMediaPlayerBuffering(SELF);
  m.Result := 0;
end;

procedure TPasLibVlcPlayer.WmMediaPlayerPlaying(var m: TVlcMessage);
begin
  if Assigned(FOnMediaPlayerPlaying) then
    FOnMediaPlayerPlaying(SELF);
  m.Result := 0;
end;

procedure TPasLibVlcPlayer.WmMediaPlayerPaused(var m: TVlcMessage);
begin
  if Assigned(FOnMediaPlayerPaused) then
    FOnMediaPlayerPaused(SELF);
  m.Result := 0;
end;

procedure TPasLibVlcPlayer.WmMediaPlayerStopped(var m: TVlcMessage);
begin
  if Assigned(FOnMediaPlayerStopped) then
    FOnMediaPlayerStopped(SELF);
  m.Result := 0;
end;

procedure TPasLibVlcPlayer.WmMediaPlayerForward(var m: TVlcMessage);
begin
  if Assigned(FOnMediaPlayerForward) then
    FOnMediaPlayerForward(SELF);
  m.Result := 0;
end;

procedure TPasLibVlcPlayer.WmMediaPlayerBackward(var m: TVlcMessage);
begin
  if Assigned(FOnMediaPlayerBackward) then
    FOnMediaPlayerBackward(SELF);
  m.Result := 0;
end;

procedure TPasLibVlcPlayer.WmMediaPlayerEndReached(var m: TVlcMessage);
begin
  if Assigned(FOnMediaPlayerEndReached) then
    FOnMediaPlayerEndReached(SELF);
  m.Result := 0;
end;

procedure TPasLibVlcPlayer.WmMediaPlayerEncounteredError(var m: TVlcMessage);
begin
  FCS.Enter();
  try
    FError := {$IFDEF DELPHI_XE2_UP}UTF8ToWideString{$ELSE}UTF8Decode{$ENDIF}(libvlc_errmsg());
  finally
    FCS.Leave();
  end;
  if Assigned(FOnMediaPlayerEncounteredError) then
    FOnMediaPlayerEncounteredError(SELF);
  m.Result := 0;
end;

procedure TPasLibVlcPlayer.WmMediaPlayerTimeChanged(var m: TVlcMessage);
var
  value: Int64;
begin
  if Assigned(FOnMediaPlayerTimeChanged) then
  begin
    {$IFDEF CPUX64}
    value := Int64(m.WParam);
    {$ELSE}
    value := (Int64(m.WParam) shl 32) or Int64(m.LParam);
    {$ENDIF}
    FOnMediaPlayerTimeChanged(SELF, value);
  end;
  m.Result := 0;
end;

procedure TPasLibVlcPlayer.WmMediaPlayerPositionChanged(var m: TVlcMessage);
var
  value: Single;
begin
  if Assigned(FOnMediaPlayerPositionChanged) then
  begin
    value := (m.WParam / 1000);
    FOnMediaPlayerPositionChanged(SELF, value);
  end;
  m.Result := 0;
end;

procedure TPasLibVlcPlayer.WmMediaPlayerSeekableChanged(var m: TVlcMessage);
var
  value: Int64;
begin
  if Assigned(FOnMediaPlayerSeekableChanged) then
  begin
    value := Int64(m.WParam);
    FOnMediaPlayerSeekableChanged(SELF, value <> 0);
  end;
  m.Result := 0;
end;

procedure TPasLibVlcPlayer.WmMediaPlayerPausableChanged(var m: TVlcMessage);
var
  value: Int64;
begin
  if Assigned(FOnMediaPlayerPausableChanged) then
  begin
    value := Int64(m.WParam);
    FOnMediaPlayerPausableChanged(SELF, value <> 0);
  end;
  m.Result := 0;
end;

procedure TPasLibVlcPlayer.WmMediaPlayerTitleChanged(var m: TVlcMessage);
var
  value: Int64;
begin
  if Assigned(FOnMediaPlayerTitleChanged) then
  begin
    value := Int64(m.WParam);
    FOnMediaPlayerTitleChanged(SELF, value);
  end;
  m.Result := 0;
end;

procedure TPasLibVlcPlayer.WmMediaPlayerSnapshotTaken(var m: TVlcMessage);
var
  {$IFDEF CPUX64}
  strd : PAnsiChar;
  {$ELSE}
  data : Int64;
  strd : PAnsiChar;
  {$ENDIF}
begin
  if Assigned(FOnMediaPlayerSnapshotTaken) then
  begin
    {$IFDEF CPUX64}
    strd := PAnsiChar(m.WParam);
    {$ELSE}
    data := (Int64(m.WParam) shl 32) or Int64(m.LParam);
    strd := PAnsiChar(data);
    {$ENDIF}
    FOnMediaPlayerSnapshotTaken(SELF, {$IFDEF DELPHI_XE2_UP}UTF8ToWideString{$ELSE}UTF8Decode{$ENDIF}(strd));
  end;
  m.Result := 0;
end;

procedure TPasLibVlcPlayer.WmMediaPlayerLengthChanged(var m: TVlcMessage);
var
  value : Int64;
begin
  if Assigned(FOnMediaPlayerLengthChanged) then
  begin
    {$IFDEF CPUX64}
    value := Int64(m.WParam);
    {$ELSE}
    value := (Int64(m.WParam) shl 32) or Int64(m.LParam);
    {$ENDIF}
    FOnMediaPlayerLengthChanged(SELF, value);
  end;
  m.Result := 0;    
end;

procedure TPasLibVlcPlayer.WmMediaPlayerVOutChanged(var m: TVlcMessage);
var
  value: Int64;
begin
  if Assigned(FOnMediaPlayerVideoOutChanged) then
  begin
    value := Int64(m.WParam);
    FOnMediaPlayerVideoOutChanged(SELF, value);
  end;
  m.Result := 0;
end;

procedure TPasLibVlcPlayer.WmMediaPlayerScrambledChanged(var m: TVlcMessage);
var
  value: Int64;
begin
  if Assigned(FOnMediaPlayerScrambledChanged) then
  begin
    value := Int64(m.WParam);
    FOnMediaPlayerScrambledChanged(SELF, value);
  end;
  m.Result := 0;
end;

////////////////////////////////////////////////////////////////////////////////

procedure lib_vlc_player_event_hdlr(p_event: libvlc_event_t_ptr; data: Pointer); cdecl;
var
  player: TPasLibVlcPlayer;
begin
  if (data = NIL) then exit;

  player := TPasLibVlcPlayer(data);
  
  if not Assigned(player) then exit;

  if Assigned(player.FOnMediaPlayerEvent) then
    player.FOnMediaPlayerEvent(p_event, data);

  case p_event^.event_type of
        
    libvlc_MediaPlayerMediaChanged:
    {$IFDEF CPUX64}
      PostMessage(player.Handle, WM_MEDIA_PLAYER_MEDIA_CHANGED,
        WPARAM(p_event^.media_player_media_changed.new_media),
        LPARAM(0));
    {$ELSE}
      PostMessage(player.Handle, WM_MEDIA_PLAYER_MEDIA_CHANGED,
        WPARAM(Int64(p_event^.media_player_media_changed.new_media) shr 32),
        LPARAM(Int64(p_event^.media_player_media_changed.new_media)));
    {$ENDIF}

    libvlc_MediaPlayerTimeChanged:
    {$IFDEF CPUX64}
      PostMessage(player.Handle, WM_MEDIA_PLAYER_TIME_CHANGED,
        WPARAM(p_event^.media_player_time_changed.new_time),
        LPARAM(0));
    {$ELSE}
      PostMessage(player.Handle, WM_MEDIA_PLAYER_TIME_CHANGED,
        WPARAM(p_event^.media_player_time_changed.new_time shr 32),
        LPARAM(p_event^.media_player_time_changed.new_time));
    {$ENDIF}

    libvlc_MediaPlayerSnapshotTaken:
    {$IFDEF CPUX64}
      PostMessage(player.Handle, WM_MEDIA_PLAYER_SNAPSHOT_TAKEN,
        WPARAM(p_event^.media_player_snapshot_taken.psz_filename),
        LPARAM(0));
    {$ELSE}
      PostMessage(player.Handle, WM_MEDIA_PLAYER_SNAPSHOT_TAKEN,
        WPARAM(Int64(p_event^.media_player_snapshot_taken.psz_filename) shr 32),
        LPARAM(Int64(p_event^.media_player_snapshot_taken.psz_filename)));
    {$ENDIF}

    libvlc_MediaPlayerLengthChanged:
    {$IFDEF CPUX64}
      PostMessage(player.Handle, WM_MEDIA_PLAYER_LENGTH_CHANGED,
        WPARAM(p_event^.media_player_length_changed.new_length),
        LPARAM(0));
    {$ELSE}
      PostMessage(player.Handle, WM_MEDIA_PLAYER_LENGTH_CHANGED,
        WPARAM(p_event^.media_player_length_changed.new_length shr 32),
        LPARAM(p_event^.media_player_length_changed.new_length));
    {$ENDIF}

    libvlc_MediaPlayerPositionChanged:
      PostMessage(player.Handle, WM_MEDIA_PLAYER_POSITION_CHANGED,
        WPARAM(Round(1000 * p_event^.media_player_position_changed.new_position)),
        LPARAM(0));

    libvlc_MediaPlayerSeekableChanged:
      PostMessage(player.Handle, WM_MEDIA_PLAYER_SEEKABLE_CHNANGED,
        WPARAM(p_event^.media_player_seekable_changed.new_seekable),
        LPARAM(0));

    libvlc_MediaPlayerPausableChanged:
      PostMessage(player.Handle, WM_MEDIA_PLAYER_PAUSABLE_CHNANGED,
        WPARAM(p_event^.media_player_pausable_changed.new_pausable),
        LPARAM(0));

    libvlc_MediaPlayerTitleChanged:
      PostMessage(player.Handle, WM_MEDIA_PLAYER_TITLE_CHNANGED,
        WPARAM(p_event^.media_player_title_changed.new_title),
        LPARAM(0));

    libvlc_MediaPlayerNothingSpecial:
      PostMessage(player.Handle, WM_MEDIA_PLAYER_NOTHING_SPECIAL,
        WPARAM(0), LPARAM(0));

    libvlc_MediaPlayerOpening:
      PostMessage(player.Handle, WM_MEDIA_PLAYER_OPENING,
        WPARAM(0), LPARAM(0));

    libvlc_MediaPlayerBuffering:
      PostMessage(player.Handle, WM_MEDIA_PLAYER_BUFFERING,
        WPARAM(0), LPARAM(0));

    libvlc_MediaPlayerPlaying:
      PostMessage(player.Handle, WM_MEDIA_PLAYER_PLAYING,
        WPARAM(0), LPARAM(0));

    libvlc_MediaPlayerPaused:
      PostMessage(player.Handle, WM_MEDIA_PLAYER_PAUSED,
        WPARAM(0), LPARAM(0));

    libvlc_MediaPlayerStopped:
      PostMessage(player.Handle, WM_MEDIA_PLAYER_STOPPED,
        WPARAM(0), LPARAM(0));

    libvlc_MediaPlayerForward:
      PostMessage(player.Handle, WM_MEDIA_PLAYER_FORWARD,
        WPARAM(0), LPARAM(0));

    libvlc_MediaPlayerBackward:
      PostMessage(player.Handle, WM_MEDIA_PLAYER_BACKWARD,
        WPARAM(0), LPARAM(0));

    libvlc_MediaPlayerEndReached:
      PostMessage(player.Handle, WM_MEDIA_PLAYER_END_REACHED,
        WPARAM(0), LPARAM(0));

    libvlc_MediaPlayerEncounteredError:
      PostMessage(player.Handle, WM_MEDIA_PLAYER_ENCOUNTERED_ERROR,
        WPARAM(0), LPARAM(0));

    libvlc_MediaPlayerVout:
      PostMessage(player.Handle, WM_MEDIA_PLAYER_VOUT_CHANGED,
        WPARAM(p_event^.media_player_vout.new_count),
        LPARAM(0));

    libvlc_MediaPlayerScrambledChanged:
      PostMessage(player.Handle, WM_MEDIA_PLAYER_SCRAMBLED_CHNANGED,
        WPARAM(p_event^.media_player_scrambled_changed.new_scrambled),
        LPARAM(0));
  end;
end;

procedure lib_vlc_media_list_event_hdlr(p_event: libvlc_event_t_ptr; data: Pointer); cdecl;
var
  mediaList: TPasLibVlcMediaList;
begin
  if (data = NIL) then exit;
  mediaList := TPasLibVlcMediaList(data);
  
  if not Assigned(mediaList) then exit;

  mediaList.FCS.Enter;

  try
    case p_event^.event_type of

      libvlc_MediaListItemAdded:
        mediaList.InternalHandleEventItemAdded(
          p_event^.media_list_item_added.item,
          p_event^.media_list_item_added.index);

      libvlc_MediaListWillAddItem:
        mediaList.InternalHandleEventWillAddItem(
          p_event^.media_list_will_add_item.item,
          p_event^.media_list_will_add_item.index);

      libvlc_MediaListItemDeleted:
        mediaList.InternalHandleEventItemDeleted(
          p_event^.media_list_item_deleted.item,
          p_event^.media_list_item_deleted.index);

      libvlc_MediaListWillDeleteItem:
        mediaList.InternalHandleEventWillDeleteItem(
          p_event^.media_list_will_delete_item.item,
          p_event^.media_list_will_delete_item.index);
    end;
  finally
    mediaList.FCS.Leave;
  end;
end;

procedure lib_vlc_media_list_player_event_hdlr(p_event: libvlc_event_t_ptr; data: Pointer); cdecl;
var
  mediaList: TPasLibVlcMediaList;
begin
  if (data = NIL) then exit;
  mediaList := TPasLibVlcMediaList(data);
  
  if not Assigned(mediaList) then exit;

  mediaList.FCS.Enter;
  
  try
    case p_event^.event_type of

      libvlc_MediaListPlayerPlayed:
        if Assigned(mediaList.OnPlayed) then mediaList.OnPlayed(mediaList);

      libvlc_MediaListPlayerStopped:
        if Assigned(mediaList.OnStopped) then mediaList.OnStopped(mediaList);

      libvlc_MediaListPlayerNextItemSet:
        mediaList.InternalHandleEventPlayerNextItemSet(
          p_event^.media_list_player_next_item_set.item);
    end;
  finally
    mediaList.FCS.Leave
  end;
end;

procedure libvlc_vlm_event_hdlr(p_event: libvlc_event_t_ptr; data: Pointer); cdecl;
begin
  if (data = NIL) then exit;

  case p_event^.event_type of

    libvlc_VlmMediaAdded: begin

      // Utf8Decode(p_event^.vlm_media_event.psz_media_name^);
      // Utf8Decode(p_event^.vlm_media_event.psz_instance_name^);

    end;

    libvlc_VlmMediaRemoved: begin

    end;

    libvlc_VlmMediaChanged: begin

    end;

    libvlc_VlmMediaInstanceStarted: begin

    end;

    libvlc_VlmMediaInstanceStopped: begin

    end;

    libvlc_VlmMediaInstanceStatusInit: begin

    end;

    libvlc_VlmMediaInstanceStatusOpening: begin

    end;

    libvlc_VlmMediaInstanceStatusPlaying: begin

    end;

    libvlc_VlmMediaInstanceStatusPause: begin

    end;

    libvlc_VlmMediaInstanceStatusEnd: begin

    end;

    libvlc_VlmMediaInstanceStatusError: begin

    end;
  end;
end;

////////////////////////////////////////////////////////////////////////////////

initialization

{$IFDEF FPC}

LazarusResources.Add('TPasLibVlcPlayer','PNG',[
  #137#80#78#71#13#10#26#10#0#0#0#13#73#72#68#82#0#0#0#16#0#0#0#16#8#3#0#0#0#40#45
  +#15#83#0#0#0#1#115#82#71#66#0#174#206#28#233#0#0#0#4#103#65#77#65#0#0#177#143
  +#11#252#97#5#0#0#0#32#99#72#82#77#0#0#122#38#0#0#128#132#0#0#250#0#0#0#128#232
  +#0#0#117#48#0#0#234#96#0#0#58#152#0#0#23#112#156#186#81#60#0#0#3#0#80#76#84#69
  +#0#0#0#128#0#0#0#128#0#128#128#0#0#0#128#128#0#128#0#128#128#192#192#192#192#220
  +#192#166#202#240#64#32#0#96#32#0#128#32#0#160#32#0#192#32#0#224#32#0#0#64#0#32
  +#64#0#64#64#0#96#64#0#128#64#0#160#64#0#192#64#0#224#64#0#0#96#0#32#96#0#64#96
  +#0#96#96#0#128#96#0#160#96#0#192#96#0#224#96#0#0#128#0#32#128#0#64#128#0#96#128
  +#0#128#128#0#160#128#0#192#128#0#224#128#0#0#160#0#32#160#0#64#160#0#96#160#0
  +#128#160#0#160#160#0#192#160#0#224#160#0#0#192#0#32#192#0#64#192#0#96#192#0#128
  +#192#0#160#192#0#192#192#0#224#192#0#0#224#0#32#224#0#64#224#0#96#224#0#128#224
  +#0#160#224#0#192#224#0#224#224#0#0#0#64#32#0#64#64#0#64#96#0#64#128#0#64#160#0
  +#64#192#0#64#224#0#64#0#32#64#32#32#64#64#32#64#96#32#64#128#32#64#160#32#64#192
  +#32#64#224#32#64#0#64#64#32#64#64#64#64#64#96#64#64#128#64#64#160#64#64#192#64
  +#64#224#64#64#0#96#64#32#96#64#64#96#64#96#96#64#128#96#64#160#96#64#192#96#64
  +#224#96#64#0#128#64#32#128#64#64#128#64#96#128#64#128#128#64#160#128#64#192#128
  +#64#224#128#64#0#160#64#32#160#64#64#160#64#96#160#64#128#160#64#160#160#64#192
  +#160#64#224#160#64#0#192#64#32#192#64#64#192#64#96#192#64#128#192#64#160#192#64
  +#192#192#64#224#192#64#0#224#64#32#224#64#64#224#64#96#224#64#128#224#64#160#224
  +#64#192#224#64#224#224#64#0#0#128#32#0#128#64#0#128#96#0#128#128#0#128#160#0#128
  +#192#0#128#224#0#128#0#32#128#32#32#128#64#32#128#96#32#128#128#32#128#160#32
  +#128#192#32#128#224#32#128#0#64#128#32#64#128#64#64#128#96#64#128#128#64#128#160
  +#64#128#192#64#128#224#64#128#0#96#128#32#96#128#64#96#128#96#96#128#128#96#128
  +#160#96#128#192#96#128#224#96#128#0#128#128#32#128#128#64#128#128#96#128#128#128
  +#128#128#160#128#128#192#128#128#224#128#128#0#160#128#32#160#128#64#160#128#96
  +#160#128#128#160#128#160#160#128#192#160#128#224#160#128#0#192#128#32#192#128
  +#64#192#128#96#192#128#128#192#128#160#192#128#192#192#128#224#192#128#0#224#128
  +#32#224#128#64#224#128#96#224#128#128#224#128#160#224#128#192#224#128#224#224
  +#128#0#0#192#32#0#192#64#0#192#96#0#192#128#0#192#160#0#192#192#0#192#224#0#192
  +#0#32#192#32#32#192#64#32#192#96#32#192#128#32#192#160#32#192#192#32#192#224#32
  +#192#0#64#192#32#64#192#64#64#192#96#64#192#128#64#192#160#64#192#192#64#192#224
  +#64#192#0#96#192#32#96#192#64#96#192#96#96#192#128#96#192#160#96#192#192#96#192
  +#224#96#192#0#128#192#32#128#192#64#128#192#96#128#192#128#128#192#160#128#192
  +#192#128#192#224#128#192#0#160#192#32#160#192#64#160#192#96#160#192#128#160#192
  +#160#160#192#192#160#192#224#160#192#0#192#192#32#192#192#64#192#192#96#192#192
  +#128#192#192#160#192#192#255#251#240#160#160#164#128#128#128#255#0#0#0#255#0#255
  +#255#0#0#0#255#255#0#255#0#255#255#255#255#255#88#210#52#68#0#0#0#158#73#68#65
  +#84#40#83#93#144#177#14#130#64#12#134#201#45#237#88#20#19#226#0#113#187#103#18
  +#22#48#106#34#131#241#157#216#36#185#193#147#123#44#39#203#136#133#51#193#243
  +#166#246#75#255#175#205#69#227#223#139#124#207#135#134#125#245#5#46#217#97#0#94
  +#101#21#2#30#186#95#192#12#0#136#179#101#118#224#53#43#239#77#31#128#181#210#118
  +#1#18#41#106#219#155#73#35#17#118#200#48#192#8#198#201#140#0#147#159#205#177#125
  +#227#195#78#90#1#167#77#158#37#113#117#211#234#34#25#1#88#196#219#21#41#173#210
  +#244#233#215#98#77#74#17#237#59#240#17#209#118#68#109#120#250#242#7#31#39#227
  +#185#249#70#69#223#121#0#0#0#0#73#69#78#68#174#66#96#130
]);

LazarusResources.Add('TPasLibVlcMediaList','PNG',[
  #137#80#78#71#13#10#26#10#0#0#0#13#73#72#68#82#0#0#0#16#0#0#0#16#8#2#0#0#0#144
  +#145#104#54#0#0#0#1#115#82#71#66#0#174#206#28#233#0#0#0#4#103#65#77#65#0#0#177
  +#143#11#252#97#5#0#0#0#32#99#72#82#77#0#0#122#38#0#0#128#132#0#0#250#0#0#0#128
  +#232#0#0#117#48#0#0#234#96#0#0#58#152#0#0#23#112#156#186#81#60#0#0#0#100#73#68
  +#65#84#56#79#99#252#255#255#63#3#73#0#168#33#57#53#153#72#4#50#29#162#1#72#98
  +#5#64#169#115#231#207#65#16#68#25#138#6#52#123#32#102#65#148#98#215#128#105#9
  +#166#17#8#27#24#26#24#48#17#62#39#129#84#3#3#12#25#53#48#80#213#6#106#134#18#206
  +#96#37#45#148#168#230#36#228#128#34#54#105#96#137#105#210#18#31#174#148#135#85
  +#28#0#127#207#232#162#154#33#32#15#0#0#0#0#73#69#78#68#174#66#96#130
]);

{$ENDIF}

finalization

end.
