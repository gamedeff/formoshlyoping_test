//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "PlayerFrameUnit.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TPlayerFrame *PlayerFrame;
//---------------------------------------------------------------------------
__fastcall TPlayerFrame::TPlayerFrame(TComponent* Owner)
	: TFrame(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TPlayerFrame::OnPlayerAreaChange(TObject *Sender)
{
    int m = MonitorComboBox->ItemIndex;

    PlayerAreaForm->Left   = Screen->Monitors[m]->Left + XSpinEdit->Value;
    PlayerAreaForm->Top    = Screen->Monitors[m]->Top  + YSpinEdit->Value;
    PlayerAreaForm->Width  = Screen->Monitors[m]->Left + WSpinEdit->Value;
    PlayerAreaForm->Height = Screen->Monitors[m]->Top  + HSpinEdit->Value;
}
//---------------------------------------------------------------------------
void __fastcall TPlayerFrame::AlphaSpinEditChange(TObject *Sender)
{
    PlayerAreaForm->AlphaBlend = AlphaSpinEdit->Value < AlphaSpinEdit->MaxValue;
	PlayerAreaForm->AlphaBlendValue = 255 * AlphaSpinEdit->Value / AlphaSpinEdit->MaxValue;
}
//---------------------------------------------------------------------------

