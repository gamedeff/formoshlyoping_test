//---------------------------------------------------------------------------

#ifndef PlayerWindowUnitH
#define PlayerWindowUnitH
//---------------------------------------------------------------------------
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.Samples.Spin.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>

#include "PlayerFrameUnit.h"
#include <Vcl.Buttons.hpp>
//---------------------------------------------------------------------------
class TMainForm : public TForm
{
__published:	// IDE-managed Components
	TOpenDialog *OpenDialog1;
	TSpinEdit *PlayerAreaFormsSpinEdit;
	TLabel *Label1;
	TPageControl *PageControl1;
	TPanel *BottomPanel;
	TButton *PrevBtn;
	TButton *NextBtn;
	TButton *StopBtn;
	TButton *ClearBtn;
	TButton *PlayModeNormalBtn;
	TButton *PlayModeLoopBtn;
	TButton *PlayModeRepeatBtn;
	TButton *PauseBtn;
	TTrackBar *TrackBar;
	TListBox *PlayListBox;
	TPanel *TimePanel;
	TStatusBar *StatusBar1;
	TEdit *NewPlayListItemEdit;
	TSpeedButton *OpenSpeedButton;
	TSpeedButton *AddSpeedButton;
	TLabel *Label2;
	void __fastcall FormCreate(TObject *Sender);
	void __fastcall FormDestroy(TObject *Sender);
	void __fastcall PlayerAreaFormsSpinEditEnter(TObject *Sender);
	void __fastcall PlayModeLoopBtnClick(TObject *Sender);
	void __fastcall PlayModeNormalBtnClick(TObject *Sender);
	void __fastcall PlayModeRepeatBtnClick(TObject *Sender);
	void __fastcall PlayListBoxClick(TObject *Sender);
	void __fastcall NextBtnClick(TObject *Sender);
	void __fastcall PauseBtnClick(TObject *Sender);
	void __fastcall PrevBtnClick(TObject *Sender);
	void __fastcall StopBtnClick(TObject *Sender);
	void __fastcall TrackBarChange(TObject *Sender);
	void __fastcall OpenSpeedButtonClick(TObject *Sender);
	void __fastcall AddSpeedButtonClick(TObject *Sender);
	void __fastcall ClearBtnClick(TObject *Sender);

private:	// User declarations
public:		// User declarations
	__fastcall TMainForm(TComponent* Owner);

    TTabSheet **PlayerAreaTabSheets;
    TPlayerFrame **PlayerAreaFrames;
    int PlayerAreaFormsNum;
};
//---------------------------------------------------------------------------
extern PACKAGE TMainForm *MainForm;
//---------------------------------------------------------------------------
#endif
