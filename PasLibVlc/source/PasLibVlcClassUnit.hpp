// CodeGear C++Builder
// Copyright (c) 1995, 2012 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'PasLibVlcClassUnit.pas' rev: 24.00 (Windows)

#ifndef PaslibvlcclassunitHPP
#define PaslibvlcclassunitHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <Winapi.Messages.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.ExtCtrls.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <PasLibVlcUnit.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Paslibvlcclassunit
{
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TDeinterlaceFilter : unsigned int { deOFF, deON };

enum DECLSPEC_DENUM TDeinterlaceMode : unsigned int { dmDISCARD, dmBLEND, dmMEAN, dmBOB, dmLINEAR, dmX, dmYADIF, dmYADIF2x, dmPHOSPHOR, dmIVTC };

enum DECLSPEC_DENUM TPasLibVlcTitlePosition : unsigned int { plvPosCenter, plvPosLeft, plvPosRight, plvPosTop, plvPosTopLeft, plvPosTopRight, plvPosBottom, plvPosBottomLeft, plvPosBottomRight };

enum DECLSPEC_DENUM TVideoRatio : unsigned int { ra_NONE, ra_16_9, ra_16_10, ra_185_100, ra_221_100, ra_235_100, ra_239_100, ra_4_3, ra_5_4, ra_5_3, ra_1_1 };

enum DECLSPEC_DENUM TMux : unsigned int { muxTS, muxPS, muxMp4, muxOgg, muxAvi };

enum DECLSPEC_DENUM TVideoOutput : unsigned int { voDefault, voWinGdi, voDirectX, voDirect3d, voOpenGl, voDummy };

enum DECLSPEC_DENUM TAudioOutput : unsigned int { aoDefault, aoDirectX, aoWaveOut, aoDummy };

enum DECLSPEC_DENUM TVideoCodec : unsigned int { vcNONE, vcMPGV, vcMP4V, vcH264, vcTHEORA };

enum DECLSPEC_DENUM TAudioCodec : unsigned int { acNONE, acMPGA, acMP3, acMP4A, acVORB, acFLAC };

typedef System::StaticArray<System::UnicodeString, 10> Paslibvlcclassunit__1;

typedef System::StaticArray<System::AnsiString, 5> Paslibvlcclassunit__2;

typedef System::StaticArray<System::UnicodeString, 6> Paslibvlcclassunit__3;

typedef System::StaticArray<System::UnicodeString, 4> Paslibvlcclassunit__4;

typedef System::StaticArray<System::AnsiString, 11> Paslibvlcclassunit__5;

typedef System::StaticArray<System::AnsiString, 5> Paslibvlcclassunit__6;

typedef System::StaticArray<System::AnsiString, 6> Paslibvlcclassunit__7;

class DELPHICLASS TPasLibVlc;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TPasLibVlc : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	void *FHandle;
	System::WideString FPath;
	bool FTitleShow;
	unsigned FVersionBin;
	System::Classes::TStringList* FStartOptions;
	Paslibvlcunit::libvlc_instance_t_ptr __fastcall GetHandle(void);
	System::WideString __fastcall GetError(void);
	System::WideString __fastcall GetVersion(void);
	unsigned __fastcall GetVersionBin(void);
	System::WideString __fastcall GetCompiler(void);
	System::WideString __fastcall GetChangeSet(void);
	void __fastcall SetPath(System::WideString aPath);
	
public:
	__fastcall TPasLibVlc(void);
	__fastcall virtual ~TPasLibVlc(void);
	void __fastcall AddOption(System::UnicodeString option);
	__property Paslibvlcunit::libvlc_instance_t_ptr Handle = {read=GetHandle};
	__property System::WideString Error = {read=GetError};
	__property System::WideString Version = {read=GetVersion};
	__property unsigned VersionBin = {read=GetVersionBin, nodefault};
	__property System::WideString Compiler = {read=GetCompiler};
	__property System::WideString ChangeSet = {read=GetChangeSet};
	__property System::WideString Path = {read=FPath, write=SetPath};
	__property bool TitleShow = {read=FTitleShow, write=FTitleShow, default=0};
	__property System::Classes::TStringList* StartOptions = {read=FStartOptions};
};

