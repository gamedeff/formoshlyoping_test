(*
 * PasLibVlcClassUnit.pas
 *
 * Last modified: 2015.03.08
 *
 * author: Robert J�drzejczyk
 * e-mail: robert@prog.olsztyn.pl
 *    www: http://prog.olsztyn.pl/paslibvlc
 *
 *)

{$I compiler.inc}

unit PasLibVlcClassUnit;

interface

uses
  {$IFDEF UNIX}Unix,{$ENDIF}
  {$IFDEF MSWINDOWS}Windows,{$ENDIF}
  {$IFDEF FPC}
  LCLType, LCLIntf, LazarusPackageIntf, LMessages, LResources, Forms, Dialogs,
  {$ELSE}
  Messages,
  {$ENDIF}
  Classes, SysUtils, Controls, ExtCtrls, Graphics,
  PasLibVlcUnit;

type
  TDeinterlaceFilter = (deOFF, deON);
  TDeinterlaceMode   = (dmDISCARD, dmBLEND, dmMEAN, dmBOB, dmLINEAR, dmX, dmYADIF, dmYADIF2x, dmPHOSPHOR, dmIVTC);

  TPasLibVlcTitlePosition = (
    plvPosCenter,
    plvPosLeft,
    plvPosRight,
    plvPosTop,
    plvPosTopLeft,
    plvPosTopRight,
    plvPosBottom,
    plvPosBottomLeft,
    plvPosBottomRight
  );

  TVideoRatio = (ra_NONE, ra_16_9, ra_16_10, ra_185_100, ra_221_100, ra_235_100, ra_239_100, ra_4_3, ra_5_4, ra_5_3, ra_1_1);

  TMux = (muxTS, muxPS, muxMp4, muxOgg, muxAvi);

  TVideoOutput = (
    voDefault
    {$IFDEF DARWIN}, voMacOSX{$ENDIF}
    {$IFDEF UNIX}, voX11, voXVideo, voGlx{$ENDIF}
    {$IFDEF MSWINDOWS}, voWinGdi, voDirectX, voDirect3d, voOpenGl{$ENDIF}
    , voDummy
  );

  TAudioOutput = (
    aoDefault
    {$IFDEF DARWIN}, aoCoreAudio{$ENDIF}
    {$IFDEF UNIX}, aoOpenSystemSound, aoAdvancedLinuxSoundArchitecture, aoEnlightenedSoundDaemon, aoKdeSoundServer{$ENDIF}
    {$IFDEF MSWINDOWS}, aoDirectX, aoWaveOut{$ENDIF}
    , aoDummy
  );

  TVideoCodec = (vcNONE, vcMPGV, vcMP4V, vcH264, vcTHEORA);
  
  TAudioCodec = (acNONE, acMPGA, acMP3, acMP4A, acVORB, acFLAC);

const
  // http://www.videolan.org/doc/vlc-user-guide/en/ch02.html#id331515
  vlcDeinterlaceModeNames : array[TDeinterlaceMode] of string = (
    'discard', 'blend', 'mean', 'bob', 'linear', 'x', 'yadif', 'yadif2x', 'phosphor', 'ivtc');

  // http://www.videolan.org/doc/vlc-user-guide/en/ch02.html#id328503
  vlcMuxNames : array[TMux] of AnsiString = (
    'ts', 'ps', 'mp4', 'ogg', 'avi');

  // http://www.videolan.org/doc/vlc-user-guide/en/ch02.html#id330667
  vlcVideoOutputNames : array[TVideoOutput] of string = (
    'default'
    {$IFDEF DARWIN}, 'macosx' {$ENDIF}
    {$IFDEF UNIX}, 'x11', 'xvideo', 'glx'{$ENDIF}
    {$IFDEF MSWINDOWS}, 'wingdi', 'directx', 'direct3d', 'opengl'{$ENDIF}
    , 'dummy'
  );

  // http://www.videolan.org/doc/vlc-user-guide/en/ch02.html#id332336
  vlcAudioOutputNames : array[TAudioOutput] of string = (
    'default'
    {$IFDEF DARWIN}, 'coreaudio'{$ENDIF}
    {$IFDEF UNIX}, 'oss', 'alsa', 'esd', 'arts'{$ENDIF}
    {$IFDEF MSWINDOWS}, 'directx', 'waveout'{$ENDIF}
    , 'dummy'
  );

  vlcVideoRatioNames : array[TVideoRatio] of AnsiString = (
    '', '16:9', '16:10', '185:100', '221:100', '235:100', '239:100', '4:3', '5:4', '5:3', '1:1');

  // http://www.videolan.org/doc/vlc-user-guide/en/ch02.html#id329971
  vlcVideoCodecNames : array[TVideoCodec] of AnsiString = (
    '', 'mpgv', 'mp4v', 'mp4v', 'theora');

  vlcAudioCodecNames : array[TAudioCodec] of AnsiString = (
    '', 'mpga', 'mp3', 'mp4a', 'vorb', 'flac');

