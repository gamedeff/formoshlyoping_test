unit MainFormUnit;

{$mode Delphi}{$H+}

interface

uses
  {$IFDEF UNIX}Unix,{$ENDIF}
  {$IFDEF MSWINDOWS}{$IFNDEF FPC}Windows,{$ENDIF}{$ENDIF}
  {$IFDEF LCLGTK2}Gtk2, {$IFDEF UNIX}Gdk2x,{$ENDIF}{$ENDIF}
  {$IFDEF LCLQT}Qt4, QtWidgets, {$ENDIF}
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Menus,
  ExtCtrls, {$IFNDEF FPC}StdCtrls,{$ENDIF} PasLibVlcUnit;

const
  MAX_ARGS = 255;

type

  { TMainForm }

  TMainForm = class(TForm)
    FileMenuItem: TMenuItem;
    OpenDialog: TOpenDialog;
    MainMenu: TMainMenu;
    MenuFile: TMenuItem;
    MenuFileOpen: TMenuItem;
    MenuFileQuit: TMenuItem;
    OpenMenuItem: TMenuItem;
    QuitItem: TMenuItem;
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
    procedure AddArg(value : AnsiString);
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

{$R *.lfm}

{ TMainForm }

procedure TMainForm.AddArg(value : AnsiString);
begin
  if (argc < MAX_ARGS) then
  begin
    argv[argc] := value;
    args[argc] := PAnsiChar(argv[argc]);
    Inc(argc);
  end;
end;

procedure TMainForm.PlayerInit();
begin
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
  AddArg('--no-video-title-show');
  AddArg('--no-video-on-top');

  p_li := libvlc_new(argc, @args);
  p_mi := NIL;
end;

procedure TMainForm.PlayerPlay(fileName: WideString);
var
  p_md : libvlc_media_t_ptr;
  a_st : AnsiString;
  p_st : PAnsiChar;
begin
  PlayerStop();

  a_st := UTF8Encode(fileName);
  p_st := PAnsiChar(@a_st[1]);

  p_md := libvlc_media_new_path(p_li, p_st);

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
  {$IFDEF LCLGTK2}
    Caption := Caption + ' LCL GTK2';
  {$ELSE}
    {$IFDEF LCLQT}
      Caption := Caption + ' LCL QT';
    {$ELSE}
      Caption := Caption + ' LCL WIN32';
    {$ENDIF}
  {$ENDIF}
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
      {$IFDEF MSWINDOWS}
        PlayerPlay(StringReplace(OpenDialog.FileName, '/', '\', [rfReplaceAll]));
      {$ELSE}
        PlayerPlay(OpenDialog.FileName);
      {$ENDIF}
    end;
  end;
end;

procedure TMainForm.MenuFileQuitClick(Sender: TObject);
begin
  Application.Terminate;
end;


end.

