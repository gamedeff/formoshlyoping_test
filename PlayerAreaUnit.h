//---------------------------------------------------------------------------

#ifndef PlayerAreaUnitH
#define PlayerAreaUnitH
//---------------------------------------------------------------------------
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Forms.hpp>
#include "PasLibVlcPlayerUnit.hpp"
#include <Vcl.ExtCtrls.hpp>
//---------------------------------------------------------------------------
class TPlayerAreaForm : public TForm
{
__published:	// IDE-managed Components
	TPasLibVlcPlayer *PasLibVlcPlayer1;
	TPasLibVlcMediaList *PasLibVlcMediaList1;
	void __fastcall PasLibVlcPlayer1MediaPlayerEndReached(TObject *Sender);
	void __fastcall PasLibVlcPlayer1MediaPlayerLengthChanged(TObject *Sender, __int64 time);
	void __fastcall PasLibVlcPlayer1MediaPlayerTimeChanged(TObject *Sender, __int64 time);
	void __fastcall PasLibVlcMediaList1ItemAdded(TObject *Sender, WideString mrl, Pointer item,
          int index);
	void __fastcall PasLibVlcMediaList1ItemDeleted(TObject *Sender, WideString mrl,
          Pointer item, int index);
	void __fastcall PasLibVlcMediaList1NextItemSet(TObject *Sender, WideString mrl,
          Pointer item, int index);
	void __fastcall PasLibVlcPlayer1MouseDown(TObject *Sender, TMouseButton Button,
          TShiftState Shift, int X, int Y);
	void __fastcall PasLibVlcPlayer1MediaPlayerBuffering(TObject *Sender);


private:	// User declarations
/*    void __fastcall WMNCHitTest(TMessage& Msg);

BEGIN_MESSAGE_MAP
    MESSAGE_HANDLER(WM_NCHITTEST, TMessage, WMNCHitTest)
END_MESSAGE_MAP(TForm)
*/
public:		// User declarations
	__fastcall TPlayerAreaForm(TComponent* Owner);

};
//---------------------------------------------------------------------------
extern PACKAGE TPlayerAreaForm *PlayerAreaForm;
//---------------------------------------------------------------------------
#endif