type
  TPasLibVlc = class
  private
    FHandle : libvlc_instance_t_ptr;
    FPath   : WideString;

    FTitleShow : Boolean;

    FVersionBin : LongWord;

    FStartOptions : TStringList;

    function GetHandle()     : libvlc_instance_t_ptr;
    function GetError()      : WideString;
    function GetVersion()    : WideString;
    function GetVersionBin() : LongWord;
    function GetCompiler()   : WideString;
    function GetChangeSet()  : WideString;

    procedure SetPath(aPath: WideString);
  public
    constructor Create;
    destructor Destroy; override;

    procedure AddOption(option : string);

    property Handle     : libvlc_instance_t_ptr read GetHandle;
    property Error      : WideString            read GetError;
    property Version    : WideString            read GetVersion;
    property VersionBin : LongWord              read GetVersionBin;
    property Compiler   : WideString            read GetCompiler;
    property ChangeSet  : WideString            read GetChangeSet;
    property Path       : WideString            read FPath write SetPath;
    property TitleShow  : Boolean               read FTitleShow write FTitleShow default FALSE;

    property StartOptions : TStringList read FStartOptions;
  end;

////////////////////////////////////////////////////////////////////////////////

  TPasLibVlcMediaPlayerC = class;
  TPasLibVlcMediaListC = class;
  
  TPasLibVlcMedia = class
  private
    FVLC : TPasLibVlc;
    FMD  : libvlc_media_t_ptr;
  public
    constructor Create(aVLC: TPasLibVlc); overload;
    constructor Create(aVLC: TPasLibVlc; mrl: WideString); overload;
    constructor Create(aVLC: TPasLibVlc; aMD: libvlc_media_t_ptr); overload;
    destructor Destroy; override;

    procedure NewLocation(mrl: WideString);
    procedure NewPath(path: WideString);
    procedure NewNode(name: WideString);

    procedure AddOption(option: string);
    procedure AddOptionFlag(option: string; flag: input_item_option_e);

    function GetMrl(): WideString;

    function Duplicate(): TPasLibVlcMedia;

    function GetMeta(meta: libvlc_meta_t): WideString;
    procedure SetMeta(meta: libvlc_meta_t; value: WideString);
    procedure SaveMeta();

    function GetState(): libvlc_state_t;
    function GetStats(var stats: libvlc_media_stats_t): Boolean;

    function SubItems(): TPasLibVlcMediaListC;

    function GetEventManager(): libvlc_event_manager_t_ptr;

    function GetDuration(): libvlc_time_t;

    procedure Parse();
    procedure ParseAsync();

    function IsParsed(): Boolean;

    procedure SetUserData(data: Pointer);
    function GetUserData(): Pointer;

    function GetTracksInfo(var tracks : libvlc_media_track_info_t_ptr): Integer;

    procedure SetDeinterlaceFilter(aValue: TDeinterlaceFilter);
    procedure SetDeinterlaceFilterMode(aValue: TDeinterlaceMode);
    
    property MD : libvlc_media_t_ptr read FMD;
  end;

////////////////////////////////////////////////////////////////////////////////

  TPasLibVlcMediaListC = class
  private
    FVLC: TPasLibVlc;
    FML:  libvlc_media_list_t_ptr;

    FMP: TPasLibVlcMediaPlayerC;
  public
    constructor Create(aVLC: TPasLibVlc); overload;
    constructor Create(aVLC: TPasLibVlc; aML: libvlc_media_list_t_ptr); overload;
    destructor Destroy; override;

    procedure SetMedia(media: TPasLibVlcMedia);
    function GetMedia(): TPasLibVlcMedia;               overload;
    function GetMedia(index: Integer): TPasLibVlcMedia; overload;
    function GetIndex(media: TPasLibVlcMedia): Integer;
    function IsReadOnly(): Boolean;

    procedure Add(mrl: WideString); overload;
    procedure Add(media: TPasLibVlcMedia); overload;
    procedure Insert(media: TPasLibVlcMedia; index: Integer);
    procedure Delete(index: Integer);
    procedure Clear();
    function Count(): Integer;

    procedure Lock();
    procedure UnLock();

    function GetEventManager(): libvlc_event_manager_t_ptr;

    property ML : libvlc_media_list_t_ptr read FML;
    property MI : TPasLibVlcMediaPlayerC read FMP write FMP;
  end;

////////////////////////////////////////////////////////////////////////////////

  TPasLibVlcMediaPlayerC = class
  private
    FTitleShow   : Boolean;
    FVideoOnTop  : Boolean;
    FUseOverlay  : Boolean;
    FSnapShotFmt : string;

    FDeinterlaceFilter: TDeinterlaceFilter;
    FDeinterlaceMode:   TDeinterlaceMode;

  public
    property TitleShow   : Boolean read FTitleShow   write FTitleShow  default FALSE;
    property VideoOnTop  : Boolean read FVideoOnTop  write FVideoOnTop default FALSE;
    property UseOverlay  : Boolean read FUseOverlay  write FUseOverlay default FALSE;
    property SnapShotFmt : string  read FSnapShotFmt write FSnapShotFmt;
    property DeinterlaceFilter: TDeinterlaceFilter read FDeinterlaceFilter write FDeinterlaceFilter default deOFF;
    property DeinterlaceMode:   TDeinterlaceMode   read FDeinterlaceMode   write FDeinterlaceMode   default dmDISCARD;
  end;

////////////////////////////////////////////////////////////////////////////////

  TPasLibVlcEqualizer = class
  private
    FVLC       : TPasLibVlc;
    FEqualizer : libvlc_equalizer_t_ptr;
    FPreset    : Word;
  public
    constructor Create(AVLC: TPasLibVlc; APreset : WORD = $FFFF);
    destructor Destroy; override;

    function GetPreAmp() : Single;
    procedure SetPreAmp(value : Single);

    function GetAmp(index: Word) :  Single; 
    procedure SetAmp(index : Word; value : Single);

    function GetBandCount() : Word;
    function GetBandFrequency(index : Word) : Single;

    function GetPresetCount() : Word;
    function GetPresetName(index : Word) : WideString; overload;
    function GetPresetName() : WideString; overload;
    function GetPreset() : Word;
    procedure SetPreset(APreset : WORD = $FFFF);

    function GetHandle() : libvlc_equalizer_t_ptr;
  end;

////////////////////////////////////////////////////////////////////////////////

type
  TPasLibVlcMouseEventWinCtrl = class(TWinControl)
  private
  {$IFDEF UNIX}
  procedure WMEraseBkgnd(var msg: TLMEraseBkgnd); message LM_EraseBkgnd;
  {$ENDIF}
  {$IFDEF MSWINDOWS}
  procedure WMEraseBkgnd(var msg: TWMEraseBkGnd); message WM_ERASEBKGND;
  {$ENDIF}
  protected
    procedure CreateParams(var params: TCreateParams); override;
  public
  published
    property OnClick;
    property OnDblClick;
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
  end;

////////////////////////////////////////////////////////////////////////////////

