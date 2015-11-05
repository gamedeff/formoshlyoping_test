// CodeGear C++Builder
// Copyright (c) 1995, 2012 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'PasLibVlcPlayerUnit.pas' rev: 24.00 (Windows)

#ifndef PaslibvlcplayerunitHPP
#define PaslibvlcplayerunitHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <Winapi.Messages.hpp>	// Pascal unit
#include <System.SyncObjs.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.ExtCtrls.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <PasLibVlcUnit.hpp>	// Pascal unit
#include <PasLibVlcClassUnit.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit
#include <Vcl.Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Paslibvlcplayerunit
{
//-- type declarations -------------------------------------------------------
typedef Winapi::Messages::TMessage TVlcMessage;

enum DECLSPEC_DENUM TPasLibVlcPlayerState : unsigned int { plvPlayer_NothingSpecial, plvPlayer_Opening, plvPlayer_Buffering, plvPlayer_Playing, plvPlayer_Paused, plvPlayer_Stopped, plvPlayer_Ended, plvPlayer_Error };

enum DECLSPEC_DENUM TPasLibVlcPlayerMouseEventsHandler : unsigned int { mehComponent, mehVideoLAN };

typedef void __fastcall (__closure *TNotifySeekableChanged)(System::TObject* Sender, bool val);

typedef void __fastcall (__closure *TNotifyPausableChanged)(System::TObject* Sender, bool val);

typedef void __fastcall (__closure *TNotifyTitleChanged)(System::TObject* Sender, int title);

typedef void __fastcall (__closure *TNotifySnapshotTaken)(System::TObject* Sender, System::UnicodeString fileName);

typedef void __fastcall (__closure *TNotifyTimeChanged)(System::TObject* Sender, __int64 time);

typedef void __fastcall (__closure *TNotifyLengthChanged)(System::TObject* Sender, __int64 time);

typedef void __fastcall (__closure *TNotifyPositionChanged)(System::TObject* Sender, float position);

typedef void __fastcall (__closure *TNotifyMediaChanged)(System::TObject* Sender, System::UnicodeString mrl);

typedef void __fastcall (__closure *TNotifyVideoOutChanged)(System::TObject* Sender, int video_out);

typedef void __fastcall (__closure *TNotifyScrambledChanged)(System::TObject* Sender, int scrambled);

typedef void __fastcall (__closure *TNotifyPlayerEvent)(Paslibvlcunit::libvlc_event_t_ptr p_event, void * data);

class DELPHICLASS TPasLibVlcPlayer;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TPasLibVlcPlayer : public Vcl::Extctrls::TCustomPanel
{
	typedef Vcl::Extctrls::TCustomPanel inherited;
	
private:
	Paslibvlcclassunit::TPasLibVlc* FVLC;
	void *p_mi;
	void *p_mi_ev_mgr;
	System::Syncobjs::TCriticalSection* FCS;
	System::UnicodeString FError;
	bool FMute;
	Paslibvlcclassunit::TVideoOutput FVideoOutput;
	Paslibvlcclassunit::TAudioOutput FAudioOutput;
	bool FTitleShow;
	Paslibvlcclassunit::TPasLibVlcTitlePosition FTitleShowPos;
	unsigned FTitleShowTimeOut;
	System::UnicodeString FSnapshotFmt;
	bool FSnapshotPrv;
	bool FVideoOnTop;
	bool FUseOverlay;
	bool FSpuShow;
	bool FOsdShow;
	bool FViewTeleText;
	Paslibvlcclassunit::TDeinterlaceFilter FDeinterlaceFilter;
	Paslibvlcclassunit::TDeinterlaceMode FDeinterlaceMode;
	TNotifyMediaChanged FOnMediaPlayerMediaChanged;
	System::Classes::TNotifyEvent FOnMediaPlayerNothingSpecial;
	System::Classes::TNotifyEvent FOnMediaPlayerOpening;
	System::Classes::TNotifyEvent FOnMediaPlayerBuffering;
	System::Classes::TNotifyEvent FOnMediaPlayerPlaying;
	System::Classes::TNotifyEvent FOnMediaPlayerPaused;
	System::Classes::TNotifyEvent FOnMediaPlayerStopped;
	System::Classes::TNotifyEvent FOnMediaPlayerForward;
	System::Classes::TNotifyEvent FOnMediaPlayerBackward;
	System::Classes::TNotifyEvent FOnMediaPlayerEndReached;
	System::Classes::TNotifyEvent FOnMediaPlayerEncounteredError;
	TNotifyTimeChanged FOnMediaPlayerTimeChanged;
	TNotifyPositionChanged FOnMediaPlayerPositionChanged;
	TNotifySeekableChanged FOnMediaPlayerSeekableChanged;
	TNotifyPausableChanged FOnMediaPlayerPausableChanged;
	TNotifyTitleChanged FOnMediaPlayerTitleChanged;
	TNotifySnapshotTaken FOnMediaPlayerSnapshotTaken;
	TNotifyLengthChanged FOnMediaPlayerLengthChanged;
	TNotifyVideoOutChanged FOnMediaPlayerVideoOutChanged;
	TNotifyScrambledChanged FOnMediaPlayerScrambledChanged;
	TNotifyPlayerEvent FOnMediaPlayerEvent;
	bool FUseEvents;
	Vcl::Controls::TWinControl* FPlayerWinCtrl;
	Paslibvlcclassunit::TPasLibVlcMouseEventWinCtrl* FMouseEventWinCtrl;
	TPasLibVlcPlayerMouseEventsHandler FMouseEventsHandler;
	System::Classes::TStringList* FStartOptions;
	Paslibvlcclassunit::TPasLibVlc* __fastcall GetVlcInstance(void);
	void __fastcall SetStartOptions(System::Classes::TStringList* Value);
	void __fastcall SetMouseEventHandler(TPasLibVlcPlayerMouseEventsHandler aValue);
	void __fastcall SetSnapshotFmt(System::UnicodeString aFormat);
	void __fastcall SetSnapshotPrv(bool aValue);
	void __fastcall SetSpuShow(bool aValue);
	void __fastcall SetOsdShow(bool aValue);
	void __fastcall SetVideoOnTop(bool aValue);
	void __fastcall SetUseOverlay(bool aValue);
	void __fastcall SetViewTeleText(bool aValue);
	void __fastcall UpdateTitleShow(void);
	void __fastcall SetTitleShow(bool aValue);
	void __fastcall SetTitleShowPos(Paslibvlcclassunit::TPasLibVlcTitlePosition aValue);
	void __fastcall SetTitleShowTimeOut(unsigned aValue);
	void __fastcall SetDeinterlaceFilter(Paslibvlcclassunit::TDeinterlaceFilter aValue);
	void __fastcall SetDeinterlaceMode(Paslibvlcclassunit::TDeinterlaceMode aValue);
	System::WideString __fastcall GetDeinterlaceModeName(void);
	void __fastcall UpdateDeInterlace(void);
	void __fastcall InternalOnClick(System::TObject* Sender);
	void __fastcall InternalOnDblClick(System::TObject* Sender);
	void __fastcall InternalOnMouseDown(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall InternalOnMouseMove(System::TObject* Sender, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall InternalOnMouseUp(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall InternalOnMouseActivate(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y, int HitTest, System::Uitypes::TMouseActivate &MouseActivate);
	void __fastcall InternalOnMouseEnter(System::TObject* Sender);
	void __fastcall InternalOnMouseLeave(System::TObject* Sender);
	MESSAGE void __fastcall WmMediaPlayerMediaChanged(Winapi::Messages::TMessage &m);
	MESSAGE void __fastcall WmMediaPlayerNothingSpecial(Winapi::Messages::TMessage &m);
	MESSAGE void __fastcall WmMediaPlayerOpening(Winapi::Messages::TMessage &m);
	MESSAGE void __fastcall WmMediaPlayerBuffering(Winapi::Messages::TMessage &m);
	MESSAGE void __fastcall WmMediaPlayerPlaying(Winapi::Messages::TMessage &m);
	MESSAGE void __fastcall WmMediaPlayerPaused(Winapi::Messages::TMessage &m);
	MESSAGE void __fastcall WmMediaPlayerStopped(Winapi::Messages::TMessage &m);
	MESSAGE void __fastcall WmMediaPlayerForward(Winapi::Messages::TMessage &m);
	MESSAGE void __fastcall WmMediaPlayerBackward(Winapi::Messages::TMessage &m);
	MESSAGE void __fastcall WmMediaPlayerEndReached(Winapi::Messages::TMessage &m);
	MESSAGE void __fastcall WmMediaPlayerEncounteredError(Winapi::Messages::TMessage &m);
	MESSAGE void __fastcall WmMediaPlayerTimeChanged(Winapi::Messages::TMessage &m);
	MESSAGE void __fastcall WmMediaPlayerPositionChanged(Winapi::Messages::TMessage &m);
	MESSAGE void __fastcall WmMediaPlayerSeekableChanged(Winapi::Messages::TMessage &m);
	MESSAGE void __fastcall WmMediaPlayerPausableChanged(Winapi::Messages::TMessage &m);
	MESSAGE void __fastcall WmMediaPlayerTitleChanged(Winapi::Messages::TMessage &m);
	MESSAGE void __fastcall WmMediaPlayerSnapshotTaken(Winapi::Messages::TMessage &m);
	MESSAGE void __fastcall WmMediaPlayerLengthChanged(Winapi::Messages::TMessage &m);
	MESSAGE void __fastcall WmMediaPlayerVOutChanged(Winapi::Messages::TMessage &m);
	MESSAGE void __fastcall WmMediaPlayerScrambledChanged(Winapi::Messages::TMessage &m);
	
protected:
	void __fastcall SetHwnd(void);
	
public:
	__fastcall virtual TPasLibVlcPlayer(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TPasLibVlcPlayer(void);
	Paslibvlcunit::libvlc_media_player_t_ptr __fastcall GetPlayerHandle(void);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	void __fastcall PlayInWindow(Vcl::Controls::TWinControl* newWindow = (Vcl::Controls::TWinControl*)(0x0));
	void __fastcall Play(System::WideString mrl);
	void __fastcall PlayNormal(System::WideString mrl);
	void __fastcall PlayYoutube(System::WideString mrl, unsigned timeout = (unsigned)(0x2710))/* overload */;
	void __fastcall PlayContinue(void);
	System::UnicodeString __fastcall GetMediaMrl(void);
	void __fastcall Pause(void);
	void __fastcall Resume(void);
	bool __fastcall IsPlay(void);
	bool __fastcall IsPause(void);
	void __fastcall Stop(void);
	TPasLibVlcPlayerState __fastcall GetState(void);
	System::UnicodeString __fastcall GetStateName(void);
	bool __fastcall CanPlay(void);
	bool __fastcall CanPause(void);
	bool __fastcall CanSeek(void);
	bool __fastcall HasVout(void);
	bool __fastcall IsScrambled(void);
	bool __fastcall Snapshot(System::WideString fileName)/* overload */;
	bool __fastcall Snapshot(System::WideString fileName, unsigned width, unsigned height)/* overload */;
	void __fastcall NextFrame(void);
	void __fastcall SetPlayRate(int rate);
	int __fastcall GetPlayRate(void);
	int __fastcall GetVideoWidth(void);
	int __fastcall GetVideoHeight(void);
	bool __fastcall GetVideoDimension(unsigned &width, unsigned &height);
	float __fastcall GetVideoScaleInPercent(void);
	System::UnicodeString __fastcall GetVideoAspectRatio(void);
	void __fastcall SetVideoScaleInPercent(float newScaleInPercent);
	void __fastcall SetVideoAspectRatio(System::UnicodeString newAspectRatio);
	__int64 __fastcall GetVideoLenInMs(void);
	__int64 __fastcall GetVideoPosInMs(void);
	float __fastcall GetVideoPosInPercent(void);
	float __fastcall GetVideoFps(void);
	void __fastcall SetVideoPosInMs(__int64 newPos);
	void __fastcall SetVideoPosInPercent(float newPos);
	System::UnicodeString __fastcall GetVideoLenStr(System::UnicodeString fmt = L"hh:mm:ss");
	System::UnicodeString __fastcall GetVideoPosStr(System::UnicodeString fmt = L"hh:mm:ss");
	void __fastcall SetTeleText(int page);
	int __fastcall GetTeleText(void);
	bool __fastcall ShowTeleText(void);
	bool __fastcall HideTeleText(void);
	bool __fastcall GetAudioMute(void);
	void __fastcall SetAudioMute(bool mute);
	int __fastcall GetAudioVolume(void);
	void __fastcall SetAudioVolume(int volumeLevel);
	Paslibvlcunit::libvlc_audio_output_channel_t __fastcall GetAudioChannel(void);
	void __fastcall SetAudioChannel(Paslibvlcunit::libvlc_audio_output_channel_t chanel);
	__int64 __fastcall GetAudioDelay(void);
	void __fastcall SetAudioDelay(__int64 delay);
	System::Classes::TStringList* __fastcall GetAudioTrackList(void);
	int __fastcall GetAudioTrackCount(void);
	int __fastcall GetAudioTrackId(void);
	void __fastcall SetAudioTrackById(const int track_id);
	int __fastcall GetAudioTrackNo(void);
	void __fastcall SetAudioTrackByNo(int track_no);
	System::WideString __fastcall GetAudioTrackDescriptionById(const int track_id);
	System::WideString __fastcall GetAudioTrackDescriptionByNo(int track_no);
	System::Classes::TStringList* __fastcall GetAudioOutputList(void);
	System::Classes::TStringList* __fastcall GetAudioOutputDeviceList(System::WideString aOut);
	System::Classes::TStringList* __fastcall GetAudioOutputDeviceEnum(void);
	bool __fastcall SetAudioOutput(System::WideString aOut);
	void __fastcall SetAudioOutputDevice(System::WideString aOut, System::WideString device_id)/* overload */;
	void __fastcall SetAudioOutputDevice(System::WideString device_id)/* overload */;
	System::Classes::TStringList* __fastcall EqualizerGetPresetList(void);
	System::Word __fastcall EqualizerGetBandCount(void);
	float __fastcall EqualizerGetBandFrequency(System::Word bandIndex);
	Paslibvlcclassunit::TPasLibVlcEqualizer* __fastcall EqualizerCreate(System::Word APreset = (System::Word)(0xffff));
	void __fastcall EqualizerApply(Paslibvlcclassunit::TPasLibVlcEqualizer* AEqualizer);
	void __fastcall EqualizerSetPreset(System::Word APreset = (System::Word)(0xffff));
	int __fastcall GetVideoChapter(void);
	void __fastcall SetVideoChapter(int newChapter);
	int __fastcall GetVideoChapterCount(void);
	int __fastcall GetVideoChapterCountByTitleId(const int title_id);
	System::Classes::TStringList* __fastcall GetVideoSubtitleList(void);
	int __fastcall GetVideoSubtitleCount(void);
	int __fastcall GetVideoSubtitleId(void);
	void __fastcall SetVideoSubtitleById(const int subtitle_id);
	int __fastcall GetVideoSubtitleNo(void);
	void __fastcall SetVideoSubtitleByNo(int subtitle_no);
	System::WideString __fastcall GetVideoSubtitleDescriptionById(const int subtitle_id);
	System::WideString __fastcall GetVideoSubtitleDescriptionByNo(int subtitle_no);
	void __fastcall SetVideoSubtitleFile(System::WideString subtitle_file);
	System::Classes::TStringList* __fastcall GetVideoTitleList(void);
	int __fastcall GetVideoTitleCount(void);
	int __fastcall GetVideoTitleId(void);
	void __fastcall SetVideoTitleById(const int title_id);
	int __fastcall GetVideoTitleNo(void);
	void __fastcall SetVideoTitleByNo(int title_no);
	System::WideString __fastcall GetVideoTitleDescriptionById(const int track_id);
	System::WideString __fastcall GetVideoTitleDescriptionByNo(int title_no);
	void __fastcall LogoSetFile(System::WideString file_name);
	void __fastcall LogoSetFiles(System::WideString *file_names, const int file_names_Size, int delay_ms = 0x3e8, bool loop = true);
	void __fastcall LogoSetPosition(int position_x, int position_y)/* overload */;
	void __fastcall LogoSetPosition(Paslibvlcunit::libvlc_position_t position)/* overload */;
	void __fastcall LogoSetOpacity(Paslibvlcunit::libvlc_opacity_t opacity);
	void __fastcall LogoSetDelay(int delay_ms = 0x3e8);
	void __fastcall LogoSetRepeat(bool loop = true);
	void __fastcall LogoSetEnable(int enable);
	void __fastcall LogoShowFile(System::WideString file_name, int position_x, int position_y, Paslibvlcunit::libvlc_opacity_t opacity = (Paslibvlcunit::libvlc_opacity_t)(0xff))/* overload */;
	void __fastcall LogoShowFile(System::WideString file_name, Paslibvlcunit::libvlc_position_t position = (Paslibvlcunit::libvlc_position_t)(0x4), Paslibvlcunit::libvlc_opacity_t opacity = (Paslibvlcunit::libvlc_opacity_t)(0xff))/* overload */;
	void __fastcall LogoShowFiles(System::WideString *file_names, const int file_names_Size, int position_x, int position_y, Paslibvlcunit::libvlc_opacity_t opacity = (Paslibvlcunit::libvlc_opacity_t)(0xff), int delay_ms = 0x3e8, bool loop = true)/* overload */;
	void __fastcall LogoShowFiles(System::WideString *file_names, const int file_names_Size, Paslibvlcunit::libvlc_position_t position = (Paslibvlcunit::libvlc_position_t)(0x4), Paslibvlcunit::libvlc_opacity_t opacity = (Paslibvlcunit::libvlc_opacity_t)(0xff), int delay_ms = 0x3e8, bool loop = true)/* overload */;
	void __fastcall LogoHide(void);
	void __fastcall MarqueeSetText(System::WideString marquee_text);
	void __fastcall MarqueeSetPosition(int position_x, int position_y)/* overload */;
	void __fastcall MarqueeSetPosition(Paslibvlcunit::libvlc_position_t position)/* overload */;
	void __fastcall MarqueeSetColor(Paslibvlcunit::libvlc_video_marquee_color_t color);
	void __fastcall MarqueeSetFontSize(int font_size);
	void __fastcall MarqueeSetOpacity(Paslibvlcunit::libvlc_opacity_t opacity);
	void __fastcall MarqueeSetTimeOut(int time_out_ms);
	void __fastcall MarqueeSetRefresh(int refresh_after_ms);
	void __fastcall MarqueeSetEnable(int enable);
	void __fastcall MarqueeShowText(System::WideString marquee_text, int position_x, int position_y, Paslibvlcunit::libvlc_video_marquee_color_t color = (Paslibvlcunit::libvlc_video_marquee_color_t)(0xffffff), int font_size = 0xc, Paslibvlcunit::libvlc_opacity_t opacity = (Paslibvlcunit::libvlc_opacity_t)(0xff), int time_out_ms = 0x0)/* overload */;
	void __fastcall MarqueeShowText(System::WideString marquee_text, Paslibvlcunit::libvlc_position_t position = (Paslibvlcunit::libvlc_position_t)(0x8), Paslibvlcunit::libvlc_video_marquee_color_t color = (Paslibvlcunit::libvlc_video_marquee_color_t)(0xffffff), int font_size = 0xc, Paslibvlcunit::libvlc_opacity_t opacity = (Paslibvlcunit::libvlc_opacity_t)(0xff), int time_out_ms = 0x0)/* overload */;
	void __fastcall MarqueeHide(void);
	void __fastcall EventsDisable(void);
	void __fastcall EventsEnable(void);
	__property Paslibvlcclassunit::TPasLibVlc* VLC = {read=GetVlcInstance};
	
__published:
	__property Align = {default=0};
	__property Color = {default=0};
	__property Width = {default=320};
	__property Height = {default=240};
	__property Constraints;
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property Visible = {default=1};
	__property OnAlignPosition;
	__property OnCanResize;
	__property OnClick;
	__property OnConstrainedResize;
	__property OnContextPopup;
	__property OnDockDrop;
	__property OnDockOver;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnGetSiteInfo;
	__property OnMouseActivate;
	__property OnMouseDown;
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnResize;
	__property OnStartDock;
	__property OnStartDrag;
	__property OnUnDock;
	__property bool SpuShow = {read=FSpuShow, write=SetSpuShow, default=1};
	__property bool OsdShow = {read=FOsdShow, write=SetOsdShow, default=1};
	__property bool TitleShow = {read=FTitleShow, write=SetTitleShow, default=0};
	__property Paslibvlcclassunit::TPasLibVlcTitlePosition TitleShowPos = {read=FTitleShowPos, write=SetTitleShowPos, default=0};
	__property unsigned TitleShowTimeOut = {read=FTitleShowTimeOut, write=SetTitleShowTimeOut, default=2000};
	__property Paslibvlcclassunit::TVideoOutput VideoOutput = {read=FVideoOutput, write=FVideoOutput, default=0};
	__property Paslibvlcclassunit::TAudioOutput AudioOutput = {read=FAudioOutput, write=FAudioOutput, default=0};
	__property bool VideoOnTop = {read=FVideoOnTop, write=SetVideoOnTop, default=0};
	__property bool UseOverlay = {read=FUseOverlay, write=SetUseOverlay, default=0};
	__property System::UnicodeString SnapShotFmt = {read=FSnapshotFmt, write=SetSnapshotFmt};
	__property bool SnapshotPrv = {read=FSnapshotPrv, write=SetSnapshotPrv, default=0};
	__property Paslibvlcclassunit::TDeinterlaceFilter DeinterlaceFilter = {read=FDeinterlaceFilter, write=SetDeinterlaceFilter, default=0};
	__property System::WideString DeinterlaceModeName = {read=GetDeinterlaceModeName};
	__property Paslibvlcclassunit::TDeinterlaceMode DeinterlaceMode = {read=FDeinterlaceMode, write=SetDeinterlaceMode, default=0};
	__property bool ViewTeletext = {read=FViewTeleText, write=SetViewTeleText, default=0};
	__property System::UnicodeString LastError = {read=FError, write=FError};
	__property System::Classes::TStringList* StartOptions = {read=FStartOptions, write=SetStartOptions};
	__property TNotifyMediaChanged OnMediaPlayerMediaChanged = {read=FOnMediaPlayerMediaChanged, write=FOnMediaPlayerMediaChanged};
	__property System::Classes::TNotifyEvent OnMediaPlayerNothingSpecial = {read=FOnMediaPlayerNothingSpecial, write=FOnMediaPlayerNothingSpecial};
	__property System::Classes::TNotifyEvent OnMediaPlayerOpening = {read=FOnMediaPlayerOpening, write=FOnMediaPlayerOpening};
	__property System::Classes::TNotifyEvent OnMediaPlayerBuffering = {read=FOnMediaPlayerBuffering, write=FOnMediaPlayerBuffering};
	__property System::Classes::TNotifyEvent OnMediaPlayerPlaying = {read=FOnMediaPlayerPlaying, write=FOnMediaPlayerPlaying};
	__property System::Classes::TNotifyEvent OnMediaPlayerPaused = {read=FOnMediaPlayerPaused, write=FOnMediaPlayerPaused};
	__property System::Classes::TNotifyEvent OnMediaPlayerStopped = {read=FOnMediaPlayerStopped, write=FOnMediaPlayerStopped};
	__property System::Classes::TNotifyEvent OnMediaPlayerForward = {read=FOnMediaPlayerForward, write=FOnMediaPlayerForward};
	__property System::Classes::TNotifyEvent OnMediaPlayerBackward = {read=FOnMediaPlayerBackward, write=FOnMediaPlayerBackward};
	__property System::Classes::TNotifyEvent OnMediaPlayerEndReached = {read=FOnMediaPlayerEndReached, write=FOnMediaPlayerEndReached};
	__property System::Classes::TNotifyEvent OnMediaPlayerEncounteredError = {read=FOnMediaPlayerEncounteredError, write=FOnMediaPlayerEncounteredError};
	__property TNotifyTimeChanged OnMediaPlayerTimeChanged = {read=FOnMediaPlayerTimeChanged, write=FOnMediaPlayerTimeChanged};
	__property TNotifyPositionChanged OnMediaPlayerPositionChanged = {read=FOnMediaPlayerPositionChanged, write=FOnMediaPlayerPositionChanged};
	__property TNotifySeekableChanged OnMediaPlayerSeekableChanged = {read=FOnMediaPlayerSeekableChanged, write=FOnMediaPlayerSeekableChanged};
	__property TNotifyPausableChanged OnMediaPlayerPausableChanged = {read=FOnMediaPlayerPausableChanged, write=FOnMediaPlayerPausableChanged};
	__property TNotifyTitleChanged OnMediaPlayerTitleChanged = {read=FOnMediaPlayerTitleChanged, write=FOnMediaPlayerTitleChanged};
	__property TNotifySnapshotTaken OnMediaPlayerSnapshotTaken = {read=FOnMediaPlayerSnapshotTaken, write=FOnMediaPlayerSnapshotTaken};
	__property TNotifyLengthChanged OnMediaPlayerLengthChanged = {read=FOnMediaPlayerLengthChanged, write=FOnMediaPlayerLengthChanged};
	__property TNotifyVideoOutChanged OnMediaPlayerVideoOutChanged = {read=FOnMediaPlayerVideoOutChanged, write=FOnMediaPlayerVideoOutChanged};
	__property TNotifyScrambledChanged OnMediaPlayerScrambledChanged = {read=FOnMediaPlayerScrambledChanged, write=FOnMediaPlayerScrambledChanged};
	__property TNotifyPlayerEvent OnMediaPlayerEvent = {read=FOnMediaPlayerEvent, write=FOnMediaPlayerEvent};
	__property bool UseEvents = {read=FUseEvents, write=FUseEvents, default=1};
	__property TPasLibVlcPlayerMouseEventsHandler MouseEventsHandler = {read=FMouseEventsHandler, write=SetMouseEventHandler, default=0};
public:
	/* TWinControl.CreateParented */ inline __fastcall TPasLibVlcPlayer(HWND ParentWindow) : Vcl::Extctrls::TCustomPanel(ParentWindow) { }
	
};

#pragma pack(pop)

typedef void __fastcall (__closure *TNotifyMediaListItem)(System::TObject* Sender, System::WideString mrl, void * item, int index);

class DELPHICLASS TPasLibVlcMediaList;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TPasLibVlcMediaList : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	void *p_ml;
	void *p_mlp;
	void *p_ml_ev_mgr;
	void *p_mlp_ev_mgr;
	System::Syncobjs::TCriticalSection* FCS;
	TPasLibVlcPlayer* FPlayer;
	System::UnicodeString FError;
	TNotifyMediaListItem FOnItemAdded;
	TNotifyMediaListItem FOnWillAddItem;
	TNotifyMediaListItem FOnItemDeleted;
	TNotifyMediaListItem FOnWillDeleteItem;
	TNotifyMediaListItem FOnNextItemSet;
	System::Classes::TNotifyEvent FOnPlayed;
	System::Classes::TNotifyEvent FOnStopped;
	void __fastcall SetPlayer(TPasLibVlcPlayer* aPlayer);
	void __fastcall InternalHandleEventItemAdded(Paslibvlcunit::libvlc_media_t_ptr item, int index);
	void __fastcall InternalHandleEventItemDeleted(Paslibvlcunit::libvlc_media_t_ptr item, int index);
	void __fastcall InternalHandleEventWillAddItem(Paslibvlcunit::libvlc_media_t_ptr item, int index);
	void __fastcall InternalHandleEventWillDeleteItem(Paslibvlcunit::libvlc_media_t_ptr item, int index);
	void __fastcall InternalHandleEventPlayerNextItemSet(Paslibvlcunit::libvlc_media_t_ptr item);
	
public:
	__fastcall virtual TPasLibVlcMediaList(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TPasLibVlcMediaList(void);
	void __fastcall SetPlayModeNormal(void);
	void __fastcall SetPlayModeLoop(void);
	void __fastcall SetPlayModeRepeat(void);
	void __fastcall Play(void);
	void __fastcall Pause(void);
	void __fastcall Stop(void);
	void __fastcall Next(void);
	void __fastcall Prev(void);
	bool __fastcall IsPlay(void);
	bool __fastcall IsPause(void);
	TPasLibVlcPlayerState __fastcall GetState(void);
	System::UnicodeString __fastcall GetStateName(void);
	void __fastcall PlayItem(Paslibvlcunit::libvlc_media_t_ptr item);
	void __fastcall Clear(void);
	void __fastcall Add(System::WideString mrl);
	System::WideString __fastcall Get(int index);
	int __fastcall Count(void);
	void __fastcall Delete(int index);
	HIDESBASE void __fastcall Insert(int index, System::WideString mrl);
	Paslibvlcunit::libvlc_media_t_ptr __fastcall GetItemAtIndex(int index);
	int __fastcall IndexOfItem(Paslibvlcunit::libvlc_media_t_ptr item);
	void __fastcall EventsDisable(void);
	void __fastcall EventsEnable(void);
	
__published:
	__property TPasLibVlcPlayer* Player = {read=FPlayer, write=SetPlayer};
	__property System::UnicodeString LastError = {read=FError, write=FError};
	__property TNotifyMediaListItem OnItemAdded = {read=FOnItemAdded, write=FOnItemAdded};
	__property TNotifyMediaListItem OnWillAddItem = {read=FOnWillAddItem, write=FOnWillAddItem};
	__property TNotifyMediaListItem OnItemDeleted = {read=FOnItemDeleted, write=FOnItemDeleted};
	__property TNotifyMediaListItem OnWillDeleteItem = {read=FOnWillDeleteItem, write=FOnWillDeleteItem};
	__property System::Classes::TNotifyEvent OnPlayed = {read=FOnPlayed, write=FOnPlayed};
	__property System::Classes::TNotifyEvent OnStopped = {read=FOnStopped, write=FOnStopped};
	__property TNotifyMediaListItem OnNextItemSet = {read=FOnNextItemSet, write=FOnNextItemSet};
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
static const System::Word WM_START = System::Word(0x400);
static const System::Word WM_MEDIA_PLAYER_MEDIA_CHANGED = System::Word(0x500);
static const System::Word WM_MEDIA_PLAYER_NOTHING_SPECIAL = System::Word(0x501);
static const System::Word WM_MEDIA_PLAYER_OPENING = System::Word(0x502);
static const System::Word WM_MEDIA_PLAYER_BUFFERING = System::Word(0x503);
static const System::Word WM_MEDIA_PLAYER_PLAYING = System::Word(0x504);
static const System::Word WM_MEDIA_PLAYER_PAUSED = System::Word(0x505);
static const System::Word WM_MEDIA_PLAYER_STOPPED = System::Word(0x506);
static const System::Word WM_MEDIA_PLAYER_FORWARD = System::Word(0x507);
static const System::Word WM_MEDIA_PLAYER_BACKWARD = System::Word(0x508);
static const System::Word WM_MEDIA_PLAYER_END_REACHED = System::Word(0x509);
static const System::Word WM_MEDIA_PLAYER_ENCOUNTERED_ERROR = System::Word(0x510);
static const System::Word WM_MEDIA_PLAYER_TIME_CHANGED = System::Word(0x511);
static const System::Word WM_MEDIA_PLAYER_POSITION_CHANGED = System::Word(0x512);
static const System::Word WM_MEDIA_PLAYER_SEEKABLE_CHNANGED = System::Word(0x513);
static const System::Word WM_MEDIA_PLAYER_PAUSABLE_CHNANGED = System::Word(0x514);
static const System::Word WM_MEDIA_PLAYER_TITLE_CHNANGED = System::Word(0x515);
static const System::Word WM_MEDIA_PLAYER_SNAPSHOT_TAKEN = System::Word(0x516);
static const System::Word WM_MEDIA_PLAYER_LENGTH_CHANGED = System::Word(0x517);
static const System::Word WM_MEDIA_PLAYER_VOUT_CHANGED = System::Word(0x518);
static const System::Word WM_MEDIA_PLAYER_SCRAMBLED_CHNANGED = System::Word(0x519);
extern DELPHI_PACKAGE void __fastcall Register(void);
extern DELPHI_PACKAGE System::UnicodeString __fastcall time2str(__int64 timeInMs, System::UnicodeString fmt = L"hh:mm:ss.ms");
}	/* namespace Paslibvlcplayerunit */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PASLIBVLCPLAYERUNIT)
using namespace Paslibvlcplayerunit;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PaslibvlcplayerunitHPP
