//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "PlayerWindowUnit.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "PasLibVlcPlayerUnit"
#pragma resource "*.dfm"
TMainForm *MainForm;
//---------------------------------------------------------------------------
__fastcall TMainForm::TMainForm(TComponent* Owner)
	: TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TMainForm::FormCreate(TObject *Sender)
{
    PlayerAreaTabSheets = new TTabSheet*[PlayerAreaFormsSpinEdit->MaxValue];
    PlayerAreaFrames = new TPlayerFrame*[PlayerAreaFormsSpinEdit->MaxValue];
}
//---------------------------------------------------------------------------
void __fastcall TMainForm::FormDestroy(TObject *Sender)
{
    for(int i = 0; i < PlayerAreaFormsNum; ++i)
    {
    	delete PlayerAreaFrames[i]->PlayerAreaForm;
    	delete PlayerAreaFrames[i];
    	delete PlayerAreaTabSheets[i];
    }

    delete [] PlayerAreaFrames;
    delete [] PlayerAreaTabSheets;
}
//---------------------------------------------------------------------------
void __fastcall TMainForm::PlayerAreaFormsSpinEditEnter(TObject *Sender)
{
	PauseBtn->Caption = "4";
    StatusBar1->SimpleText = "";

    for(int i = 0; i < PlayerAreaFormsNum; ++i)
    {
    	delete PlayerAreaFrames[i]->PlayerAreaForm;
    	delete PlayerAreaFrames[i];
    	delete PlayerAreaTabSheets[i];
    }

    int sx = 10, sy = 10, x = sx, y = sy, w = 320, h = 240, m = 0;

    PlayerAreaFormsNum = PlayerAreaFormsSpinEdit->Value;

    for(int i = 0; i < PlayerAreaFormsNum; ++i)
    {
        PlayerAreaTabSheets[i] = new TTabSheet(PageControl1);
        PlayerAreaTabSheets[i]->Parent = PageControl1;
        PlayerAreaTabSheets[i]->PageControl = PageControl1;

        PlayerAreaTabSheets[i]->Name = "PlayerAreaTabSheet" + IntToStr(i + 1);
        PlayerAreaTabSheets[i]->Caption = "Область " + IntToStr(i + 1);

        PlayerAreaFrames[i] = new TPlayerFrame(PlayerAreaTabSheets[i]);
        PlayerAreaFrames[i]->Parent = PlayerAreaTabSheets[i];

        PlayerAreaFrames[i]->Name = "PlayerAreaFrame" + IntToStr(i + 1);

        PlayerAreaFrames[i]->XSpinEdit->Value = x;
        PlayerAreaFrames[i]->YSpinEdit->Value = y;
        PlayerAreaFrames[i]->WSpinEdit->Value = w;
        PlayerAreaFrames[i]->HSpinEdit->Value = h;

//        for(int k = 0; k < Screen->MonitorCount; ++k)
//        {
//	        MONITORINFOEX MonitorInfo = { 0 };
//            ::GetMonitorInfo(Screen->Monitors[k]->Handle, &MonitorInfo);
//            PlayerAreaFrames[i]->MonitorComboBox->Items->Append(UnicodeString(MonitorInfo.szDevice) + " (" + IntToStr(k) + ")");
//
//        }
        DISPLAY_DEVICE dd;
        dd.cb = sizeof(dd);
        int deviceIndex = 0;
        while(EnumDisplayDevices(0, deviceIndex, &dd, 0))
        {
            UnicodeString deviceName = dd.DeviceName;
            int monitorIndex = 0;
            while(EnumDisplayDevices(deviceName.c_str(), monitorIndex, &dd, 0))
            {
                //std::wcout << dd.DeviceName << L", " << dd.DeviceString << L"\n";
                PlayerAreaFrames[i]->MonitorComboBox->Items->Append(UnicodeString(dd.DeviceString) + " (" + IntToStr(monitorIndex) + ")");
                ++monitorIndex;
            }
            ++deviceIndex;
        }

        PlayerAreaFrames[i]->MonitorComboBox->ItemIndex = m;

        PlayerAreaFrames[i]->XSpinEdit->OnChange = PlayerAreaFrames[i]->OnPlayerAreaChange;
        PlayerAreaFrames[i]->YSpinEdit->OnChange = PlayerAreaFrames[i]->OnPlayerAreaChange;
        PlayerAreaFrames[i]->WSpinEdit->OnChange = PlayerAreaFrames[i]->OnPlayerAreaChange;
        PlayerAreaFrames[i]->HSpinEdit->OnChange = PlayerAreaFrames[i]->OnPlayerAreaChange;
        PlayerAreaFrames[i]->MonitorComboBox->OnChange = PlayerAreaFrames[i]->OnPlayerAreaChange;

        PageControl1->ActivePage = PlayerAreaTabSheets[i];

        x += sx + w;
        if(x + sx + w > Screen->Monitors[m]->WorkareaRect.Width())
        {
            x = sx;
            y += sy + h;
            if(y + sy + h > Screen->Monitors[m]->WorkareaRect.Height() && m < Screen->MonitorCount - 1)
            {
                y = sy;
                ++m;
            }
        }

    	PlayerAreaFrames[i]->PlayerAreaForm = new TPlayerAreaForm(this);
    }

    ClearBtnClick(this);

    for(int i = 0; i < PlayerAreaFormsNum; ++i)
    {
        PlayerAreaFrames[i]->PlayerAreaForm->PasLibVlcMediaList1->Add("http://www.youtube.com/watch?v=4AnpQfd7PGI");
        PlayerAreaFrames[i]->PlayerAreaForm->PasLibVlcMediaList1->Add("http://www.youtube.com/watch?v=Bh_sV058aLU");
    }

    //PlayListBox->Items->Clear();
    for(int i = 0; i < PlayerAreaFrames[0]->PlayerAreaForm->PasLibVlcMediaList1->Count(); ++i)
    	if(PlayListBox->Items->IndexOf(PlayerAreaFrames[0]->PlayerAreaForm->PasLibVlcMediaList1->Get(i)) == -1)
    		PlayListBox->Items->Append(PlayerAreaFrames[0]->PlayerAreaForm->PasLibVlcMediaList1->Get(i));

    for(int i = 0; i < PlayerAreaFormsNum; ++i)
    {
        PlayerAreaFrames[i]->PlayerAreaForm->Tag = i;

        if(i > 0)
        {
        	PlayerAreaFrames[i]->PlayerAreaForm->PasLibVlcPlayer1->OnMediaPlayerEndReached = 0;
            PlayerAreaFrames[i]->PlayerAreaForm->PasLibVlcPlayer1->OnMediaPlayerLengthChanged = 0;
			PlayerAreaFrames[i]->PlayerAreaForm->PasLibVlcPlayer1->OnMediaPlayerTimeChanged = 0;
        }

    	PlayerAreaFrames[i]->OnPlayerAreaChange(this);

    	PlayerAreaFrames[i]->PlayerAreaForm->Show();
    }
}
//---------------------------------------------------------------------------
void __fastcall TMainForm::PlayModeLoopBtnClick(TObject *Sender)
{
    for(int i = 0; i < PlayerAreaFormsNum; ++i)
    {
        PlayerAreaFrames[i]->PlayerAreaForm->PasLibVlcMediaList1->SetPlayModeLoop();
    }
}
//---------------------------------------------------------------------------
void __fastcall TMainForm::PlayModeNormalBtnClick(TObject *Sender)
{
    for(int i = 0; i < PlayerAreaFormsNum; ++i)
    {
        PlayerAreaFrames[i]->PlayerAreaForm->PasLibVlcMediaList1->SetPlayModeNormal();
    }
}
//---------------------------------------------------------------------------
void __fastcall TMainForm::PlayModeRepeatBtnClick(TObject *Sender)
{
    for(int i = 0; i < PlayerAreaFormsNum; ++i)
    {
        PlayerAreaFrames[i]->PlayerAreaForm->PasLibVlcMediaList1->SetPlayModeRepeat();
    }
}
//---------------------------------------------------------------------------
void __fastcall TMainForm::PlayListBoxClick(TObject *Sender)
{
    if(PlayListBox->ItemIndex < 0) return;
    if(PlayListBox->ItemIndex >= PlayListBox->Count) return;

    // check for item stil exists in play list
    //TObject *item = PlayListBox->Items->Objects[PlayListBox->ItemIndex];

    int idx = PlayListBox->ItemIndex; //PlayerAreaFrames[i]->PlayerAreaForm->PasLibVlcMediaList1->IndexOfItem(item);

    for(int i = 0; i < PlayerAreaFormsNum; ++i)
    {
        // if exists then play it
        if(idx > -1)
        {
			PlayerAreaFrames[i]->PlayerAreaForm->PasLibVlcMediaList1->PlayItem(PlayerAreaFrames[i]->PlayerAreaForm->PasLibVlcMediaList1->GetItemAtIndex(idx));
        }
    }

    for(int i = 0; i < PlayerAreaFormsNum; ++i)
	{
        PauseBtn->Caption = ";";
        StatusBar1->SimpleText = "Playing " + PlayerAreaFrames[i]->PlayerAreaForm->PasLibVlcMediaList1->Get(idx);
    }
}
//---------------------------------------------------------------------------
void __fastcall TMainForm::NextBtnClick(TObject *Sender)
{
    for(int i = 0; i < PlayerAreaFormsNum; ++i)
    {
        PlayerAreaFrames[i]->PlayerAreaForm->PasLibVlcMediaList1->Next();
        StatusBar1->SimpleText = PlayerAreaFrames[i]->PlayerAreaForm->PasLibVlcMediaList1->GetStateName();
    }
}
//---------------------------------------------------------------------------
void __fastcall TMainForm::PauseBtnClick(TObject *Sender)
{
    if(PauseBtn->Caption == ";")    {        for(int i = 0; i < PlayerAreaFormsNum; ++i)
        {
            PlayerAreaFrames[i]->PlayerAreaForm->PasLibVlcMediaList1->Pause();
        	StatusBar1->SimpleText = "Playing [paused] " + PlayerAreaFrames[i]->PlayerAreaForm->PasLibVlcMediaList1->Player->GetMediaMrl();        }
    	TrackBar->OnChange = TrackBarChange;

    	PauseBtn->Caption = "4";    }    else    {        for(int i = 0; i < PlayerAreaFormsNum; ++i)
        {
            PlayerAreaFrames[i]->PlayerAreaForm->PasLibVlcMediaList1->Play();
        	StatusBar1->SimpleText = "Playing " + PlayerAreaFrames[i]->PlayerAreaForm->PasLibVlcMediaList1->Player->GetMediaMrl();
        }

        TrackBar->OnChange = 0;

    	PauseBtn->Caption = ";";    }}