{$IFNDEF HAS_SYNCOBJS}
type
  TCriticalSection = class
  protected
    FSection: TRTLCriticalSection;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Enter;
    procedure Leave;
  end;
{$ENDIF}

implementation

{$IFDEF DELPHI_XE6_UP}
uses
	System.AnsiStrings;
{$ENDIF}

constructor TPasLibVlc.Create;
begin
  inherited Create;
  
  FHandle       := NIL;
  FTitleShow    := FALSE;
  FStartOptions := TStringList.Create;
  FVersionBin   := 0;
end;

procedure TPasLibVlc.AddOption(option : string);
begin
  if (option <> '') and (FStartOptions.IndexOf(option) < 0) then
  begin
    FStartOptions.Add(option);
  end;
end;

destructor TPasLibVlc.Destroy;
begin
  if (Assigned(libvlc_release)) then
  begin
    if (FHandle <> NIL) then
    begin
      libvlc_release(FHandle);
    end;
  end;

  FStartOptions.Free;

  inherited Destroy;
end;

function TPasLibVlc.GetHandle() : libvlc_instance_t_ptr;
const
  MAX_ARGS = 256;
var
  argv : packed array[0..MAX_ARGS-1] of AnsiString;
  args : packed array[0..MAX_ARGS-1] of PAnsiChar;
  argc : Integer;
  oIdx : Integer;
  
  procedure AddArg(value : string);
  begin
    if (argc < MAX_ARGS) then
    begin
      argv[argc] := Utf8Encode(value);
      args[argc] := PAnsiChar(argv[argc]);
      Inc(argc);
    end;
  end;
  
begin
  Result := NIL;
  if (FHandle = NIL) then
  begin
    if (FPath <> '') then
    begin
      libvlc_dynamic_dll_init_with_path(FPath);
      if (libvlc_dynamic_dll_error <> '') then libvlc_dynamic_dll_init();
    end
    else
    begin
      libvlc_dynamic_dll_init();
    end;
    if (libvlc_dynamic_dll_error <> '') then exit;

    argc := 0;
    FillChar(args, sizeof(args), 0);

    AddArg(libvlc_dynamic_dll_path);
    for oIdx := 0 to FStartOptions.Count - 1 do
    begin
      if (Trim(FStartOptions.Strings[oIdx]) = '') then continue;
      AddArg(FStartOptions.Strings[oIdx]);
      if (argc = MAX_ARGS) then break;
    end;

    if (VersionBin < $020100) then
    begin
      if (argc < MAX_ARGS) then
      begin
        if not TitleShow then
        begin
          AddArg('--no-video-title-show')
        end
        else
        begin
          AddArg('--video-title-show');
        end;
      end;
    end;

    // activate marq and logo subfilters
    if (VersionBin >= $020000) and (argc < (MAX_ARGS - 2)) then
    begin
      AddArg('--sub-source=marq');
    end;
    if (VersionBin >= $010100) and (argc < (MAX_ARGS - 1)) then
    begin
      AddArg('--sub-filter=logo:marq');
    end;

    FHandle := libvlc_new(argc, PPAnsiChar(@args));
  end;
  Result := FHandle;
end;

function TPasLibVlc.GetError() : WideString;
begin
  Result := '';
  if Assigned(libvlc_errmsg) then
    Result := {$IFDEF DELPHI_XE2_UP}UTF8ToWideString{$ELSE}UTF8Decode{$ENDIF}(AnsiString(libvlc_errmsg()))
end;

function TPasLibVlc.GetVersion() : WideString;
begin
  Result := '';
  if Assigned(libvlc_get_version) then
    Result := {$IFDEF DELPHI_XE2_UP}UTF8ToWideString{$ELSE}UTF8Decode{$ENDIF}(AnsiString(libvlc_get_version()));
end;
  
function TPasLibVlc.GetVersionBin() : LongWord;
var
  a, b, c : LongWord;
  ptr : PAnsiChar;
  
begin
  if (FVersionBin = 0) then
  begin
    if Assigned(libvlc_get_version) then
    begin
      ptr := libvlc_get_version();
      a := read_dec_number(ptr) and $ff;
      b := read_dec_number(ptr) and $ff;
      c := read_dec_number(ptr) and $ff;
      FVersionBin := (a shl 16) or (b shl 8) or c;
    end;
  end;
  Result := FVersionBin;
end;

function TPasLibVlc.GetCompiler() : WideString;
begin
  Result := '';
  if Assigned(libvlc_get_compiler) then
    Result := {$IFDEF DELPHI_XE2_UP}UTF8ToWideString{$ELSE}UTF8Decode{$ENDIF}(AnsiString(libvlc_get_compiler()));
end;

function TPasLibVlc.GetChangeSet() : WideString;
begin
  Result := '';
  if Assigned(libvlc_get_changeset) then
    Result := {$IFDEF DELPHI_XE2_UP}UTF8ToWideString{$ELSE}UTF8Decode{$ENDIF}(AnsiString(libvlc_get_changeset()));
end;

procedure TPasLibVlc.SetPath(aPath: WideString);
begin
  FPath := aPath;
end;

{$IFNDEF HAS_WS_EX_TRANSPARENT}
const
  WS_EX_TRANSPARENT = $20;
{$ENDIF}

////////////////////////////////////////////////////////////////////////////////

procedure TPasLibVlcMouseEventWinCtrl.CreateParams(var params: TCreateParams);
begin
  inherited CreateParams(params);
  params.ExStyle := params.ExStyle or WS_EX_TRANSPARENT;
end;
{$IFDEF UNIX}
procedure TPasLibVlcMouseEventWinCtrl.WMEraseBkGnd(var msg: TLMEraseBkgnd);
begin
  SetBkMode(msg.DC, TRANSPARENT);
  msg.result := 1;
end;
{$ENDIF}
{$IFDEF MSWINDOWS}
procedure TPasLibVlcMouseEventWinCtrl.WMEraseBkgnd(var msg: TWMEraseBkGnd);
begin
  SetBkMode (msg.DC, TRANSPARENT);
  msg.result := 1;
end;
{$ENDIF}

////////////////////////////////////////////////////////////////////////////////

constructor TPasLibVlcMedia.Create(aVLC: TPasLibVlc);
begin
  inherited Create;
  FVLC := aVLC;
  FMD  := NIL;
end;

constructor TPasLibVlcMedia.Create(aVlc: TPasLibVlc; mrl: WideString);
begin
  inherited Create;
  FVLC := aVLC;
  FMD  := NIL;

  if FileExists(mrl) then
    NewPath(mrl)
  else
    NewLocation(mrl);
end;

constructor TPasLibVlcMedia.Create(aVlc: TPasLibVlc; aMD: libvlc_media_t_ptr);
begin
  inherited Create;
  FVLC := aVLC;
  FMD  := aMD;
end;

destructor TPasLibVlcMedia.Destroy;
begin
  if (FMD <> NIL) then
  begin
    libvlc_media_release(FMD);
  end;
  inherited Destroy;
end;

procedure TPasLibVlcMedia.SetDeinterlaceFilter(aValue: TDeinterlaceFilter);
begin
  case aValue of
    deOFF:  AddOption('deinterlace=0');
    deON:   AddOption('deinterlace=1');
  end;
end;

procedure TPasLibVlcMedia.SetDeinterlaceFilterMode(aValue: TDeinterlaceMode);
begin
  AddOption('deinterlace-mode=' + vlcDeinterlaceModeNames[aValue]);
end;

procedure TPasLibVlcMedia.AddOption(option: string);
var
  temp : AnsiString;
begin
  if (FMD <> NIL) then
  begin
    temp := Utf8Encode(option);
    libvlc_media_add_option(FMD, PAnsiChar(temp));
  end;
end;

procedure TPasLibVlcMedia.AddOptionFlag(option: string; flag: input_item_option_e);
begin
  if (FMD <> NIL) then
  begin
    libvlc_media_add_option_flag(FMD, PAnsiChar(UTF8Encode(option)), flag);
  end;
