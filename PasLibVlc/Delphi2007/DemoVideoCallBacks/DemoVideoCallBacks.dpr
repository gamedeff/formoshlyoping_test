{$APPTYPE CONSOLE}

program DemoVideoCallBacks;

uses
  Windows,
  Graphics,
  PasLibVlcUnit in '..\..\source\PasLibVlcUnit.pas';

type
  PCtx = ^TCtx;
  TCtx = record
  end;

const
  DEMO_FILE = '..\..\_testFiles\Maximize.mp4';
  VIDEO_W   = 320;
  VIDEO_H   = 240;
  MAX_ARGS  = 256;

var
  argv : packed array[0..MAX_ARGS-1] of AnsiString;
  args : packed array[0..MAX_ARGS-1] of PAnsiChar;
  argc : Integer;

  p_li : libvlc_instance_t_ptr;
  p_md : libvlc_media_t_ptr;
  p_mi : libvlc_media_player_t_ptr;

  buff : Pointer;
  bmpi : Graphics.TBitmap;
  bmpc : Cardinal;
  ctxs : TCtx;

procedure AddArg(value : AnsiString);
begin
  if (argc < MAX_ARGS) then
  begin
    argv[argc] := value;
    args[argc] := PAnsiChar(argv[argc]);
    Inc(argc);
  end;
end;  

function libvlc_video_lock_cb(ctx : Pointer; var planes : Pointer) : Pointer; cdecl;
begin
  planes := Pointer(((Cardinal(buff) + 31) shr 5) shl 5);
  Result := buff;
end;

function libvlc_video_unlock_cb(ctx : Pointer; picture : Pointer; planes : Pointer) : Pointer; cdecl;
begin
  Result := NIL;
end;

function libvlc_video_display_cb_RV32(ctx : Pointer; picture : Pointer) : Pointer; cdecl;
var
  y        : Integer;
  src      : PByte;
  fileNumb : ShortString;
  fileName : ShortString;
begin
  src := Pointer(((Cardinal(buff) + 31) shr 5) shl 5);
  for y := 0 to VIDEO_H-1 do
  begin
    Move(src^, bmpi.ScanLine[y]^, VIDEO_W * 4);
    Inc(src, VIDEO_W * 4);
  end;
  Inc(bmpc);
  Str(bmpc, fileNumb);

  fileName := Copy('000000', 1, 6 - Length(fileNumb)) + fileNumb + '.bmp';
  WriteLn(fileName);
  
  bmpi.SaveToFile(fileName);

  Result := NIL;
end;

begin
  buff := AllocMem(VIDEO_W * VIDEO_H * 4 + 32);

  bmpc := 0;

  bmpi := Graphics.TBitmap.Create;
  bmpi.PixelFormat := pf32bit;
  bmpi.Width       := VIDEO_W;
  bmpi.Height      := VIDEO_H;

  libvlc_dynamic_dll_init();

  argc := 0;
  AddArg(libvlc_dynamic_dll_path);
  AddArg('--intf=dummy');
  AddArg('--ignore-config');
  AddArg('--quiet');
  AddArg('--no-video-title-show');
  AddArg('--vout=vdummy');
  AddArg('--aout=adummy');

  p_li := libvlc_new(argc, @args);
  p_md := libvlc_media_new_path(p_li, PAnsiChar(UTF8Encode(DEMO_FILE)));
  libvlc_media_parse(p_md);
  
  p_mi := libvlc_media_player_new_from_media(p_md);

  libvlc_media_player_play(p_mi);
  
  libvlc_video_set_callbacks(p_mi, libvlc_video_lock_cb, libvlc_video_unlock_cb, libvlc_video_display_cb_RV32, @ctxs);
  libvlc_video_set_format(p_mi, 'RV32', VIDEO_W, VIDEO_H, VIDEO_W * 4);

  while (libvlc_media_player_get_state(p_mi) <> libvlc_Ended) do
  begin
    Sleep(10);
  end;

  libvlc_media_release(p_md);
  libvlc_media_player_release(p_mi);
  libvlc_release(p_li);
end.
