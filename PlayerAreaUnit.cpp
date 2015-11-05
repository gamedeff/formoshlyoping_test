//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "PlayerAreaUnit.h"

#include "PlayerWindowUnit.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "PasLibVlcPlayerUnit"
#pragma resource "*.dfm"
TPlayerAreaForm *PlayerAreaForm;
//---------------------------------------------------------------------------
__fastcall TPlayerAreaForm::TPlayerAreaForm(TComponent* Owner)
	: TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TPlayerAreaForm::PasLibVlcPlayer1MediaPlayerEndReached(TObject *Sender)
{
	MainForm->TrackBar->Position = 0;
    MainForm->TimePanel->Caption = "";
}
//---------------------------------------------------------------------------
void __fastcall TPlayerAreaForm::PasLibVlcPlayer1MediaPlayerLengthChanged(TObject *Sender,
          __int64 time)
{
    MainForm->TrackBar->Max = PasLibVlcPlayer1->GetVideoLenInMs();
    MainForm->TimePanel->Caption = PasLibVlcPlayer1->GetVideoPosStr("hh:mm:ss.ms") + " / " +
                       			   PasLibVlcPlayer1->GetVideoLenStr("hh:mm:ss.ms");
}
//---------------------------------------------------------------------------
void __fastcall TPlayerAreaForm::PasLibVlcPlayer1MediaPlayerTimeChanged(TObject *Sender,
          __int64 time)
{
    MainForm->TimePanel->Caption = PasLibVlcPlayer1->GetVideoPosStr("hh:mm:ss.ms") + "/" +
                       			   PasLibVlcPlayer1->GetVideoLenStr("hh:mm:ss.ms");
	MainForm->TrackBar->Position = PasLibVlcPlayer1->GetVideoPosInMs();
}
//---------------------------------------------------------------------------
void __fastcall TPlayerAreaForm::PasLibVlcMediaList1ItemAdded(TObject *Sender, WideString mrl,
          Pointer item, int index)
{
//	MainForm->PlayListBox->Items->AddObject(mrl, reinterpret_cast<TObject *>(item));
}
//---------------------------------------------------------------------------
void __fastcall TPlayerAreaForm::PasLibVlcMediaList1ItemDeleted(TObject *Sender, WideString mrl,
          Pointer item, int index)
{
	MainForm->PlayListBox->Items->Delete(index);
}
//---------------------------------------------------------------------------
void __fastcall TPlayerAreaForm::PasLibVlcMediaList1NextItemSet(TObject *Sender, WideString mrl,
          Pointer item, int index)
{
    if(index < MainForm->PlayListBox->Count)
    {
    	MainForm->PlayListBox->ItemIndex = index;
    }

    //EventsMemo->Lines->Add("Play " + mrl);
    MainForm->StatusBar1->SimpleText = "Playing " + mrl;
}
//---------------------------------------------------------------------------
/*void __fastcall TPlayerAreaForm::WMNCHitTest(TMessage &Msg)
{
    TForm::Dispatch(&Msg);

    if(Msg.Result == HTCLIENT)
    	Msg.Result = HTCAPTION;
}*/
//---------------------------------------------------------------------------
void __fastcall TPlayerAreaForm::PasLibVlcPlayer1MouseDown(TObject *Sender, TMouseButton Button,
          TShiftState Shift, int X, int Y)
{
    if(Button == mbLeft)
    {
        ReleaseCapture();
        SNDMSG(Handle, WM_SYSCOMMAND, SC_MOVE + HTCAPTION, 0);

        MainForm->PlayerAreaFrames[Tag]->XSpinEdit->OnChange = 0;
        MainForm->PlayerAreaFrames[Tag]->YSpinEdit->OnChange = 0;

    	MainForm->PageControl1->ActivePageIndex = Tag;

	    int m = MainForm->PlayerAreaFrames[Tag]->MonitorComboBox->ItemIndex;

        MainForm->PlayerAreaFrames[Tag]->XSpinEdit->Value = Left - Screen->Monitors[m]->Left;
        MainForm->PlayerAreaFrames[Tag]->YSpinEdit->Value = Top  - Screen->Monitors[m]->Top;

        MainForm->PlayerAreaFrames[Tag]->XSpinEdit->OnChange = MainForm->PlayerAreaFrames[Tag]->OnPlayerAreaChange;
        MainForm->PlayerAreaFrames[Tag]->YSpinEdit->OnChange = MainForm->PlayerAreaFrames[Tag]->OnPlayerAreaChange;
    }
}
//---------------------------------------------------------------------------
void __fastcall TPlayerAreaForm::PasLibVlcPlayer1MediaPlayerBuffering(TObject *Sender)
{
	MainForm->StatusBar1->SimpleText = PasLibVlcPlayer1->GetStateName();
}
//---------------------------------------------------------------------------