#pragma pack(pop)

class DELPHICLASS TPasLibVlcMedia;
class DELPHICLASS TPasLibVlcMediaListC;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TPasLibVlcMedia : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TPasLibVlc* FVLC;
	void *FMD;
	
public:
	__fastcall TPasLibVlcMedia(TPasLibVlc* aVLC)/* overload */;
	__fastcall TPasLibVlcMedia(TPasLibVlc* aVLC, System::WideString mrl)/* overload */;
	__fastcall TPasLibVlcMedia(TPasLibVlc* aVLC, Paslibvlcunit::libvlc_media_t_ptr aMD)/* overload */;
	__fastcall virtual ~TPasLibVlcMedia(void);
	void __fastcall NewLocation(System::WideString mrl);
	void __fastcall NewPath(System::WideString path);
	void __fastcall NewNode(System::WideString name);
	void __fastcall AddOption(System::UnicodeString option);
	void __fastcall AddOptionFlag(System::UnicodeString option, Paslibvlcunit::input_item_option_e flag);
	System::WideString __fastcall GetMrl(void);
	TPasLibVlcMedia* __fastcall Duplicate(void);
	System::WideString __fastcall GetMeta(Paslibvlcunit::libvlc_meta_t meta);
	void __fastcall SetMeta(Paslibvlcunit::libvlc_meta_t meta, System::WideString value);
	void __fastcall SaveMeta(void);
	Paslibvlcunit::libvlc_state_t __fastcall GetState(void);
	bool __fastcall GetStats(Paslibvlcunit::libvlc_media_stats_t &stats);
	TPasLibVlcMediaListC* __fastcall SubItems(void);
	Paslibvlcunit::libvlc_event_manager_t_ptr __fastcall GetEventManager(void);
	__int64 __fastcall GetDuration(void);
	void __fastcall Parse(void);
	void __fastcall ParseAsync(void);
	bool __fastcall IsParsed(void);
	void __fastcall SetUserData(void * data);
	void * __fastcall GetUserData(void);
	int __fastcall GetTracksInfo(Paslibvlcunit::libvlc_media_track_info_t_ptr &tracks);
	void __fastcall SetDeinterlaceFilter(TDeinterlaceFilter aValue);
	void __fastcall SetDeinterlaceFilterMode(TDeinterlaceMode aValue);
	__property Paslibvlcunit::libvlc_media_t_ptr MD = {read=FMD};
};

#pragma pack(pop)

class DELPHICLASS TPasLibVlcMediaPlayerC;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TPasLibVlcMediaListC : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TPasLibVlc* FVLC;
	void *FML;
	TPasLibVlcMediaPlayerC* FMP;
	
public:
	__fastcall TPasLibVlcMediaListC(TPasLibVlc* aVLC)/* overload */;
	__fastcall TPasLibVlcMediaListC(TPasLibVlc* aVLC, Paslibvlcunit::libvlc_media_list_t_ptr aML)/* overload */;
	__fastcall virtual ~TPasLibVlcMediaListC(void);
	void __fastcall SetMedia(TPasLibVlcMedia* media);
	TPasLibVlcMedia* __fastcall GetMedia(void)/* overload */;
	TPasLibVlcMedia* __fastcall GetMedia(int index)/* overload */;
	int __fastcall GetIndex(TPasLibVlcMedia* media);
	bool __fastcall IsReadOnly(void);
	void __fastcall Add(System::WideString mrl)/* overload */;
	void __fastcall Add(TPasLibVlcMedia* media)/* overload */;
	void __fastcall Insert(TPasLibVlcMedia* media, int index);
	void __fastcall Delete(int index);
	void __fastcall Clear(void);
	int __fastcall Count(void);
	void __fastcall Lock(void);
	void __fastcall UnLock(void);
	Paslibvlcunit::libvlc_event_manager_t_ptr __fastcall GetEventManager(void);
	__property Paslibvlcunit::libvlc_media_list_t_ptr ML = {read=FML};
	__property TPasLibVlcMediaPlayerC* MI = {read=FMP, write=FMP};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TPasLibVlcMediaPlayerC : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	bool FTitleShow;
	bool FVideoOnTop;
	bool FUseOverlay;
	System::UnicodeString FSnapShotFmt;
	TDeinterlaceFilter FDeinterlaceFilter;
	TDeinterlaceMode FDeinterlaceMode;
	