end;

procedure TPasLibVlcMedia.NewLocation(mrl: WideString);
begin
  if (FVLC.Handle <> NIL) then
  begin
    FMD := libvlc_media_new_location(FVLC.Handle, PAnsiChar(UTF8Encode(mrl)));
  end;
end;

procedure TPasLibVlcMedia.NewPath(path: WideString);
begin
  if (FVLC.Handle <> NIL) then
  begin
    FMD := libvlc_media_new_path(FVLC.Handle, PAnsiChar(UTF8Encode(path)));
  end;
end;

procedure TPasLibVlcMedia.NewNode(name: WideString);
begin
  if (FVLC.Handle <> NIL) then
  begin
    FMD := libvlc_media_new_as_node(FVLC.Handle, PAnsiChar(UTF8Encode(name)));
  end;
end;

function TPasLibVlcMedia.GetMrl(): WideString;
begin
  if (FMD <> NIL) then
  begin
    Result := {$IFDEF DELPHI_XE2_UP}UTF8ToWideString{$ELSE}UTF8Decode{$ENDIF}(AnsiString(libvlc_media_get_mrl(FMD)));
  end
  else
  begin
    Result := '';
  end;
end;

function TPasLibVlcMedia.Duplicate(): TPasLibVlcMedia;
begin
  if (FMD = NIL) then Result := TPasLibVlcMedia.Create(FVLC)
  else Result := TPasLibVlcMedia.Create(FVLC, libvlc_media_duplicate(FMD));
end;

function TPasLibVlcMedia.GetMeta(meta: libvlc_meta_t): WideString;
begin
  Result := {$IFDEF DELPHI_XE2_UP}UTF8ToWideString{$ELSE}UTF8Decode{$ENDIF}(AnsiString(libvlc_media_get_meta(FMD, meta)));
end;

procedure TPasLibVlcMedia.SetMeta(meta: libvlc_meta_t; value: WideString);
begin
  libvlc_media_set_meta(FMD, meta, PAnsiChar(UTF8Encode(value)));
end;

procedure TPasLibVlcMedia.SaveMeta();
begin
  libvlc_media_save_meta(FMD);
end;

function TPasLibVlcMedia.GetState(): libvlc_state_t;
begin
  Result := libvlc_media_get_state(FMD);
end;

function TPasLibVlcMedia.GetStats(var stats: libvlc_media_stats_t): Boolean;
begin
  Result := (libvlc_media_get_stats(FMD, @stats ) <> 0);
end;

function TPasLibVlcMedia.SubItems(): TPasLibVlcMediaListC;
begin
  Result := TPasLibVlcMediaListC.Create(
    FVLC,
    libvlc_media_subitems(FMD)
  );
end;

function TPasLibVlcMedia.GetEventManager(): libvlc_event_manager_t_ptr;
begin
  Result := libvlc_media_event_manager(FMD);
end;

function TPasLibVlcMedia.GetDuration(): libvlc_time_t;
begin
  Result := libvlc_media_get_duration(FMD);
end;

procedure TPasLibVlcMedia.Parse();
begin
  libvlc_media_parse(FMD);
end;

procedure TPasLibVlcMedia.ParseAsync();
begin
  libvlc_media_parse_async(FMD);
end;

function TPasLibVlcMedia.IsParsed(): Boolean;
begin
  Result := (libvlc_media_is_parsed(FMD) <> 0);
end;

procedure TPasLibVlcMedia.SetUserData(data: Pointer);
begin
  libvlc_media_set_user_data(FMD, data);
end;

function TPasLibVlcMedia.GetUserData(): Pointer;
begin
  Result := libvlc_media_get_user_data(FMD);
end;

function TPasLibVlcMedia.GetTracksInfo(var tracks : libvlc_media_track_info_t_ptr): Integer;
begin
  Result := libvlc_media_get_tracks_info(FMD, tracks);
end;

////////////////////////////////////////////////////////////////////////////////

