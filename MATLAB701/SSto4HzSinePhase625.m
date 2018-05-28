% SS to 4HzSinePhase 625points
function DFT4=SSto4HzSinePhase625(V)
FFT=fft(V);
FFT(1)=[];
RFFT=[FFT(1:(length(FFT)/2))];
Amp=abs(RFFT/(length(FFT)/2));
nyquist=1/2/0.0016;
FreqAxis=(1:length(RFFT))/(length(FFT)/2)*nyquist;
% DFT graph
subplot(3,1,1);
semilogx(FreqAxis,Amp),grid;
axis([1 20 0 10]);
DFT4=Amp(4);
assignin('base',[inputname(1) 'DFTvalue'],DFT4);
% SS wave and 4Hz sine wave
T=[-0.5:0.0016:(-0.5+(624*0.0016))];
Y=(real(RFFT(4))*cos(2*pi*FreqAxis(4)*T)-imag(RFFT(4))*sin(2*pi*FreqAxis(4)*T))/(625/2);
subplot(3,1,2);
plot(T,V,'k-',T,Y,'r-'),grid;
axis([-0.500 0.500 -10 10]);
set(gca,'xtick',[-0.375 -0.125 0 0.125 0.375]);
% Phase analysis
T1=[-0.125:0.0016:(-0.125+(156*0.0016))];
y=(real(RFFT(4))*cos(2*pi*FreqAxis(4)*T1)-imag(RFFT(4))*sin(2*pi*FreqAxis(4)*T1))/(625/2);
[Max,MaxPhaseI]=max(y);
if (T1(MaxPhaseI))/0.25<-0.125
    ZeroPhase=((T1(MaxPhaseI))/0.25)+0.75;
    MaxPhase=(T1(MaxPhaseI))/0.25;
    SineAmp=Max;
else
    ZeroPhase=((T1(MaxPhaseI))/0.25)-0.25;
    MaxPhase=(T1(MaxPhaseI))/0.25;
    SineAmp=Max;
end;
PhaseAndAmp=[ZeroPhase;MaxPhase;SineAmp];
assignin('base',[inputname(1) 'PhaseAndAmp'],PhaseAndAmp);    
subplot(3,1,3);
plot(ZeroPhase,0,'bx',MaxPhase,SineAmp,'ro',ZeroPhase,SineAmp,'bo'),grid;
axis([-0.5 0.5 -10 10]);
set(gca,'xtick',[-0.5 -0.25 0 0.25 0.5]);
end

