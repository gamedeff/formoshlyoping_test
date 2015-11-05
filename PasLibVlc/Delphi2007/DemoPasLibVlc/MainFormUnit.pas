(* This is file is part of PasLibVlcDemo program
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
  {$IFDEF LCLGTK2}Gtk2, {$IFDEF UNIX}Gdk2x,{$ENDIF}{$ENDIF}
  {$IFDEF LCLQT}Qt4, QtWidgets, {$ENDIF}
  Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Menus,
  PasLibVlcUnit;

const
  MAX_ARGS = 255;

type
  TMainForm = class(TForm)
    OpenDialog: TOpenDialog;
    MainMenu: TMainMenu;
    MenuFile: TMenuItem;
    MenuFileOpen: TMenuItem;
    MenuFileQuit: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure MenuFileOpenClick(Sender: TObject);
    procedure MenuFileQuitClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    p_li : libvlc_instance_t_ptr;
    p_mi : libvlc_media_player_t_ptr;
    argv : packed array[0..MAX_ARGS-1] of AnsiString;
    args : packed array[0..MAX_ARGS-1] of PAnsiChar;
    argc : Integer;
    procedure AddArg(value : string);
    procedure PlayerInit();
    procedure PlayerPlay(fileName: WideString);
    procedure PlayerStop();
    procedure PlayerDestroy();
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.AddArg(value : string);
begin
  if (argc < MAX_ARGS) then
  begin
    argv[argc] := Utf8Encode(value);
    args[argc] := PAnsiChar(argv[argc]);
    Inc(argc);
  end;
end;
  
procedure TMainForm.PlayerInit();
begin
//  libvlc_dynamic_dll_init_with_path('C:\Program Files\VideoLAN\VLC');
  libvlc_dynamic_dll_init();

  if (libvlc_dynamic_dll_error <> '') then
  begin
    MessageDlg(libvlc_dynamic_dll_error, mtError, [mbOK], 0);
    exit;
  end;
  
  argc := 0;
  AddArg(libvlc_dynamic_dll_path);
  AddArg('--intf=dummy');
  AddArg('--ignore-config');
  AddArg('--quiet');
//  AddArg('--no-video-title-show');
//  AddArg('--no-video-on-top');

  p_li := libvlc_new(argc, @args);
  p_mi := NIL;
end;

procedure TMainForm.PlayerPlay(fileName: WideString);
var
  p_md : libvlc_media_t_ptr;
begin
  PlayerStop();
  p_md := libvlc_media_new_path(p_li, PAnsiChar(UTF8Encode(fileName)));
  if (p_md <> NIL) then
  begin
    p_mi := libvlc_media_player_new_from_media(p_md);
    if (p_mi <> NIL) then
    begin
      libvlc_video_set_key_input(p_mi, 1);
      libvlc_video_set_mouse_input(p_mi, 1);
      libvlc_media_player_set_display_window(p_mi, SELF.Handle);
    end;
    libvlc_media_player_play(p_mi);
    libvlc_media_release(p_md);
  end;
end;

procedure TMainForm.PlayerStop();
begin
  if (p_mi <> NIL) then
  begin
    libvlc_media_player_stop(p_mi);
    while (libvlc_media_player_get_state(p_mi) = libvlc_Playing) do
    begin
      Sleep(50);
    end;
    libvlc_media_player_release(p_mi);
    p_mi := NIL;
  end;
end;

procedure TMainForm.PlayerDestroy();
begin
  if (p_li <> NIL) then
  begin
    PlayerStop();
    libvlc_release(p_li);
    p_li := NIL;
  end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  p_li := NIL;
  p_mi := NIL;
  PlayerInit();
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  PlayerDestroy();
end;

procedure TMainForm.MenuFileOpenClick(Sender: TObject);
begin
  if (p_li <> NIL) then
  begin
    if OpenDialog.Execute() then
    begin
      PlayerPlay(OpenDialog.FileName);
    end;
  end;
end;

procedure TMainForm.MenuFileQuitClick(Sender: TObject);
begin
  Close();
end;

end.