//---------------------------------------------------------------------------
void __fastcall TMainForm::PrevBtnClick(TObject *Sender)
{
    for(int i = 0; i < PlayerAreaFormsNum; ++i)
    {
        PlayerAreaFrames[i]->PlayerAreaForm->PasLibVlcMediaList1->Prev();
        StatusBar1->SimpleText = PlayerAreaFrames[i]->PlayerAreaForm->PasLibVlcMediaList1->GetStateName();
    }
}
//---------------------------------------------------------------------------
void __fastcall TMainForm::StopBtnClick(TObject *Sender)
{
    for(int i = 0; i < PlayerAreaFormsNum; ++i)
    {
        PlayerAreaFrames[i]->PlayerAreaForm->PasLibVlcMediaList1->Stop();
        PauseBtn->Caption = "4";
        StatusBar1->SimpleText = PlayerAreaFrames[i]->PlayerAreaForm->PasLibVlcMediaList1->GetStateName();
    }
}
//---------------------------------------------------------------------------
void __fastcall TMainForm::TrackBarChange(TObject *Sender)
{
    for(int i = 0; i < PlayerAreaFormsNum; ++i)
    {
        if(PlayerAreaFrames[i]->PlayerAreaForm->PasLibVlcPlayer1->CanSeek())
        {
            PlayerAreaFrames[i]->PlayerAreaForm->PasLibVlcPlayer1->SetVideoPosInMs(TrackBar->Position);
            PlayerAreaFrames[i]->PlayerAreaForm->PasLibVlcPlayer1MediaPlayerTimeChanged(this, TrackBar->Position);
        }
    }
}
//---------------------------------------------------------------------------
void __fastcall TMainForm::OpenSpeedButtonClick(TObject *Sender)
{
	if(OpenDialog1->Execute())
    {
        NewPlayListItemEdit->Text = OpenDialog1->FileName;
    }
}
//---------------------------------------------------------------------------
void __fastcall TMainForm::AddSpeedButtonClick(TObject *Sender)
{
    for(int i = 0; i < PlayerAreaFormsNum; ++i)
    {
        PlayerAreaFrames[i]->PlayerAreaForm->PasLibVlcMediaList1->Add(NewPlayListItemEdit->Text);
    }

    int i = PlayerAreaFrames[0]->PlayerAreaForm->PasLibVlcMediaList1->Count() - 1;
    PlayListBox->Items->AddObject(PlayerAreaFrames[0]->PlayerAreaForm->PasLibVlcMediaList1->Get(i),
        						  reinterpret_cast<TObject *>(PlayerAreaFrames[0]->PlayerAreaForm->PasLibVlcMediaList1->GetItemAtIndex(i)));

}
//---------------------------------------------------------------------------
void __fastcall TMainForm::ClearBtnClick(TObject *Sender)
{
    for(int i = 0; i < PlayerAreaFormsNum; ++i)
    {
        PlayerAreaFrames[i]->PlayerAreaForm->PasLibVlcMediaList1->Clear();
    }
}
//---------------------------------------------------------------------------

