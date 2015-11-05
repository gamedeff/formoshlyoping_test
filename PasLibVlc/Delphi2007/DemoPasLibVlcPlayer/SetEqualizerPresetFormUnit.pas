unit SetEqualizerPresetFormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, PasLibVlcClassUnit;

type
  TSetEqualizerPresetForm = class(TForm)
    PresetListLB: TListBox;
    OkBtn: TButton;
    CancelBtn: TButton;
    PresetListLabel: TLabel;
    BandInfoLB: TListBox;
    BandInfoLabel: TLabel;
    procedure PresetListLBClick(Sender: TObject);
  private
    { Private declarations }
  public
    FVLC : TPasLibVlc;
  end;

var
  SetEqualizerPresetForm: TSetEqualizerPresetForm;

implementation

{$R *.dfm}

procedure TSetEqualizerPresetForm.PresetListLBClick(Sender: TObject);
var
  equalizer : TPasLibVlcEqualizer;
  index : Integer;
begin
  BandInfoLB.Clear;
  if (PresetListLB.ItemIndex > -1) then
  begin
    equalizer := TPasLibVlcEqualizer.Create(
      FVLC,
      Word(PresetListLB.Items.Objects[PresetListLB.ItemIndex])
    );
    BandInfoLB.AddItem(
      'PreAmp: ' +  IntToStr(Round(equalizer.GetPreAmp())),
      NIL
    );
    for index := 0 to equalizer.GetBandCount() - 1 do
    begin
      BandInfoLB.AddItem(
        'Band no: ' + IntToStr(index+1) +
        ', freq.: ' + IntToStr(Round(equalizer.GetBandFrequency(index))) +
        'Hz, amp.:' + IntToStr(Round(equalizer.GetAmp(index))),
        NIL
      );
    end;
    equalizer.Free;
  end;
end;

end.
