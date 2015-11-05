//---------------------------------------------------------------------------

#ifndef PlayerFrameUnitH
#define PlayerFrameUnitH
//---------------------------------------------------------------------------
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Samples.Spin.hpp>

#include "PlayerAreaUnit.h"
//---------------------------------------------------------------------------
class TPlayerFrame : public TFrame
{
__published:	// IDE-managed Components
	TLabel *Label2;
	TComboBox *MonitorComboBox;
	TGroupBox *GroupBox1;
	TLabel *Label3;
	TLabel *Label4;
	TLabel *Label5;
	TLabel *Label6;
	TSpinEdit *XSpinEdit;
	TSpinEdit *YSpinEdit;
	TSpinEdit *WSpinEdit;
	TSpinEdit *HSpinEdit;
	TLabel *Label1;
	TLabel *Label7;
	TSpinEdit *AlphaSpinEdit;
	void __fastcall OnPlayerAreaChange(TObject *Sender);
	void __fastcall AlphaSpinEditChange(TObject *Sender);
private:	// User declarations
public:		// User declarations
	__fastcall TPlayerFrame(TComponent* Owner);

    TPlayerAreaForm *PlayerAreaForm;
};
//---------------------------------------------------------------------------
extern PACKAGE TPlayerFrame *PlayerFrame;
//---------------------------------------------------------------------------
#endif
