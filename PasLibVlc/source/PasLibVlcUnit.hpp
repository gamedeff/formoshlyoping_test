// CodeGear C++Builder
// Copyright (c) 1995, 2012 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'PasLibVlcUnit.pas' rev: 24.00 (Windows)

#ifndef PaslibvlcunitHPP
#define PaslibvlcunitHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Paslibvlcunit
{
//-- type declarations -------------------------------------------------------
typedef void *libvlc_instance_t_ptr;

typedef void *libvlc_log_t_ptr;

typedef void *libvlc_log_iterator_t_ptr;

typedef void *libvlc_media_t_ptr;

typedef void *libvlc_media_player_t_ptr;

typedef void *libvlc_media_list_t_ptr;

typedef void *libvlc_media_list_player_t_ptr;

typedef void *libvlc_media_library_t_ptr;

typedef void *libvlc_media_discoverer_t_ptr;

typedef void *libvlc_event_manager_t_ptr;

typedef __int64 *libvlc_time_t_ptr;

typedef __int64 libvlc_time_t;

struct libvlc_log_message_t;
typedef libvlc_log_message_t *libvlc_log_message_t_ptr;

#pragma pack(push,1)
struct DECLSPEC_DRECORD libvlc_log_message_t
{
public:
	int i_severity;
	char *psz_type;
	char *psz_name;
	char *psz_header;
	char *psz_message;
};
#pragma pack(pop)


enum DECLSPEC_DENUM libvlc_meta_t : unsigned int { libvlc_meta_Title, libvlc_meta_Artist, libvlc_meta_Genre, libvlc_meta_Copyright, libvlc_meta_Album, libvlc_meta_TrackNumber, libvlc_meta_Description, libvlc_meta_Rating, libvlc_meta_Date, libvlc_meta_Setting, libvlc_meta_URL, libvlc_meta_Language, libvlc_meta_NowPlaying, libvlc_meta_Publisher, libvlc_meta_EncodedBy, libvlc_meta_ArtworkURL, libvlc_meta_TrackID, libvlc_meta_TrackTotal, libvlc_meta_Director, libvlc_meta_Season, libvlc_meta_Episode, libvlc_meta_ShowName, libvlc_meta_Actors };

enum DECLSPEC_DENUM libvlc_state_t : unsigned int { libvlc_NothingSpecial, libvlc_Opening, libvlc_Buffering, libvlc_Playing, libvlc_Paused, libvlc_Stopped, libvlc_Ended, libvlc_Error };

enum DECLSPEC_DENUM libvlc_track_type_t: int { libvlc_track_unknown = -1, libvlc_track_audio, libvlc_track_video, libvlc_track_text };

struct libvlc_media_stats_t;
typedef libvlc_media_stats_t *libvlc_media_stats_t_ptr;

#pragma pack(push,1)
struct DECLSPEC_DRECORD libvlc_media_stats_t
{
public:
	int i_read_bytes;
	float f_input_bitrate;
	int i_demux_read_bytes;
	float f_demux_bitrate;
	int i_demux_corrupted;
	int i_demux_discontinuity;
	int i_decoded_video;
	int i_decoded_audio;
	int i_displayed_pictures;
	int i_lost_pictures;
	int i_played_abuffers;
	int i_lost_abuffers;
	int i_sent_packets;
	int i_sent_bytes;
	float f_send_bitrate;
};
#pragma pack(pop)


#pragma pack(push,1)
struct DECLSPEC_DRECORD libvlc_media_track_info_t_audio
{
public:
	unsigned i_channels;
	unsigned i_rate;
};
#pragma pack(pop)


#pragma pack(push,1)
struct DECLSPEC_DRECORD libvlc_media_track_info_t_video
{
public:
	unsigned i_height;
	unsigned i_width;
};
#pragma pack(pop)


struct libvlc_media_track_info_t;
typedef libvlc_media_track_info_t *libvlc_media_track_info_t_ptr;

#pragma pack(push,1)
struct DECLSPEC_DRECORD libvlc_media_track_info_t
{
public:
	unsigned i_codec;
	int i_id;
	libvlc_track_type_t i_type;
	int i_profile;
	int i_level;
	union
	{
		struct 
		{
			libvlc_media_track_info_t_video video;
		};
		struct 
		{
			libvlc_media_track_info_t_audio audio;
		};
		
	};
};
#pragma pack(pop)


struct libvlc_audio_track_t;
typedef libvlc_audio_track_t *libvlc_audio_track_t_ptr;

#pragma pack(push,1)
struct DECLSPEC_DRECORD libvlc_audio_track_t
{
public:
	unsigned i_channels;
	unsigned i_rate;
};
#pragma pack(pop)


struct libvlc_video_track_t;
typedef libvlc_video_track_t *libvlc_video_track_t_ptr;

#pragma pack(push,1)
struct DECLSPEC_DRECORD libvlc_video_track_t
{
public:
	unsigned i_height;
	unsigned i_width;
	unsigned i_sar_num;
	unsigned i_sar_den;
	unsigned i_frame_rate_num;
	unsigned i_frame_rate_den;
};
#pragma pack(pop)


struct libvlc_subtitle_track_t;
typedef libvlc_subtitle_track_t *libvlc_subtitle_track_t_ptr;

#pragma pack(push,1)
struct DECLSPEC_DRECORD libvlc_subtitle_track_t
{
public:
	char *psz_encoding;
};
#pragma pack(pop)


#pragma pack(push,1)
struct DECLSPEC_DRECORD libvlc_media_track_t_union
{
	union
	{
		struct 
		{
			libvlc_subtitle_track_t subtitle;
		};
		struct 
		{
			libvlc_video_track_t video;
		};
		struct 
		{
			libvlc_audio_track_t audio;
		};
		
	};
};
#pragma pack(pop)


struct libvlc_media_track_t;
typedef libvlc_media_track_t *libvlc_media_track_t_ptr;

#pragma pack(push,1)
struct DECLSPEC_DRECORD libvlc_media_track_t
{
public:
	unsigned i_codec;
	unsigned i_original_fourcc;
	int i_id;
	libvlc_track_type_t i_type;
	int i_profile;
	int i_level;
	libvlc_media_track_t_union u;
	unsigned i_bitrate;
	char *psz_language;
	char *psz_description;
};
#pragma pack(pop)


struct libvlc_track_description_t;
typedef libvlc_track_description_t *libvlc_track_description_t_ptr;

#pragma pack(push,1)
struct DECLSPEC_DRECORD libvlc_track_description_t
{
public:
	int i_id;
	char *psz_name;
	libvlc_track_description_t *p_next;
};
#pragma pack(pop)


struct libvlc_audio_output_t;
typedef libvlc_audio_output_t *libvlc_audio_output_t_ptr;

#pragma pack(push,1)
struct DECLSPEC_DRECORD libvlc_audio_output_t
{
public:
	char *psz_name;
	char *psz_description;
	libvlc_audio_output_t *p_next;
};
#pragma pack(pop)


struct libvlc_audio_output_device_t;
typedef libvlc_audio_output_device_t *libvlc_audio_output_device_t_ptr;

#pragma pack(push,1)
struct DECLSPEC_DRECORD libvlc_audio_output_device_t
{
public:
	libvlc_audio_output_device_t *p_next;
	char *psz_device;
	char *psz_description;
};
#pragma pack(pop)


typedef void * libvlc_equalizer_t_ptr;

typedef System::Word unsigned_t;

struct libvlc_rectangle_t;
typedef libvlc_rectangle_t *libvlc_rectangle_t_ptr;

#pragma pack(push,1)
struct DECLSPEC_DRECORD libvlc_rectangle_t
{
public:
	int top;
	int left;
	int bottom;
	int right;
};
#pragma pack(pop)


typedef System::Byte libvlc_opacity_t;

enum DECLSPEC_DENUM libvlc_video_marquee_option_t : unsigned int { libvlc_marquee_Enable, libvlc_marquee_Text, libvlc_marquee_Color, libvlc_marquee_Opacity, libvlc_marquee_Position, libvlc_marquee_Refresh, libvlc_marquee_Size, libvlc_marquee_Timeout, libvlc_marquee_X, libvlc_marquee_Y };

typedef int libvlc_video_marquee_color_t;

enum DECLSPEC_DENUM libvlc_video_logo_option_t : unsigned int { libvlc_logo_Enable, libvlc_logo_File, libvlc_logo_X, libvlc_logo_Y, libvlc_logo_Delay, libvlc_logo_Repeat, libvlc_logo_Opacity, libvlc_logo_Position };

enum DECLSPEC_DENUM libvlc_audio_output_device_types_t: int { libvlc_AudioOutputDevice_Error = -1, libvlc_AudioOutputDevice_Mono = 1, libvlc_AudioOutputDevice_Stereo, libvlc_AudioOutputDevice_2F2R = 4, libvlc_AudioOutputDevice_3F2R, libvlc_AudioOutputDevice_5_1, libvlc_AudioOutputDevice_6_1, libvlc_AudioOutputDevice_7_1, libvlc_AudioOutputDevice_SPDIF = 10 };

enum DECLSPEC_DENUM libvlc_audio_output_channel_t: int { libvlc_AudioChannel_Error = -1, libvlc_AudioChannel_NotAvail, libvlc_AudioChannel_Stereo, libvlc_AudioChannel_RStereo, libvlc_AudioChannel_Left, libvlc_AudioChannel_Right, libvlc_AudioChannel_Dolbys };

enum DECLSPEC_DENUM libvlc_playback_mode_t : unsigned int { libvlc_playback_mode_default, libvlc_playback_mode_loop, libvlc_playback_mode_repeat };

enum DECLSPEC_DENUM libvlc_navigate_mode_t : unsigned int { libvlc_navigate_activate, libvlc_navigate_up, libvlc_navigate_down, libvlc_navigate_left, libvlc_navigate_right };

enum DECLSPEC_DENUM libvlc_position_t: int { libvlc_position_disable = -1, libvlc_position_center, libvlc_position_left, libvlc_position_right, libvlc_position_top = 4, libvlc_position_top_left, libvlc_position_top_right, libvlc_position_bottom = 8, libvlc_position_bottom_left, libvlc_position_bottom_right };

enum DECLSPEC_DENUM libvlc_event_type_t : unsigned int { libvlc_MediaMetaChanged, libvlc_MediaSubItemAdded, libvlc_MediaDurationChanged, libvlc_MediaParsedChanged, libvlc_MediaFreed, libvlc_MediaStateChanged, libvlc_MediaSubItemTreeAdded, libvlc_MediaPlayerMediaChanged = 256, libvlc_MediaPlayerNothingSpecial, libvlc_MediaPlayerOpening, libvlc_MediaPlayerBuffering, libvlc_MediaPlayerPlaying, libvlc_MediaPlayerPaused, libvlc_MediaPlayerStopped, libvlc_MediaPlayerForward, libvlc_MediaPlayerBackward, libvlc_MediaPlayerEndReached, libvlc_MediaPlayerEncounteredError, libvlc_MediaPlayerTimeChanged, libvlc_MediaPlayerPositionChanged, libvlc_MediaPlayerSeekableChanged, libvlc_MediaPlayerPausableChanged, libvlc_MediaPlayerTitleChanged, libvlc_MediaPlayerSnapshotTaken, 
	libvlc_MediaPlayerLengthChanged, libvlc_MediaPlayerVout, libvlc_MediaPlayerScrambledChanged, libvlc_MediaListItemAdded = 512, libvlc_MediaListWillAddItem, libvlc_MediaListItemDeleted, libvlc_MediaListWillDeleteItem, libvlc_MediaListViewItemAdded = 768, libvlc_MediaListViewWillAddItem, libvlc_MediaListViewItemDeleted, libvlc_MediaListViewWillDeleteItem, libvlc_MediaListPlayerPlayed = 1024, libvlc_MediaListPlayerNextItemSet, libvlc_MediaListPlayerStopped, libvlc_MediaDiscovererStarted = 1280, libvlc_MediaDiscovererEnded, libvlc_VlmMediaAdded = 1536, libvlc_VlmMediaRemoved, libvlc_VlmMediaChanged, libvlc_VlmMediaInstanceStarted, libvlc_VlmMediaInstanceStopped, libvlc_VlmMediaInstanceStatusInit, libvlc_VlmMediaInstanceStatusOpening, 
	libvlc_VlmMediaInstanceStatusPlaying, libvlc_VlmMediaInstanceStatusPause, libvlc_VlmMediaInstanceStatusEnd, libvlc_VlmMediaInstanceStatusError };

#pragma pack(push,1)
struct DECLSPEC_DRECORD event_media_meta_changed_t
{
public:
	libvlc_meta_t meta_type;
};
#pragma pack(pop)


#pragma pack(push,1)
struct DECLSPEC_DRECORD event_media_subitem_added_t
{
public:
	void *new_child;
};
#pragma pack(pop)


#pragma pack(push,1)
struct DECLSPEC_DRECORD event_media_duration_changed_t
{
public:
	__int64 new_duration;
};
#pragma pack(pop)


#pragma pack(push,1)
struct DECLSPEC_DRECORD media_parsed_changed_t
{
public:
	int new_status;
};
#pragma pack(pop)


#pragma pack(push,1)
struct DECLSPEC_DRECORD media_freed_t
{
public:
	void *md;
};
#pragma pack(pop)


#pragma pack(push,1)
struct DECLSPEC_DRECORD media_state_changed_t
{
public:
	libvlc_state_t new_state;
};
#pragma pack(pop)


#pragma pack(push,1)
struct DECLSPEC_DRECORD media_subitemtree_added_t
{
public:
	void *item;
};
#pragma pack(pop)


#pragma pack(push,1)
struct DECLSPEC_DRECORD media_player_buffering_t
{
public:
	float new_cache;
};
#pragma pack(pop)


#pragma pack(push,1)
struct DECLSPEC_DRECORD media_player_media_changed_t
{
public:
	void *new_media;
};
#pragma pack(pop)


#pragma pack(push,1)
struct DECLSPEC_DRECORD media_player_time_changed_t
{
public:
	__int64 new_time;
};
#pragma pack(pop)


#pragma pack(push,1)
struct DECLSPEC_DRECORD media_player_position_changed_t
{
public:
	float new_position;
};
#pragma pack(pop)


#pragma pack(push,1)
struct DECLSPEC_DRECORD media_player_seekable_changed_t
{
public:
	int new_seekable;
};
#pragma pack(pop)


#pragma pack(push,1)
struct DECLSPEC_DRECORD media_player_pausable_changed_t
{
public:
	int new_pausable;
};
#pragma pack(pop)


#pragma pack(push,1)
struct DECLSPEC_DRECORD media_player_vout_t
{
public:
	int new_count;
};
#pragma pack(pop)


#pragma pack(push,1)
struct DECLSPEC_DRECORD media_player_scrambled_changed_t
{
public:
	int new_scrambled;
};
#pragma pack(pop)


#pragma pack(push,1)
struct DECLSPEC_DRECORD media_player_snapshot_taken_t
{
public:
	char *psz_filename;
};
#pragma pack(pop)


#pragma pack(push,1)
struct DECLSPEC_DRECORD media_player_length_changed_t
{
public:
	__int64 new_length;
};
#pragma pack(pop)


#pragma pack(push,1)
struct DECLSPEC_DRECORD media_player_title_changed_t
{
public:
	int new_title;
};
#pragma pack(pop)


#pragma pack(push,1)
struct DECLSPEC_DRECORD media_list_item_added_t
{
public:
	void *item;
	int index;
};
#pragma pack(pop)


#pragma pack(push,1)
struct DECLSPEC_DRECORD media_list_will_add_item_t
{
public:
	void *item;
	int index;
};
#pragma pack(pop)


#pragma pack(push,1)
struct DECLSPEC_DRECORD media_list_item_deleted_t
{
public:
	void *item;
	int index;
};
#pragma pack(pop)


#pragma pack(push,1)
struct DECLSPEC_DRECORD media_list_will_delete_item_t
{
public:
	void *item;
	int index;
};
#pragma pack(pop)


#pragma pack(push,1)
struct DECLSPEC_DRECORD media_list_player_next_item_set_t
{
public:
	void *item;
};
#pragma pack(pop)


#pragma pack(push,1)
struct DECLSPEC_DRECORD vlm_media_event_t
{
public:
	char *psz_media_name;
	char *psz_instance_name;
};
#pragma pack(pop)


struct libvlc_event_t;
typedef libvlc_event_t *libvlc_event_t_ptr;

#pragma pack(push,4)
struct DECLSPEC_DRECORD libvlc_event_t
{
public:
	libvlc_event_type_t event_type;
	void *p_obj;
	#pragma pack(push,1)
	union
	{
		struct 
		{
			vlm_media_event_t vlm_media_event;
		};
		struct 
		{
			media_list_will_delete_item_t media_list_will_delete_item;
		};
		struct 
		{
			media_list_item_deleted_t media_list_item_deleted;
		};
		struct 
		{
			media_list_will_add_item_t media_list_will_add_item;
		};
		struct 
		{
			media_list_item_added_t media_list_item_added;
		};
		struct 
		{
			media_player_scrambled_changed_t media_player_scrambled_changed;
		};
		struct 
		{
			media_player_vout_t media_player_vout;
		};
		struct 
		{
			media_player_pausable_changed_t media_player_pausable_changed;
		};
		struct 
		{
			media_player_seekable_changed_t media_player_seekable_changed;
		};
		struct 
		{
			media_player_title_changed_t media_player_title_changed;
		};
		struct 
		{
			media_player_time_changed_t media_player_time_changed;
		};
		struct 
		{
			media_player_position_changed_t media_player_position_changed;
		};
		struct 
		{
			media_player_buffering_t media_player_buffering;
		};
		struct 
		{
			media_subitemtree_added_t media_subitemtree_added;
		};
		struct 
		{
			media_state_changed_t media_state_changed;
		};
		struct 
		{
			media_freed_t media_freed;
		};
		struct 
		{
			media_parsed_changed_t media_parsed_changed;
		};
		struct 
		{
			event_media_duration_changed_t media_duration_changed;
		};
		struct 
		{
			event_media_subitem_added_t media_subitem_added;
		};
		struct 
		{
			event_media_meta_changed_t media_meta_changed;
		};
		struct 
		{
			media_player_length_changed_t media_player_length_changed;
		};
		struct 
		{
			media_player_snapshot_taken_t media_player_snapshot_taken;
		};
		struct 
		{
			media_list_player_next_item_set_t media_list_player_next_item_set;
		};
		struct 
		{
			media_player_media_changed_t media_player_media_changed;
		};
		
	};
	#pragma pack(pop)
};
#pragma pack(pop)


typedef void __cdecl (*libvlc_event_callback_t)(libvlc_event_t_ptr p_event, void * data);

enum DECLSPEC_DENUM input_item_option_e : unsigned int { VLC_INPUT_OPTION_TRUSTED = 0x2, VLC_INPUT_OPTION_UNIQUE = 0x100 };

typedef void __fastcall (*libvlc_exit_callback_t)(void * data);

enum DECLSPEC_DENUM libvlc_log_level_t : unsigned int { LIBVLC_LOG_DEBUG, LIBVLC_LOG_NOTICE = 2, LIBVLC_LOG_WARNING, LIBVLC_LOG_ERROR };

typedef void __cdecl (*libvlc_log_cb)(void * data, int level, libvlc_log_t_ptr ctx, char * fmt, System::TVarRec *args, const int args_Size);

struct libvlc_module_description_t;
typedef libvlc_module_description_t *libvlc_module_description_t_ptr;

#pragma pack(push,1)
struct DECLSPEC_DRECORD libvlc_module_description_t
{
public:
	char *psz_name;
	char *psz_shortname;
	char *psz_longname;
	char *psz_help;
	libvlc_module_description_t *p_next;
};
#pragma pack(pop)


typedef void * __cdecl (*libvlc_video_lock_cb)(void * opaque, void * &planes);

typedef void * __cdecl (*libvlc_video_unlock_cb)(void * opaque, void * picture, void * planes);

typedef void * __cdecl (*libvlc_video_display_cb)(void * opaque, void * picture);

typedef void __cdecl (*libvlc_video_format_cb)(void * &opaque, char * chroma, unsigned &width, unsigned &height, unsigned &pitches, unsigned &lines);

typedef void __cdecl (*libvlc_video_cleanup_cb)(void * opaque);

typedef void __cdecl (*libvlc_audio_play_cb)(void * data, const void * samples, unsigned count, __int64 pts);

typedef void __cdecl (*libvlc_audio_pause_cb)(void * data, __int64 pts);

typedef void __cdecl (*libvlc_audio_resume_cb)(void * data, __int64 pts);

typedef void __cdecl (*libvlc_audio_flush_cb)(void * data, __int64 pts);

typedef void __fastcall (*libvlc_audio_drain_cb)(void * data);

typedef void __fastcall (*libvlc_audio_set_volume_cb)(void * data, float volume, bool mute);

typedef int __cdecl (*libvlc_audio_setup_cb)(void * &data, char * &format, unsigned &rate, unsigned &channels);

typedef void __cdecl (*libvlc_audio_cleanup_cb)(void * data);

enum DECLSPEC_DENUM libvlc_video_adjust_option_t : unsigned int { libvlc_adjust_Enable, libvlc_adjust_Contrast, libvlc_adjust_Brightness, libvlc_adjust_Hue, libvlc_adjust_Saturation, libvlc_adjust_Gamma };

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::UnicodeString libvlc_dynamic_dll_path;
extern DELPHI_PACKAGE System::UnicodeString libvlc_dynamic_dll_file;
extern DELPHI_PACKAGE System::UnicodeString libvlc_dynamic_dll_version;
extern DELPHI_PACKAGE unsigned libvlc_dynamic_dll_version_bin;
extern DELPHI_PACKAGE System::UnicodeString libvlc_dynamic_dll_error;
static const System::Int8 libvlc_media_option_trusted = System::Int8(0x2);
static const System::Word libvlc_media_option_unique = System::Word(0x100);
static const System::Int8 libvlc_opacity_None = System::Int8(0x0);
static const System::Byte libvlc_opacity_Medium = System::Byte(0x80);
static const System::Byte libvlc_opacity_Full = System::Byte(0xff);
static const unsigned libvlc_video_marquee_color_Default = unsigned(0xf0000000);
static const System::Int8 libvlc_video_marquee_color_Black = System::Int8(0x0);
static const int libvlc_video_marquee_color_Gray = int(0x808080);
static const int libvlc_video_marquee_color_Silver = int(0xc0c0c0);
static const int libvlc_video_marquee_color_White = int(0xffffff);
static const int libvlc_video_marquee_color_Maroon = int(0x800000);
static const int libvlc_video_marquee_color_Red = int(0xff0000);
static const int libvlc_video_marquee_color_Fuchsia = int(0xff00ff);
static const int libvlc_video_marquee_color_Yellow = int(0xffff00);
static const int libvlc_video_marquee_color_Olive = int(0x808000);
static const System::Word libvlc_video_marquee_color_Green = System::Word(0x8000);
static const System::Word libvlc_video_marquee_color_Teal = System::Word(0x8080);
static const System::Word libvlc_video_marquee_color_Lime = System::Word(0xff00);
static const int libvlc_video_marquee_color_Purple = int(0x800080);
static const System::Byte libvlc_video_marquee_color_Navy = System::Byte(0x80);
static const System::Byte libvlc_video_marquee_color_Blue = System::Byte(0xff);
static const System::Word libvlc_video_marquee_color_Aqua = System::Word(0xffff);
static const System::Int8 libvlc_video_marquee_default_font_size = System::Int8(0xc);
extern DELPHI_PACKAGE char * __cdecl (*libvlc_errmsg)(void);
extern DELPHI_PACKAGE void __cdecl (*libvlc_clearerr)(void);
extern DELPHI_PACKAGE char * __cdecl (*libvlc_vprinterr)(char * fmt, System::TVarRec *ap, const int ap_Size);
extern DELPHI_PACKAGE char * __cdecl (*libvlc_printerr)(char * fmt, System::TVarRec *arg, const int arg_Size);
extern DELPHI_PACKAGE libvlc_instance_t_ptr __cdecl (*libvlc_new)(int argc, System::PPAnsiChar args);
extern DELPHI_PACKAGE void __cdecl (*libvlc_release)(libvlc_instance_t_ptr p_instance);
extern DELPHI_PACKAGE void __cdecl (*libvlc_retain)(libvlc_instance_t_ptr p_instance);
extern DELPHI_PACKAGE int __cdecl (*libvlc_add_intf)(libvlc_instance_t_ptr p_instance, char * name);
extern DELPHI_PACKAGE void __cdecl (*libvlc_set_exit_handler)(libvlc_instance_t_ptr p_instance, libvlc_exit_callback_t cb, void * opaque);
extern DELPHI_PACKAGE void __cdecl (*libvlc_wait)(libvlc_instance_t_ptr p_instance);
extern DELPHI_PACKAGE void __cdecl (*libvlc_set_user_agent)(libvlc_instance_t_ptr p_instance, char * name, char * http);
extern DELPHI_PACKAGE void __cdecl (*libvlc_set_app_id)(libvlc_instance_t_ptr p_instance, char * id, char * version, char * icon);
extern DELPHI_PACKAGE char * __cdecl (*libvlc_get_version)(void);
extern DELPHI_PACKAGE char * __cdecl (*libvlc_get_compiler)(void);
extern DELPHI_PACKAGE char * __cdecl (*libvlc_get_changeset)(void);
extern DELPHI_PACKAGE void __cdecl (*libvlc_free)(void * ptr);
extern DELPHI_PACKAGE int __cdecl (*libvlc_event_attach)(libvlc_event_manager_t_ptr p_event_manager, libvlc_event_type_t i_event_type, libvlc_event_callback_t f_callback, void * user_data);
extern DELPHI_PACKAGE void __cdecl (*libvlc_event_detach)(libvlc_event_manager_t_ptr p_event_manager, libvlc_event_type_t i_event_type, libvlc_event_callback_t f_callback, void * p_user_data);
extern DELPHI_PACKAGE char * __cdecl (*libvlc_event_type_name)(libvlc_event_type_t event_type);
extern DELPHI_PACKAGE void __cdecl (*libvlc_log_get_context)(libvlc_log_t_ptr ctx, char * &module, char * &file_name, unsigned &line);
extern DELPHI_PACKAGE void __cdecl (*libvlc_log_get_object)(libvlc_log_t_ptr ctx, char * &name, char * &header, void * &id);
extern DELPHI_PACKAGE void __cdecl (*libvlc_log_unset)(libvlc_instance_t_ptr p_instance);
extern DELPHI_PACKAGE void __cdecl (*libvlc_log_set)(libvlc_instance_t_ptr p_instance, libvlc_log_cb cb, void * data);
extern DELPHI_PACKAGE void __cdecl (*libvlc_log_set_file)(libvlc_instance_t_ptr p_instance, NativeUInt stream);
extern DELPHI_PACKAGE unsigned __cdecl (*libvlc_get_log_verbosity)(libvlc_instance_t_ptr p_instance);
extern DELPHI_PACKAGE void __cdecl (*libvlc_set_log_verbosity)(libvlc_instance_t_ptr p_instance, unsigned level);
extern DELPHI_PACKAGE libvlc_log_t_ptr __cdecl (*libvlc_log_open)(libvlc_instance_t_ptr p_instance);
extern DELPHI_PACKAGE void __cdecl (*libvlc_log_close)(libvlc_log_t_ptr p_log);
extern DELPHI_PACKAGE unsigned __cdecl (*libvlc_log_count)(libvlc_log_t_ptr p_log);
extern DELPHI_PACKAGE void __cdecl (*libvlc_log_clear)(libvlc_log_t_ptr p_log);
extern DELPHI_PACKAGE libvlc_log_iterator_t_ptr __cdecl (*libvlc_log_get_iterator)(libvlc_log_t_ptr p_log);
extern DELPHI_PACKAGE void __cdecl (*libvlc_log_iterator_free)(libvlc_log_t_ptr p_log);
extern DELPHI_PACKAGE int __cdecl (*libvlc_log_iterator_has_next)(libvlc_log_iterator_t_ptr p_iter);
extern DELPHI_PACKAGE libvlc_log_message_t_ptr __cdecl (*libvlc_log_iterator_next)(libvlc_log_iterator_t_ptr p_iter, libvlc_log_message_t_ptr p_buffer);
extern DELPHI_PACKAGE void __cdecl (*libvlc_module_description_list_release)(libvlc_module_description_t_ptr p_list);
extern DELPHI_PACKAGE libvlc_module_description_t_ptr __cdecl (*libvlc_audio_filter_list_get)(libvlc_instance_t_ptr p_instance);
extern DELPHI_PACKAGE libvlc_module_description_t_ptr __cdecl (*libvlc_video_filter_list_get)(libvlc_instance_t_ptr p_instance);
extern DELPHI_PACKAGE __int64 __cdecl (*libvlc_clock)(void);
extern DELPHI_PACKAGE libvlc_media_t_ptr __cdecl (*libvlc_media_new_location)(libvlc_instance_t_ptr p_instance, char * psz_mrl);
extern DELPHI_PACKAGE libvlc_media_t_ptr __cdecl (*libvlc_media_new_path)(libvlc_instance_t_ptr p_instance, char * path);
extern DELPHI_PACKAGE libvlc_media_t_ptr __cdecl (*libvlc_media_new_fd)(libvlc_instance_t_ptr p_instance, int fd);
extern DELPHI_PACKAGE libvlc_media_t_ptr __cdecl (*libvlc_media_new_as_node)(libvlc_instance_t_ptr p_instance, char * psz_name);
extern DELPHI_PACKAGE void __cdecl (*libvlc_media_add_option)(libvlc_media_t_ptr p_md, char * ppsz_options);
extern DELPHI_PACKAGE void __cdecl (*libvlc_media_add_option_flag)(libvlc_media_t_ptr p_md, char * ppsz_options, input_item_option_e i_flags);
extern DELPHI_PACKAGE void __cdecl (*libvlc_media_retain)(libvlc_media_t_ptr p_md);
extern DELPHI_PACKAGE void __cdecl (*libvlc_media_release)(libvlc_media_t_ptr p_md);
extern DELPHI_PACKAGE char * __cdecl (*libvlc_media_get_mrl)(libvlc_media_t_ptr p_md);
extern DELPHI_PACKAGE libvlc_media_t_ptr __cdecl (*libvlc_media_duplicate)(libvlc_media_t_ptr p_md);
extern DELPHI_PACKAGE char * __cdecl (*libvlc_media_get_meta)(libvlc_media_t_ptr p_md, libvlc_meta_t e_meta);
extern DELPHI_PACKAGE void __cdecl (*libvlc_media_set_meta)(libvlc_media_t_ptr p_md, libvlc_meta_t e_meta, char * psz_value);
extern DELPHI_PACKAGE int __cdecl (*libvlc_media_save_meta)(libvlc_media_t_ptr p_md);
extern DELPHI_PACKAGE libvlc_state_t __cdecl (*libvlc_media_get_state)(libvlc_media_t_ptr p_md);
extern DELPHI_PACKAGE int __cdecl (*libvlc_media_get_stats)(libvlc_media_t_ptr p_md, libvlc_media_stats_t_ptr p_stats);
extern DELPHI_PACKAGE libvlc_media_list_t_ptr __cdecl (*libvlc_media_subitems)(libvlc_media_t_ptr p_md);
extern DELPHI_PACKAGE libvlc_event_manager_t_ptr __cdecl (*libvlc_media_event_manager)(libvlc_media_t_ptr p_md);
extern DELPHI_PACKAGE __int64 __cdecl (*libvlc_media_get_duration)(libvlc_media_t_ptr p_md);
extern DELPHI_PACKAGE void __cdecl (*libvlc_media_parse)(libvlc_media_t_ptr p_md);
extern DELPHI_PACKAGE void __cdecl (*libvlc_media_parse_async)(libvlc_media_t_ptr p_md);
extern DELPHI_PACKAGE int __cdecl (*libvlc_media_is_parsed)(libvlc_media_t_ptr p_md);
extern DELPHI_PACKAGE void __cdecl (*libvlc_media_set_user_data)(libvlc_media_t_ptr p_md, void * p_new_user_data);
extern DELPHI_PACKAGE void * __cdecl (*libvlc_media_get_user_data)(libvlc_media_t_ptr p_md);
extern DELPHI_PACKAGE int __cdecl (*libvlc_media_get_tracks_info)(libvlc_media_t_ptr p_md, libvlc_media_track_info_t_ptr &tracks);
extern DELPHI_PACKAGE unsigned __cdecl (*libvlc_media_tracks_get)(libvlc_media_t_ptr p_md, void * &tracks);
extern DELPHI_PACKAGE void __cdecl (*libvlc_media_tracks_release)(void * &tracks, unsigned i_count);
extern DELPHI_PACKAGE libvlc_media_player_t_ptr __cdecl (*libvlc_media_player_new)(libvlc_instance_t_ptr p_instance);
extern DELPHI_PACKAGE libvlc_media_player_t_ptr __cdecl (*libvlc_media_player_new_from_media)(libvlc_media_t_ptr p_md);
extern DELPHI_PACKAGE void __cdecl (*libvlc_media_player_release)(libvlc_media_player_t_ptr p_mi);
extern DELPHI_PACKAGE void __cdecl (*libvlc_media_player_retain)(libvlc_media_player_t_ptr p_mi);
extern DELPHI_PACKAGE void __cdecl (*libvlc_media_player_set_media)(libvlc_media_player_t_ptr p_mi, libvlc_media_t_ptr p_md);
extern DELPHI_PACKAGE libvlc_media_t_ptr __cdecl (*libvlc_media_player_get_media)(libvlc_media_player_t_ptr p_mi);
extern DELPHI_PACKAGE libvlc_event_manager_t_ptr __cdecl (*libvlc_media_player_event_manager)(libvlc_media_player_t_ptr p_mi);
extern DELPHI_PACKAGE int __cdecl (*libvlc_media_player_is_playing)(libvlc_media_player_t_ptr p_mi);
extern DELPHI_PACKAGE int __cdecl (*libvlc_media_player_play)(libvlc_media_player_t_ptr p_mi);
extern DELPHI_PACKAGE void __cdecl (*libvlc_media_player_set_pause)(libvlc_media_player_t_ptr p_mi, int do_pause);
extern DELPHI_PACKAGE void __cdecl (*libvlc_media_player_pause)(libvlc_media_player_t_ptr p_mi);
extern DELPHI_PACKAGE void __cdecl (*libvlc_media_player_stop)(libvlc_media_player_t_ptr p_mi);
extern DELPHI_PACKAGE void __cdecl (*libvlc_video_set_callbacks)(libvlc_media_player_t_ptr p_mi, libvlc_video_lock_cb lock, libvlc_video_unlock_cb unlock, libvlc_video_display_cb display, void * opaque);
extern DELPHI_PACKAGE void __cdecl (*libvlc_video_set_format)(libvlc_media_player_t_ptr p_mi, char * chroma, unsigned width, unsigned height, unsigned pitch);
extern DELPHI_PACKAGE void __cdecl (*libvlc_video_set_format_callbacks)(libvlc_media_player_t_ptr p_mi, libvlc_video_format_cb setup, libvlc_video_cleanup_cb cleanup);
extern DELPHI_PACKAGE void __cdecl (*libvlc_media_player_set_nsobject)(libvlc_media_player_t_ptr p_mi, void * drawable);
extern DELPHI_PACKAGE void * __cdecl (*libvlc_media_player_get_nsobject)(libvlc_media_player_t_ptr p_mi);
extern DELPHI_PACKAGE void __cdecl (*libvlc_media_player_set_agl)(libvlc_media_player_t_ptr p_mi, unsigned drawable);
extern DELPHI_PACKAGE unsigned __cdecl (*libvlc_media_player_get_agl)(libvlc_media_player_t_ptr p_mi);
extern DELPHI_PACKAGE void __cdecl (*libvlc_media_player_set_xwindow)(libvlc_media_player_t_ptr p_mi, unsigned drawable);
extern DELPHI_PACKAGE unsigned __cdecl (*libvlc_media_player_get_xwindow)(libvlc_media_player_t_ptr p_mi);
extern DELPHI_PACKAGE void __cdecl (*libvlc_media_player_set_hwnd)(libvlc_media_player_t_ptr p_mi, NativeUInt hwnd);
extern DELPHI_PACKAGE NativeUInt __cdecl (*libvlc_media_player_get_hwnd)(libvlc_media_player_t_ptr p_mi);
extern DELPHI_PACKAGE void __cdecl (*libvlc_audio_set_callbacks)(libvlc_media_player_t_ptr p_mi, libvlc_audio_play_cb play, libvlc_audio_pause_cb pause, libvlc_audio_resume_cb resume, libvlc_audio_flush_cb flush, libvlc_audio_drain_cb drain, void * opaque);
extern DELPHI_PACKAGE void __cdecl (*libvlc_audio_set_volume_callback)(libvlc_media_player_t_ptr p_mi, libvlc_audio_set_volume_cb set_volume);
extern DELPHI_PACKAGE void __cdecl (*libvlc_audio_set_format_callbacks)(libvlc_media_player_t_ptr p_mi, libvlc_audio_setup_cb setup, libvlc_audio_cleanup_cb cleanup);
extern DELPHI_PACKAGE void __cdecl (*libvlc_audio_set_format)(libvlc_media_player_t_ptr p_mp, const char * format, unsigned rate, unsigned channels);
extern DELPHI_PACKAGE __int64 __cdecl (*libvlc_media_player_get_length)(libvlc_media_player_t_ptr p_mi);
extern DELPHI_PACKAGE __int64 __cdecl (*libvlc_media_player_get_time)(libvlc_media_player_t_ptr p_mi);
extern DELPHI_PACKAGE void __cdecl (*libvlc_media_player_set_time)(libvlc_media_player_t_ptr p_mi, __int64 i_time);
extern DELPHI_PACKAGE float __cdecl (*libvlc_media_player_get_position)(libvlc_media_player_t_ptr p_mi);
extern DELPHI_PACKAGE void __cdecl (*libvlc_media_player_set_position)(libvlc_media_player_t_ptr p_mi, float f_pos);
extern DELPHI_PACKAGE void __cdecl (*libvlc_media_player_set_chapter)(libvlc_media_player_t_ptr p_mi, int i_chapter);
extern DELPHI_PACKAGE int __cdecl (*libvlc_media_player_get_chapter)(libvlc_media_player_t_ptr p_mi);
extern DELPHI_PACKAGE int __cdecl (*libvlc_media_player_get_chapter_count)(libvlc_media_player_t_ptr p_mi);
extern DELPHI_PACKAGE int __cdecl (*libvlc_media_player_will_play)(libvlc_media_player_t_ptr p_mi);
extern DELPHI_PACKAGE int __cdecl (*libvlc_media_player_get_chapter_count_for_title)(libvlc_media_player_t_ptr p_mi, int i_title);
extern DELPHI_PACKAGE void __cdecl (*libvlc_media_player_set_title)(libvlc_media_player_t_ptr p_mi, int i_title);
extern DELPHI_PACKAGE int __cdecl (*libvlc_media_player_get_title)(libvlc_media_player_t_ptr p_mi);
extern DELPHI_PACKAGE int __cdecl (*libvlc_media_player_get_title_count)(libvlc_media_player_t_ptr p_mi);
extern DELPHI_PACKAGE void __cdecl (*libvlc_media_player_previous_chapter)(libvlc_media_player_t_ptr p_mi);
extern DELPHI_PACKAGE void __cdecl (*libvlc_media_player_next_chapter)(libvlc_media_player_t_ptr p_mi);
extern DELPHI_PACKAGE float __cdecl (*libvlc_media_player_get_rate)(libvlc_media_player_t_ptr p_mi);
extern DELPHI_PACKAGE int __cdecl (*libvlc_media_player_set_rate)(libvlc_media_player_t_ptr p_mi, float rate);
extern DELPHI_PACKAGE libvlc_state_t __cdecl (*libvlc_media_player_get_state)(libvlc_media_player_t_ptr p_mi);
extern DELPHI_PACKAGE float __cdecl (*libvlc_media_player_get_fps)(libvlc_media_player_t_ptr p_mi);
extern DELPHI_PACKAGE unsigned __cdecl (*libvlc_media_player_has_vout)(libvlc_media_player_t_ptr p_mi);
extern DELPHI_PACKAGE int __cdecl (*libvlc_media_player_is_seekable)(libvlc_media_player_t_ptr p_mi);
extern DELPHI_PACKAGE int __cdecl (*libvlc_media_player_can_pause)(libvlc_media_player_t_ptr p_mi);
extern DELPHI_PACKAGE int __cdecl (*libvlc_media_player_program_scrambled)(libvlc_media_player_t_ptr p_mi);
extern DELPHI_PACKAGE void __cdecl (*libvlc_media_player_next_frame)(libvlc_media_player_t_ptr p_mi);
extern DELPHI_PACKAGE void __cdecl (*libvlc_media_player_navigate)(libvlc_media_player_t_ptr p_mi, libvlc_navigate_mode_t navigate);
extern DELPHI_PACKAGE void __cdecl (*libvlc_media_player_set_video_title_display)(libvlc_media_player_t_ptr p_mi, libvlc_position_t position, unsigned timeout);
extern DELPHI_PACKAGE void __cdecl (*libvlc_track_description_list_release)(libvlc_track_description_t_ptr p_track_description);
extern DELPHI_PACKAGE void __cdecl (*libvlc_track_description_release)(libvlc_track_description_t_ptr p_track_description);
extern DELPHI_PACKAGE void __cdecl (*libvlc_toggle_fullscreen)(libvlc_media_player_t_ptr p_mi);
extern DELPHI_PACKAGE void __cdecl (*libvlc_set_fullscreen)(libvlc_media_player_t_ptr p_mi, int b_fullscreen);
extern DELPHI_PACKAGE int __cdecl (*libvlc_get_fullscreen)(libvlc_media_player_t_ptr p_mi);
extern DELPHI_PACKAGE void __cdecl (*libvlc_video_set_key_input)(libvlc_media_player_t_ptr p_mi, unsigned keys_on);
extern DELPHI_PACKAGE void __cdecl (*libvlc_video_set_mouse_input)(libvlc_media_player_t_ptr p_mi, unsigned mouse_on);
extern DELPHI_PACKAGE int __cdecl (*libvlc_video_get_size)(libvlc_media_player_t_ptr p_mi, unsigned num, unsigned &px, unsigned &py);
extern DELPHI_PACKAGE int __cdecl (*libvlc_video_get_cursor)(libvlc_media_player_t_ptr p_mi, unsigned num, int &px, int &py);
extern DELPHI_PACKAGE float __cdecl (*libvlc_video_get_scale)(libvlc_media_player_t_ptr p_mi);
extern DELPHI_PACKAGE void __cdecl (*libvlc_video_set_scale)(libvlc_media_player_t_ptr p_mi, float f_factor);
extern DELPHI_PACKAGE char * __cdecl (*libvlc_video_get_aspect_ratio)(libvlc_media_player_t_ptr p_mi);
extern DELPHI_PACKAGE void __cdecl (*libvlc_video_set_aspect_ratio)(libvlc_media_player_t_ptr p_mi, char * psz_aspect);
extern DELPHI_PACKAGE int __cdecl (*libvlc_video_get_spu)(libvlc_media_player_t_ptr p_mi);
extern DELPHI_PACKAGE int __cdecl (*libvlc_video_get_spu_count)(libvlc_media_player_t_ptr p_mi);
extern DELPHI_PACKAGE libvlc_track_description_t_ptr __cdecl (*libvlc_video_get_spu_description)(libvlc_media_player_t_ptr p_mi);
extern DELPHI_PACKAGE int __cdecl (*libvlc_video_set_spu)(libvlc_media_player_t_ptr p_mi, int i_spu);
extern DELPHI_PACKAGE int __cdecl (*libvlc_video_set_subtitle_file)(libvlc_media_player_t_ptr p_mi, char * psz_subtitle);
extern DELPHI_PACKAGE __int64 __cdecl (*libvlc_video_get_spu_delay)(libvlc_media_player_t_ptr p_mi);
extern DELPHI_PACKAGE int __cdecl (*libvlc_video_set_spu_delay)(libvlc_media_player_t_ptr p_mi, __int64 i_delay);
extern DELPHI_PACKAGE libvlc_track_description_t_ptr __cdecl (*libvlc_video_get_title_description)(libvlc_media_player_t_ptr p_mi);
extern DELPHI_PACKAGE libvlc_track_description_t_ptr __cdecl (*libvlc_video_get_chapter_description)(libvlc_media_player_t_ptr p_mi, int i_title);
extern DELPHI_PACKAGE char * __cdecl (*libvlc_video_get_crop_geometry)(libvlc_media_player_t_ptr p_mi);
extern DELPHI_PACKAGE void __cdecl (*libvlc_video_set_crop_geometry)(libvlc_media_player_t_ptr p_mi, char * psz_geometry);
extern DELPHI_PACKAGE int __cdecl (*libvlc_video_get_teletext)(libvlc_media_player_t_ptr p_mi);
extern DELPHI_PACKAGE void __cdecl (*libvlc_video_set_teletext)(libvlc_media_player_t_ptr p_mi, int i_page);
extern DELPHI_PACKAGE void __cdecl (*libvlc_toggle_teletext)(libvlc_media_player_t_ptr p_mi);
extern DELPHI_PACKAGE int __cdecl (*libvlc_video_get_track_count)(libvlc_media_player_t_ptr p_mi);
extern DELPHI_PACKAGE libvlc_track_description_t_ptr __cdecl (*libvlc_video_get_track_description)(libvlc_media_player_t_ptr p_mi);
extern DELPHI_PACKAGE int __cdecl (*libvlc_video_get_track)(libvlc_media_player_t_ptr p_mi);
extern DELPHI_PACKAGE int __cdecl (*libvlc_video_set_track)(libvlc_media_player_t_ptr p_mi, int i_track);
extern DELPHI_PACKAGE int __cdecl (*libvlc_video_take_snapshot)(libvlc_media_player_t_ptr p_mi, int num, char * psz_filepath, unsigned i_width, unsigned i_height);
extern DELPHI_PACKAGE void __cdecl (*libvlc_video_set_deinterlace)(libvlc_media_player_t_ptr p_mi, char * psz_mode);
extern DELPHI_PACKAGE int __cdecl (*libvlc_video_get_marquee_int)(libvlc_media_player_t_ptr p_mi, libvlc_video_marquee_option_t option);
extern DELPHI_PACKAGE char * __cdecl (*libvlc_video_get_marquee_string)(libvlc_media_player_t_ptr p_mi, libvlc_video_marquee_option_t option);
extern DELPHI_PACKAGE void __cdecl (*libvlc_video_set_marquee_int)(libvlc_media_player_t_ptr p_mi, libvlc_video_marquee_option_t option, int i_val);
extern DELPHI_PACKAGE void __cdecl (*libvlc_video_set_marquee_string)(libvlc_media_player_t_ptr p_mi, libvlc_video_marquee_option_t option, char * psz_text);
extern DELPHI_PACKAGE int __cdecl (*libvlc_video_get_logo_int)(libvlc_media_player_t_ptr p_mi, libvlc_video_logo_option_t option);
extern DELPHI_PACKAGE void __cdecl (*libvlc_video_set_logo_int)(libvlc_media_player_t_ptr p_mi, libvlc_video_logo_option_t option, int value);
extern DELPHI_PACKAGE void __cdecl (*libvlc_video_set_logo_string)(libvlc_media_player_t_ptr p_mi, libvlc_video_logo_option_t option, char * psz_value);
extern DELPHI_PACKAGE int __cdecl (*libvlc_video_get_adjust_int)(libvlc_media_player_t_ptr p_mi, unsigned option);
extern DELPHI_PACKAGE void __cdecl (*libvlc_video_set_adjust_int)(libvlc_media_player_t_ptr p_mi, unsigned option, int value);
extern DELPHI_PACKAGE float __cdecl (*libvlc_video_get_adjust_float)(libvlc_media_player_t_ptr p_mi, unsigned option);
extern DELPHI_PACKAGE void __cdecl (*libvlc_video_set_adjust_float)(libvlc_media_player_t_ptr p_mi, unsigned option, float value);
extern DELPHI_PACKAGE libvlc_audio_output_t_ptr __cdecl (*libvlc_audio_output_list_get)(libvlc_instance_t_ptr p_instance);
extern DELPHI_PACKAGE void __cdecl (*libvlc_audio_output_list_release)(libvlc_audio_output_t_ptr p_list);
extern DELPHI_PACKAGE int __cdecl (*libvlc_audio_output_set)(libvlc_media_player_t_ptr p_mi, char * psz_name);
extern DELPHI_PACKAGE libvlc_audio_output_device_t_ptr __cdecl (*libvlc_audio_output_device_enum)(libvlc_media_player_t_ptr p_mi);
extern DELPHI_PACKAGE libvlc_audio_output_device_t_ptr __cdecl (*libvlc_audio_output_device_list_get)(libvlc_instance_t_ptr p_instance, char * aout);
extern DELPHI_PACKAGE void __cdecl (*libvlc_audio_output_device_list_release)(libvlc_audio_output_device_t_ptr p_list);
extern DELPHI_PACKAGE void __cdecl (*libvlc_audio_output_device_set)(libvlc_media_player_t_ptr p_mi, char * psz_audio_output, char * psz_device_id);
extern DELPHI_PACKAGE libvlc_audio_output_device_types_t __cdecl (*libvlc_audio_output_get_device_type)(libvlc_media_player_t_ptr p_mi);
extern DELPHI_PACKAGE void __cdecl (*libvlc_audio_output_set_device_type)(libvlc_media_player_t_ptr p_mi, libvlc_audio_output_device_types_t device_type);
extern DELPHI_PACKAGE void __cdecl (*libvlc_audio_toggle_mute)(libvlc_media_player_t_ptr p_mi);
extern DELPHI_PACKAGE int __cdecl (*libvlc_audio_get_mute)(libvlc_media_player_t_ptr p_mi);
extern DELPHI_PACKAGE void __cdecl (*libvlc_audio_set_mute)(libvlc_media_player_t_ptr p_mi, int status);
extern DELPHI_PACKAGE int __cdecl (*libvlc_audio_get_volume)(libvlc_media_player_t_ptr p_mi);
extern DELPHI_PACKAGE int __cdecl (*libvlc_audio_set_volume)(libvlc_media_player_t_ptr p_mi, int i_volume);
extern DELPHI_PACKAGE int __cdecl (*libvlc_audio_get_track_count)(libvlc_media_player_t_ptr p_mi);
extern DELPHI_PACKAGE libvlc_track_description_t_ptr __cdecl (*libvlc_audio_get_track_description)(libvlc_media_player_t_ptr p_mi);
extern DELPHI_PACKAGE int __cdecl (*libvlc_audio_get_track)(libvlc_media_player_t_ptr p_mi);
extern DELPHI_PACKAGE int __cdecl (*libvlc_audio_set_track)(libvlc_media_player_t_ptr p_mi, int i_track);
extern DELPHI_PACKAGE libvlc_audio_output_channel_t __cdecl (*libvlc_audio_get_channel)(libvlc_media_player_t_ptr p_mi);
extern DELPHI_PACKAGE int __cdecl (*libvlc_audio_set_channel)(libvlc_media_player_t_ptr p_mi, libvlc_audio_output_channel_t i_channel);
extern DELPHI_PACKAGE __int64 __cdecl (*libvlc_audio_get_delay)(libvlc_media_player_t_ptr p_mi);
extern DELPHI_PACKAGE int __cdecl (*libvlc_audio_set_delay)(libvlc_media_player_t_ptr p_mi, __int64 i_delay);
extern DELPHI_PACKAGE System::Word __cdecl (*libvlc_audio_equalizer_get_preset_count)(void);
extern DELPHI_PACKAGE char * __cdecl (*libvlc_audio_equalizer_get_preset_name)(System::Word u_index);
extern DELPHI_PACKAGE System::Word __cdecl (*libvlc_audio_equalizer_get_band_count)(void);
extern DELPHI_PACKAGE float __cdecl (*libvlc_audio_equalizer_get_band_frequency)(System::Word u_index);
extern DELPHI_PACKAGE void * __cdecl (*libvlc_audio_equalizer_new)(void);
extern DELPHI_PACKAGE void * __cdecl (*libvlc_audio_equalizer_new_from_preset)(System::Word u_index);
extern DELPHI_PACKAGE void __cdecl (*libvlc_audio_equalizer_release)(void * p_equalizer);
extern DELPHI_PACKAGE int __cdecl (*libvlc_audio_equalizer_set_preamp)(void * p_equalizer, float f_preamp);
extern DELPHI_PACKAGE float __cdecl (*libvlc_audio_equalizer_get_preamp)(void * p_equalizer);
extern DELPHI_PACKAGE int __cdecl (*libvlc_audio_equalizer_set_amp_at_index)(void * p_equalizer, float f_amp, System::Word u_band);
extern DELPHI_PACKAGE float __cdecl (*libvlc_audio_equalizer_get_amp_at_index)(void * p_equalizer, System::Word u_band);
extern DELPHI_PACKAGE int __cdecl (*libvlc_media_player_set_equalizer)(libvlc_media_player_t_ptr p_mi, void * p_equalizer);
extern DELPHI_PACKAGE libvlc_media_list_t_ptr __cdecl (*libvlc_media_list_new)(libvlc_instance_t_ptr p_instance);
extern DELPHI_PACKAGE void __cdecl (*libvlc_media_list_release)(libvlc_media_list_t_ptr p_ml);
extern DELPHI_PACKAGE void __cdecl (*libvlc_media_list_retain)(libvlc_media_list_t_ptr p_ml);
extern DELPHI_PACKAGE void __cdecl (*libvlc_media_list_set_media)(libvlc_media_list_t_ptr p_ml, libvlc_media_t_ptr p_md);
extern DELPHI_PACKAGE libvlc_media_t_ptr __cdecl (*libvlc_media_list_media)(libvlc_media_list_t_ptr p_ml);
extern DELPHI_PACKAGE int __cdecl (*libvlc_media_list_add_media)(libvlc_media_list_t_ptr p_ml, libvlc_media_t_ptr p_md);
extern DELPHI_PACKAGE int __cdecl (*libvlc_media_list_insert_media)(libvlc_media_list_t_ptr p_ml, libvlc_media_t_ptr p_md, int i_pos);
extern DELPHI_PACKAGE int __cdecl (*libvlc_media_list_remove_index)(libvlc_media_list_t_ptr p_ml, int i_pos);
extern DELPHI_PACKAGE int __cdecl (*libvlc_media_list_count)(libvlc_media_list_t_ptr p_ml);
extern DELPHI_PACKAGE libvlc_media_t_ptr __cdecl (*libvlc_media_list_item_at_index)(libvlc_media_list_t_ptr p_ml, int i_pos);
extern DELPHI_PACKAGE int __cdecl (*libvlc_media_list_index_of_item)(libvlc_media_list_t_ptr p_ml, libvlc_media_t_ptr p_md);
extern DELPHI_PACKAGE int __cdecl (*libvlc_media_list_is_readonly)(libvlc_media_list_t_ptr p_ml);
extern DELPHI_PACKAGE void __cdecl (*libvlc_media_list_lock)(libvlc_media_list_t_ptr p_ml);
extern DELPHI_PACKAGE void __cdecl (*libvlc_media_list_unlock)(libvlc_media_list_t_ptr p_ml);
extern DELPHI_PACKAGE libvlc_event_manager_t_ptr __cdecl (*libvlc_media_list_event_manager)(libvlc_media_list_t_ptr p_ml);
extern DELPHI_PACKAGE libvlc_media_list_player_t_ptr __cdecl (*libvlc_media_list_player_new)(libvlc_instance_t_ptr p_instance);
extern DELPHI_PACKAGE void __cdecl (*libvlc_media_list_player_release)(libvlc_media_list_player_t_ptr p_mlp);
extern DELPHI_PACKAGE void __cdecl (*libvlc_media_list_player_retain)(libvlc_media_list_player_t_ptr p_mlp);
extern DELPHI_PACKAGE libvlc_event_manager_t_ptr __cdecl (*libvlc_media_list_player_event_manager)(libvlc_media_list_player_t_ptr p_mlp);
extern DELPHI_PACKAGE void __cdecl (*libvlc_media_list_player_set_media_player)(libvlc_media_list_player_t_ptr p_mlp, libvlc_media_player_t_ptr p_mi);
extern DELPHI_PACKAGE void __cdecl (*libvlc_media_list_player_set_media_list)(libvlc_media_list_player_t_ptr p_mlp, libvlc_media_list_t_ptr p_mlist);
extern DELPHI_PACKAGE void __cdecl (*libvlc_media_list_player_play)(libvlc_media_list_player_t_ptr p_mlp);
extern DELPHI_PACKAGE void __cdecl (*libvlc_media_list_player_pause)(libvlc_media_list_player_t_ptr p_mlp);
extern DELPHI_PACKAGE int __cdecl (*libvlc_media_list_player_is_playing)(libvlc_media_list_player_t_ptr p_mlp);
extern DELPHI_PACKAGE libvlc_state_t __cdecl (*libvlc_media_list_player_get_state)(libvlc_media_list_player_t_ptr p_mlp);
extern DELPHI_PACKAGE int __cdecl (*libvlc_media_list_player_play_item_at_index)(libvlc_media_list_player_t_ptr p_mlp, int i_index);
extern DELPHI_PACKAGE int __cdecl (*libvlc_media_list_player_play_item)(libvlc_media_list_player_t_ptr p_mlp, libvlc_media_t_ptr p_md);
extern DELPHI_PACKAGE void __cdecl (*libvlc_media_list_player_stop)(libvlc_media_list_player_t_ptr p_mlp);
extern DELPHI_PACKAGE int __cdecl (*libvlc_media_list_player_next)(libvlc_media_list_player_t_ptr p_mlp);
extern DELPHI_PACKAGE int __cdecl (*libvlc_media_list_player_previous)(libvlc_media_list_player_t_ptr p_mlp);
extern DELPHI_PACKAGE void __cdecl (*libvlc_media_list_player_set_playback_mode)(libvlc_media_list_player_t_ptr p_mlp, libvlc_playback_mode_t e_mode);
extern DELPHI_PACKAGE libvlc_media_library_t_ptr __cdecl (*libvlc_media_library_new)(libvlc_instance_t_ptr p_instance);
extern DELPHI_PACKAGE void __cdecl (*libvlc_media_library_release)(libvlc_media_library_t_ptr p_mlib);
extern DELPHI_PACKAGE void __cdecl (*libvlc_media_library_retain)(libvlc_media_library_t_ptr p_mlib);
extern DELPHI_PACKAGE int __cdecl (*libvlc_media_library_load)(libvlc_media_library_t_ptr p_mlib);
extern DELPHI_PACKAGE libvlc_media_list_t_ptr __cdecl (*libvlc_media_library_media_list)(libvlc_media_library_t_ptr p_mlib);
extern DELPHI_PACKAGE libvlc_media_discoverer_t_ptr __cdecl (*libvlc_media_discoverer_new_from_name)(libvlc_instance_t_ptr p_inst, char * psz_name);
extern DELPHI_PACKAGE void __cdecl (*libvlc_media_discoverer_release)(libvlc_media_discoverer_t_ptr p_mdis);
extern DELPHI_PACKAGE char * __cdecl (*libvlc_media_discoverer_localized_name)(libvlc_media_discoverer_t_ptr p_mdis);
extern DELPHI_PACKAGE libvlc_media_list_t_ptr __cdecl (*libvlc_media_discoverer_media_list)(libvlc_media_discoverer_t_ptr p_mdis);
extern DELPHI_PACKAGE libvlc_event_manager_t_ptr __cdecl (*libvlc_media_discoverer_event_manager)(libvlc_media_discoverer_t_ptr p_mdis);
extern DELPHI_PACKAGE int __cdecl (*libvlc_media_discoverer_is_running)(libvlc_media_discoverer_t_ptr p_mdis);
extern DELPHI_PACKAGE void __cdecl (*libvlc_vlm_release)(libvlc_instance_t_ptr p_instance);
extern DELPHI_PACKAGE int __cdecl (*libvlc_vlm_add_broadcast)(libvlc_instance_t_ptr p_instance, char * psz_name, char * psz_input, char * psz_output, int i_options, System::PPAnsiChar ppsz_options, int b_enabled, int b_loop);
extern DELPHI_PACKAGE int __cdecl (*libvlc_vlm_add_vod)(libvlc_instance_t_ptr p_instance, char * psz_name, char * psz_input, int i_options, System::PPAnsiChar ppsz_options, int b_enabled, char * psz_mux);
extern DELPHI_PACKAGE int __cdecl (*libvlc_vlm_del_media)(libvlc_instance_t_ptr p_instance, char * psz_name);
extern DELPHI_PACKAGE int __cdecl (*libvlc_vlm_set_enabled)(libvlc_instance_t_ptr p_instance, char * psz_name, int b_enabled);
extern DELPHI_PACKAGE int __cdecl (*libvlc_vlm_set_output)(libvlc_instance_t_ptr p_instance, char * psz_name, char * psz_output);
extern DELPHI_PACKAGE int __cdecl (*libvlc_vlm_set_input)(libvlc_instance_t_ptr p_instance, char * psz_name, char * psz_input);
extern DELPHI_PACKAGE int __cdecl (*libvlc_vlm_add_input)(libvlc_instance_t_ptr p_instance, char * psz_name, char * psz_input);
extern DELPHI_PACKAGE int __cdecl (*libvlc_vlm_set_loop)(libvlc_instance_t_ptr p_instance, char * psz_name, int b_loop);
extern DELPHI_PACKAGE int __cdecl (*libvlc_vlm_set_mux)(libvlc_instance_t_ptr p_instance, char * psz_name, char * psz_mux);
extern DELPHI_PACKAGE int __cdecl (*libvlc_vlm_change_media)(libvlc_instance_t_ptr p_instance, char * psz_name, char * psz_input, char * psz_output, int i_options, System::PPAnsiChar ppsz_options, int b_enabled, int b_loop);
extern DELPHI_PACKAGE int __cdecl (*libvlc_vlm_play_media)(libvlc_instance_t_ptr p_instance, char * psz_name);
extern DELPHI_PACKAGE int __cdecl (*libvlc_vlm_stop_media)(libvlc_instance_t_ptr p_instance, char * psz_name);
extern DELPHI_PACKAGE int __cdecl (*libvlc_vlm_pause_media)(libvlc_instance_t_ptr p_instance, char * psz_name);
extern DELPHI_PACKAGE int __cdecl (*libvlc_vlm_seek_media)(libvlc_instance_t_ptr p_instance, char * psz_name, float f_percentage);
extern DELPHI_PACKAGE char * __cdecl (*libvlc_vlm_show_media)(libvlc_instance_t_ptr p_instance, char * psz_name);
extern DELPHI_PACKAGE float __cdecl (*libvlc_vlm_get_media_instance_position)(libvlc_instance_t_ptr p_instance, char * psz_name, int i_instance);
extern DELPHI_PACKAGE int __cdecl (*libvlc_vlm_get_media_instance_time)(libvlc_instance_t_ptr p_instance, char * psz_name, int i_instance);
extern DELPHI_PACKAGE int __cdecl (*libvlc_vlm_get_media_instance_length)(libvlc_instance_t_ptr p_instance, char * psz_name, int i_instance);
extern DELPHI_PACKAGE int __cdecl (*libvlc_vlm_get_media_instance_rate)(libvlc_instance_t_ptr p_instance, char * psz_name, int i_instance);
extern DELPHI_PACKAGE libvlc_event_manager_t_ptr __cdecl (*libvlc_vlm_get_event_manager)(libvlc_instance_t_ptr p_instance);
extern DELPHI_PACKAGE __int64 __fastcall libvlc_delay(__int64 pts);
extern DELPHI_PACKAGE unsigned __fastcall read_dec_number(char * &ptr);
extern DELPHI_PACKAGE void __fastcall libvlc_reset_function_pointers(bool force = false);
extern DELPHI_PACKAGE void __fastcall libvlc_dynamic_dll_init_with_path(System::UnicodeString vlc_install_path);
extern DELPHI_PACKAGE void __fastcall libvlc_dynamic_dll_init(void);
extern DELPHI_PACKAGE void __fastcall libvlc_dynamic_dll_done(void);
extern DELPHI_PACKAGE void __fastcall libvlc_media_player_set_display_window(libvlc_media_player_t_ptr p_mi, NativeUInt window_handle);
}	/* namespace Paslibvlcunit */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PASLIBVLCUNIT)
using namespace Paslibvlcunit;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PaslibvlcunitHPP
