FreqStr='1000 0';
SPLStr='80';
ITDStr='0';
FixEnvStr='0';
ILDStr='0';
DurationStr='0 1000 0 100';
%DurationStr='0 1000 0 0';
Fs=44000;

[Signal,Atten,TotalDurMs]=Tone(FreqStr,SPLStr,ITDStr,FixEnvStr,ILDStr,DurationStr,Fs);

sig=Signal(1,:);

nsig=length(sig);
perio=(1/Fs)*1000;% ms
tim=(0:perio:(perio*nsig));


% %Compute the spectrum
% myDataOut=DataOut([1:(2*L)]+DelayPtsByFilt); %Extract the part that contain the signal
% %myDataOut=myDataOut/MicSensitivityV*10.^(MicSensitivitySPL/20);
% AmpSpec=abs(fft(myDataOut)); %Amplitude spectrum

AmpSpec=abs(fft(sig)); %Amplitude spectrum
%AmpSpec=AmpSpec(1:L)/L; %%%%%%
AmpSpec_dB=20*log10(AmpSpec); %Spectrum in dB, for the positive frequency part

% %Get STD within the passband
% Iin=find(abs(Freq)>=min(PassBand) & abs(Freq)<=max(PassBand));
% STD=std(AmpSpec_dB(Iin));

% %Plot the result
% if PlotFlag
%     subplot(3,1,3)
%     plot(Freq/1000,AmpSpec_dB);
%     xlim([0 Fs/2/1000]);
%     title(sprintf('STD: %.1f dB; Filter Gain: %.1f dB',STD,GainByFilt));
%     xlabel('Frequency (kHz)')
%     ylabel('dB')
% end
L=nsig;
%Freq=(1:L)/L*Fs/2;
Freq=(1:L)/L*Fs;

figure;
subplot(2,2,1)
plot(tim,[0 sig]);grid on;

subplot(2,2,2)
plot(Freq/1000,AmpSpec_dB);grid on;
    xlim([0 Fs/2/1000]);
%     title(sprintf('STD: %.1f dB; Filter Gain: %.1f dB',STD,GainByFilt));
    xlabel('Frequency (kHz)')
    ylabel('dB')


% plot(Signal(2,:));grid on;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
FreqStr='1000 0';
SPLStr='80';
ITDStr='0';
FixEnvStr='0';
ILDStr='0';
DurationStr='0 1000 0 500';
%DurationStr='0 1000 0 0';
Fs=44000;

[Signal,Atten,TotalDurMs]=Tone(FreqStr,SPLStr,ITDStr,FixEnvStr,ILDStr,DurationStr,Fs);

sig=Signal(1,:);

nsig=length(sig);
perio=(1/Fs)*1000;% ms
tim=(0:perio:(perio*nsig));


% %Compute the spectrum
% myDataOut=DataOut([1:(2*L)]+DelayPtsByFilt); %Extract the part that contain the signal
% %myDataOut=myDataOut/MicSensitivityV*10.^(MicSensitivitySPL/20);
% AmpSpec=abs(fft(myDataOut)); %Amplitude spectrum

AmpSpec=abs(fft(sig)); %Amplitude spectrum
%AmpSpec=AmpSpec(1:L)/L; %%%%%%
AmpSpec_dB=20*log10(AmpSpec); %Spectrum in dB, for the positive frequency part

% %Get STD within the passband
% Iin=find(abs(Freq)>=min(PassBand) & abs(Freq)<=max(PassBand));
% STD=std(AmpSpec_dB(Iin));

% %Plot the result
% if PlotFlag
%     subplot(3,1,3)
%     plot(Freq/1000,AmpSpec_dB);
%     xlim([0 Fs/2/1000]);
%     title(sprintf('STD: %.1f dB; Filter Gain: %.1f dB',STD,GainByFilt));
%     xlabel('Frequency (kHz)')
%     ylabel('dB')
% end
L=nsig;
%Freq=(1:L)/L*Fs/2;
Freq=(1:L)/L*Fs;

subplot(2,2,3)
plot(tim,[0 sig]);grid on;

subplot(2,2,4)
plot(Freq/1000,AmpSpec_dB);grid on;
    xlim([0 Fs/2/1000]);
%     title(sprintf('STD: %.1f dB; Filter Gain: %.1f dB',STD,GainByFilt));
    xlabel('Frequency (kHz)')
    ylabel('dB')



