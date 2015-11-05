{$APPTYPE CONSOLE}

program DemoAudioOutput;

uses
  SysUtils,
  Classes,
  PasLibVlcUnit in '..\..\source\PasLibVlcUnit.pas';

var
  args       : packed array[0..2] of PAnsiChar;
  p_instance : libvlc_instance_t_ptr;

  vlc_audio_output_list : libvlc_audio_output_t_ptr;
  vlc_audio_output_enum : libvlc_audio_output_t_ptr;

  libvlc_audio_output_device_list : libvlc_audio_output_device_t_ptr;
  libvlc_audio_output_device_enum : libvlc_audio_output_device_t_ptr;
begin
  try
    libvlc_dynamic_dll_init();
    args[0] := PAnsiChar(libvlc_dynamic_dll_path);
    args[1] := '--ignore-config';
    args[2] := NIL;
    p_instance := libvlc_new(2, @args);

    WriteLn('libvlc_audio_output_list_get(p_instance);');

    vlc_audio_output_list := libvlc_audio_output_list_get(p_instance);
    vlc_audio_output_enum := vlc_audio_output_list;
    while (vlc_audio_output_enum <> NIL) do
    begin
      WriteLn('// ', vlc_audio_output_enum^.psz_description);
      WriteLn('libvlc_audio_output_device_list_get(p_instance, ' + Chr(39), vlc_audio_output_enum^.psz_name, Chr(39) + ');');
      WriteLn;
      libvlc_audio_output_device_list := libvlc_audio_output_device_list_get(p_instance, vlc_audio_output_enum^.psz_name);
      libvlc_audio_output_device_enum := libvlc_audio_output_device_list;
      if (libvlc_audio_output_device_enum <> NIL) then
      begin
        while (libvlc_audio_output_device_enum <> NIL) do
        begin
          WriteLn('  name = ', libvlc_audio_output_device_enum^.psz_device);
          WriteLn('  desc = ', libvlc_audio_output_device_enum^.psz_description);
          WriteLn;
          libvlc_audio_output_device_enum := libvlc_audio_output_device_enum^.p_next;
        end;
      end
      else
      begin
        WriteLn('  NOT FOUND');
        WriteLn;
      end;
      libvlc_audio_output_device_list_release(libvlc_audio_output_device_list);
      vlc_audio_output_enum := vlc_audio_output_enum^.p_next;
    end;
    libvlc_audio_output_list_release(vlc_audio_output_list);
    WriteLn;

    ReadLn;
  except
    on E:Exception do
      Writeln(E.Classname, ': ', E.Message);
  end;
end.