constructor TPasLibVlcMediaListC.Create(aVLC: TPasLibVlc);
begin
  inherited Create;
  FVLC := aVLC;
  FML  := libvlc_media_list_new(FVLC.Handle);
end;

constructor TPasLibVlcMediaListC.Create(aVLC: TPasLibVlc; aML: libvlc_media_list_t_ptr);
begin
  inherited Create;
  FVLC    := aVLC;
  FML     := aML;
end;

destructor TPasLibVlcMediaListC.Destroy;
begin
  if (FML <> NIL) then
  begin
    libvlc_media_list_release(FML);
  end;
  
  inherited Destroy;
end;

procedure TPasLibVlcMediaListC.SetMedia(media: TPasLibVlcMedia);
begin
  libvlc_media_list_set_media(FML, media.MD);
end;

function TPasLibVlcMediaListC.GetMedia(): TPasLibVlcMedia;
begin
  Result := TPasLibVlcMedia.Create(FVLC, libvlc_media_list_media(FML));
end;

function TPasLibVlcMediaListC.GetMedia(index: Integer): TPasLibVlcMedia;
begin
  Result := TPasLibVlcMedia.Create(
    FVLC,
    libvlc_media_list_item_at_index(FML, index)
  );
end;

function TPasLibVlcMediaListC.GetIndex(media: TPasLibVlcMedia): Integer;
begin
  Result := libvlc_media_list_index_of_item(
    FML,
    media.MD
  );
end;

function TPasLibVlcMediaListC.IsReadOnly(): Boolean;
begin
  Result := (libvlc_media_list_is_readonly(FML) = 0);
end;

procedure TPasLibVlcMediaListC.Add(mrl: WideString);
var
  media: TPasLibVlcMedia;
begin
  media := TPasLibVlcMedia.Create(FVLC, mrl);

  if Assigned(SELF.FMP) then
  begin
    media.SetDeinterlaceFilter(SELF.FMP.FDeinterlaceFilter);
    media.SetDeinterlaceFilterMode(SELF.FMP.FDeinterlaceMode);
  end;

  Add(media);

  media.Free;
end;

procedure TPasLibVlcMediaListC.Add(media: TPasLibVlcMedia);
begin
  libvlc_media_list_lock(FML);
  libvlc_media_list_add_media(FML, media.MD);
  libvlc_media_list_unlock(FML);
end;

procedure TPasLibVlcMediaListC.Insert(media: TPasLibVlcMedia; index: Integer);
begin
  libvlc_media_list_lock(FML);
  libvlc_media_list_insert_media(FML, media.MD, index);
  libvlc_media_list_unlock(FML);
end;

procedure TPasLibVlcMediaListC.Delete(index: Integer);
begin
  libvlc_media_list_lock(FML);
  libvlc_media_list_remove_index(FML, index);
  libvlc_media_list_unlock(FML);
end;

procedure TPasLibVlcMediaListC.Clear();
begin
  libvlc_media_list_lock(FML);
  while (Count() > 0) do
  begin
    libvlc_media_list_remove_index(FML, 0);
  end;
  libvlc_media_list_unlock(FML);
end;

function TPasLibVlcMediaListC.Count(): Integer;
begin
  libvlc_media_list_lock(FML);
  Result := libvlc_media_list_count(FML);
  libvlc_media_list_unlock(FML);
end;

procedure TPasLibVlcMediaListC.Lock();
begin
  libvlc_media_list_lock(FML);
end;

procedure TPasLibVlcMediaListC.UnLock();
begin
  libvlc_media_list_unlock(FML);
end;

function TPasLibVlcMediaListC.GetEventManager(): libvlc_event_manager_t_ptr;
begin
  Result := libvlc_media_list_event_manager(FML);
end;

////////////////////////////////////////////////////////////////////////////////

constructor TPasLibVlcEqualizer.Create(AVLC: TPasLibVlc; aPreset : WORD = $FFFF);
begin
  inherited Create;
  FVLC       := AVLC;
  FEqualizer := NIL;
  FPreset    := aPreset;
end;