public:
	__property bool TitleShow = {read=FTitleShow, write=FTitleShow, default=0};
	__property bool VideoOnTop = {read=FVideoOnTop, write=FVideoOnTop, default=0};
	__property bool UseOverlay = {read=FUseOverlay, write=FUseOverlay, default=0};
	__property System::UnicodeString SnapShotFmt = {read=FSnapShotFmt, write=FSnapShotFmt};
	__property TDeinterlaceFilter DeinterlaceFilter = {read=FDeinterlaceFilter, write=FDeinterlaceFilter, default=0};
	__property TDeinterlaceMode DeinterlaceMode = {read=FDeinterlaceMode, write=FDeinterlaceMode, default=0};
public:
	/* TObject.Create */ inline __fastcall TPasLibVlcMediaPlayerC(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TPasLibVlcMediaPlayerC(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TPasLibVlcEqualizer;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TPasLibVlcEqualizer : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TPasLibVlc* FVLC;
	void *FEqualizer;
	System::Word FPreset;
	
public:
	__fastcall TPasLibVlcEqualizer(TPasLibVlc* AVLC, System::Word APreset);
	__fastcall virtual ~TPasLibVlcEqualizer(void);
	float __fastcall GetPreAmp(void);
	void __fastcall SetPreAmp(float value);
	float __fastcall GetAmp(System::Word index);
	void __fastcall SetAmp(System::Word index, float value);
	System::Word __fastcall GetBandCount(void);
	float __fastcall GetBandFrequency(System::Word index);
	System::Word __fastcall GetPresetCount(void);
	System::WideString __fastcall GetPresetName(System::Word index)/* overload */;
	System::WideString __fastcall GetPresetName(void)/* overload */;
	System::Word __fastcall GetPreset(void);
	void __fastcall SetPreset(System::Word APreset = (System::Word)(0xffff));
	void * __fastcall GetHandle(void);
};

#pragma pack(pop)

class DELPHICLASS TPasLibVlcMouseEventWinCtrl;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TPasLibVlcMouseEventWinCtrl : public Vcl::Controls::TWinControl
{
	typedef Vcl::Controls::TWinControl inherited;
	
private:
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Winapi::Messages::TWMEraseBkgnd &msg);
	
protected:
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &params);
	
__published:
	__property OnClick;
	__property OnDblClick;
	__property OnMouseActivate;
	__property OnMouseDown;
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property OnMouseMove;
	__property OnMouseUp;
public:
	/* TWinControl.Create */ inline __fastcall virtual TPasLibVlcMouseEventWinCtrl(System::Classes::TComponent* AOwner) : Vcl::Controls::TWinControl(AOwner) { }
	/* TWinControl.CreateParented */ inline __fastcall TPasLibVlcMouseEventWinCtrl(HWND ParentWindow) : Vcl::Controls::TWinControl(ParentWindow) { }
	/* TWinControl.Destroy */ inline __fastcall virtual ~TPasLibVlcMouseEventWinCtrl(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE Paslibvlcclassunit__1 vlcDeinterlaceModeNames;
extern DELPHI_PACKAGE Paslibvlcclassunit__2 vlcMuxNames;
extern DELPHI_PACKAGE Paslibvlcclassunit__3 vlcVideoOutputNames;
extern DELPHI_PACKAGE Paslibvlcclassunit__4 vlcAudioOutputNames;
extern DELPHI_PACKAGE Paslibvlcclassunit__5 vlcVideoRatioNames;
extern DELPHI_PACKAGE Paslibvlcclassunit__6 vlcVideoCodecNames;
extern DELPHI_PACKAGE Paslibvlcclassunit__7 vlcAudioCodecNames;
}	/* namespace Paslibvlcclassunit */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PASLIBVLCCLASSUNIT)
using namespace Paslibvlcclassunit;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PaslibvlcclassunitHPP
