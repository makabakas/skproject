function S = THRrec(dev, ToneFreq, BurstDur, NonBurstDur, MinSPL, MaxSPL, StartSPL, StepSPL, DAchan, SpikeDiffCrit, MaxNpres);
% THRrec - adaptive measurement of tonal threshold for one frequency
% Usage:
%   THRrec(dev, ToneFreq, BurstDur, NonBurstDur, MinSPL, MaxSPL, StartSPL, StepSPL, DAchan, SpikeDiffCrit, MaxNpres);
%   Helper function of THRcurve.
%   THR Circuit must be loaded at call time.
 
CI = sys3circuitinfo(dev);
Fsam = CI.Fsam;


% amplitudes
NSPL = 1+round((MaxSPL-MinSPL)/StepSPL);
SPL = linspace(MinSPL, MaxSPL, NSPL);
DL = calibrate(EXP, Fsam*1e3, DAchan, ToneFreq);

% Generate waveforms to be able to use maxSPL
P.Fcar = ToneFreq;　% PはProbe toneという意味か？
P.BurstDur = 100;
P.ISI = 100;
P.DAC = DAchan;
P.FreqTolMode = 'exact';
[P.ModFreq, P.ModDepth, P.ModStartPhase, P.ModTheta, ...
    P.OnsetDelay, P.RiseDur, P.FallDur, P.WavePhase, ...
    P.FineITD, P.GateITD, P.ModITD] = deal(0);% []内の変数に全て0を割り当てる。
Attenuations = zeros(1,length(SPL));
NumScales = zeros(1,length(SPL));
for i=1:length(SPL)
    P.SPL = SPL(i);
    P = toneStim(P);% THR\helpers\toneStim.mを使ってP.Fcar=ToneFreqの周波数を持つToneを作る。これをSPLの数だけ繰り返す。
    % Calculate attenuation values using maxSPL
    [dum, Attenuation] = maxSPL(P.Waveform, EXP);% ここでProbe toneを実際に提示するAttenを決める。THR\@Waveform\maxSPL.mを使う。これをFiltGainやFiltGoefと組み合わせると応用できるか。
    Attenuations(i) = Attenuation.AnaAtten;
    NumScales(i) = Attenuation.NumScale;
end

LinAmp = sqrt(2)*db2a(SPL+DL).*NumScales;
sys3write(LinAmp, 'ToneAmpBuf', dev);
[dum, iStart] = min(abs(SPL-StartSPL));
sys3setpar(iStart-1, 'iAmp', dev); % -1 because of min index = 0
SetAttenuators(EXP, Attenuations(iStart));% SetAttenuator.mが見つからない。Leuvenに問い合わせるか？

% freq, timing, thr criterion
sys3setpar(ToneFreq, 'ToneFreq', dev);
sys3setpar(BurstDur, 'BurstDur', dev);
sys3setpar(NonBurstDur, 'NonBurstDur', dev);


% read amplitude history
iAmpHist = [];
i = 0;
while 1,
    i = i + 1;
    % GO
    sys3setpar(1, 'Run', 'RX6');
    pause((BurstDur+NonBurstDur)/1e3);
    sys3setpar(0, 'Run', 'RX6');
    iAmp = sys3getpar('iAmp', dev) + 1;% iAmpを１増やす。
    iAmpHist(end+1) = iAmp;
    [isReady, Thr] = local_thr(iAmpHist, MaxNpres, SPL);%３回同じAmpで提示したらThrとみなせるという意味？
    if isReady
        break;%その周波数の閾値決定して終了という意味？
    else
        SpikeDiff = sys3getpar('SpikeDiff', dev);%SpikeDiffは音刺激中のspike countから音が終わった後の自発発火のspike countをひいたものか。
        if SpikeDiff <= SpikeDiffCrit
            iAmpNew = iAmp + 2;%発火がSpikeDiffCritに達しなければiAmpを２増やして音圧を大きくする。ただしSpikeDiffCritをどの程度にすべきかはまだ不明。
        else
            iAmpNew = iAmp - 1;%発火がSpikeDiffCritに達していればiAmpを１減らして音圧を小さくする。2U1Dを採用しているようだ。
        end
        
        if iAmpNew > NSPL || iAmpNew < 1
            error('Amplitude out of bounds');%iAmpNewが用意していたリストにない場合
        else
            iAmp = iAmpNew;%iAmpを更新してループの次のiに備える
        end
        
        sys3setpar(iAmp-1, 'iAmp', dev);
        SetAttenuators(EXP, Attenuations(iAmp));
    end;
end
sys3setpar(0, 'Run', 'RX6'); % stop playing

% return arg
AmpHist = SPL(iAmpHist);
ExpName = name(EXP);
S = collectInStruct(ExpName, ToneFreq, MinSPL, MaxSPL, StartSPL, StepSPL, SPL, DAchan, SpikeDiffCrit, '-', iAmpHist, AmpHist, Thr);

%=============================================================
function [isReady, Thr] = local_thr(iAmp, Nmax, SPL);
% criterion
Thr = nan;
isReady = 0;
Namp = numel(iAmp);
for i=7:Namp
    % check if previous level was higher & if level was the same three presentations ago
    isReady = (iAmp(i-1) > iAmp(i)) && (iAmp(i-3) == iAmp(i)); %%&& (iAmp(i-6) == iAmp(i)));３回同じAmpで提示したらThrとみなせるという意味？
    if isReady,
        Thr = SPL(iAmp(i));
        break;
    end
end
if Namp>Nmax,
    isReady = 1;
end



%================
%      Name: 'ToneFreq'
%     DataType: 'SingleFloat'
%      TagSize: 1
%  
%         Name: 'ToneAmpBuf'
%     DataType: 'DataBuffer'
%      TagSize: 1000
%  
%         Name: 'iStartAmp'
%     DataType: 'Integer'
%      TagSize: 1
%  
%         Name: 'SpikeDiffCrit'
%     DataType: 'Integer'
%      TagSize: 1
%  
%         Name: 'AmpHistory'
%     DataType: 'DataBuffer'
%      TagSize: 10000
% 
%         Name: 'Run'
%     DataType: 'Logical'
%      TagSize: 1
%  
%         Name: 'BurstDur'
%     DataType: 'SingleFloat'
%      TagSize: 1
%  
%         Name: 'NonBurstDur'
%     DataType: 'SingleFloat'
%      TagSize: 1
%  