destructor TPasLibVlcEqualizer.Destroy;
begin
  if (FEqualizer <> NIL) then
  begin
    libvlc_audio_equalizer_release(FEqualizer);
    FEqualizer := NIL;
  end;
  inherited Destroy;
end;

function TPasLibVlcEqualizer.GetPreAmp() : Single;
begin
  Result := 0;
  if (SELF.GetHandle() = NIL) then exit;
  Result := libvlc_audio_equalizer_get_preamp(FEqualizer);
end;

procedure TPasLibVlcEqualizer.SetPreAmp(value : Single);
begin
  if (SELF.GetHandle() = NIL) then exit;
  libvlc_audio_equalizer_set_preamp(FEqualizer, value);
end;

function TPasLibVlcEqualizer.GetAmp(index: Word) :  Single;
begin
  Result := 0;
  if (SELF.GetHandle() = NIL) then exit;
  Result := libvlc_audio_equalizer_get_amp_at_index(FEqualizer, index);
end;

procedure TPasLibVlcEqualizer.SetAmp(index : Word; value : Single);
begin
  if (SELF.GetHandle() = NIL) then exit;
  libvlc_audio_equalizer_set_amp_at_index(FEqualizer, value, index);
end;

function TPasLibVlcEqualizer.GetBandCount() : Word;
begin
  Result := 0;
  if (FVLC.GetHandle() = NIL) then exit;  
  Result := libvlc_audio_equalizer_get_band_count();
end;

function TPasLibVlcEqualizer.GetBandFrequency(index : Word) : Single;
begin
  Result := 0;
  if (FVLC.GetHandle() = NIL) then exit;
  Result := libvlc_audio_equalizer_get_band_frequency(index);
end;

function TPasLibVlcEqualizer.GetPresetCount() : Word;
begin
  Result := 0;
  if (FVLC.GetHandle() = NIL) then exit;
  Result := libvlc_audio_equalizer_get_preset_count();
end;

function TPasLibVlcEqualizer.GetPresetName(index : Word) : WideString;
var
  preset : PAnsiChar;
begin
  Result := '';
  if (FVLC.GetHandle() = NIL) then exit;
  preset := libvlc_audio_equalizer_get_preset_name(index);
  Result := {$IFDEF DELPHI_XE2_UP}UTF8ToWideString{$ELSE}UTF8Decode{$ENDIF}(preset);
end;

function TPasLibVlcEqualizer.GetPresetName() : WideString;
begin
  Result := GetPresetName(FPreset);
end;

function TPasLibVlcEqualizer.GetPreset() : Word;
begin
  Result := FPreset;
end;

procedure TPasLibVlcEqualizer.SetPreset(APreset : Word = $FFFF);
begin
  FPreset := aPreset;
  if (FEqualizer <> NIL) then
  begin
    libvlc_audio_equalizer_release(FEqualizer);
    FEqualizer := NIL;
  end;
end;

function TPasLibVlcEqualizer.GetHandle() : libvlc_equalizer_t_ptr;
begin
  Result := NIL;
  if (FVLC.GetHandle() = NIL) then exit;
  
  if (FEqualizer = NIL) then
  begin
    if (FPreset<> $FFFF) then
    begin
      FEqualizer := libvlc_audio_equalizer_new_from_preset(FPreset);
    end;
    if (FEqualizer = NIL) then
    begin
      FEqualizer := libvlc_audio_equalizer_new();
    end;
  end;
  Result := FEqualizer;
end;

////////////////////////////////////////////////////////////////////////////////

{$IFNDEF HAS_SYNCOBJS}

constructor TCriticalSection.Create;
begin
  inherited Create;
  InitializeCriticalSection(FSection);
end;

destructor TCriticalSection.Destroy;
begin
  DeleteCriticalSection(FSection);
  inherited Destroy;
end;

procedure TCriticalSection.Enter;
begin
  EnterCriticalSection(FSection);
end;

procedure TCriticalSection.Leave;
begin
  LeaveCriticalSection(FSection);
end;

{$ENDIF}

end.
