L=2^12;PassBand=[100 10000];
Fs=48828;
FiltCoef=fc;%FiltCoef=zeros(1,256);

%Make a band of white noise
Freq=(1:L)/L*Fs/2; %Frequency vector (Real part only)
Iout_lo=find(Freq<min(PassBand));%Indeces to the outside of the passband
Iout_hi=find(Freq>max(PassBand));

Amp=ones(size(Freq)); %Amplitude spectrum
Amp(Iout_lo)=linspace(0,1,length(Iout_lo));
Amp(Iout_hi)=linspace(1,0,length(Iout_hi));

%Amp(Iout)=0; %Set the gain 0 for the outside of the passband
Phase=(rand(size(Amp))*2-1)*pi; %Phase spectrum -- random
x=Amp.*exp(sqrt(-1)*Phase); %Complex representation of the signal
Noise=RealIFFT(x); %Get the time representation
Noise=Cos2RampMs(Noise,1,Fs); %Apply 1ms ramps
%OrigSPL=20*log10(sqrt(mean(Noise.^2))); %SPL of the original noise 
Noise=[Noise zeros(size(Noise))]; %Double the # of points by padding with zeros
OrigSPL=20*log10(sqrt(mean(Noise.^2))); %SPL of the original noise 
FiltNoise=filter(FiltCoef,1,Noise); %FIR filtering
%Scale the signal so that the maximum unsigned amplitude is no greater than 10 V %%%SK
%RMS=sqrt(mean(FiltNoise(1:2*L).^2)); 
%RMS=sqrt(mean(FiltNoise.^2)); 
%Scale=10/max(abs(FiltNoise(:))); %%%SK
Scale=0.35/max(abs(FiltNoise(:)));
GainByScale=20*log10(Scale); %Gain in dB
FiltNoise=FiltNoise*Scale; %Scale the signal