% This external file is included as part of the 'aim-mat' distribution package
% (c) 2011, University of Southampton
% Maintained by Stefan Bleeck (bleeck@gmail.com)
% download of current version is on the soundsoftware site: 
% http://code.soundsoftware.ac.uk/projects/aimmat
% documentation and everything is on http://www.acousticscale.org
function [target_signal,flanking_signal,only_regular_clicktrain,only_irregular_clicktrain]= ...
    gen_jittered_clicktrains(orgsig,jitter,delay,target_fre,flanker_fre,Gain,FlankerMode,FlankerDelay,grafix)
%
% this funtion produces the stimuli needed in Krumbholz et al 2003 and
% many other regular and irregular filted click trains
% the clicktrain can be pure when TargetFrequency is =0 otherwise the
% click train filted with a band pass filter around the given frequency
%
% input:
% orgsig: original signal. Determines length and samperate. SR must be 25000!
% jitter: 
%   the amount of jitter in % (0=regular, 100= maximal jitter)
% delay: 
%	the repetition rate of the signal in ms
% target_fre: 
%	one of the following:
% 	0 0.4 0.5657 0.8 1.1314 1.6 2.2627 3.2 4.5255 6.4
% 	if not precice, the nearest one will be taken
%   if 0, then no target will be generated
% flanker_fre: 
%	one of the following:
% 	0 0.4 0.5657 0.8 1.1314 1.6 2.2627 3.2 4.5255 6.4
% 	if not precice, the nearest one will be taken
%   if 0, then no flanker will be generated

% flanker_mode: 
%	one of the following:
% 	m: Flanker band synchronous and irregular (highest threshold)
% 	t: Flanker band synchronous and regular (medium threshold)
% 	td5: Flanker band synchronous and regular shifted in timepoints (lowest threshold)
% 	sb1: Masker regular, flanker band irregular (Ranjnas Experiment)
% 	sb2: Masker regular, flanker band regular, but time shifted (Ranjnas other stimulus)
% 	sb3: Masker irregular, flanker band regular, 
% 	sb4: NO masker, flanker band regular (returned in target_signal)

% flanker delay: 
% 	the delay of the synchronous clicks in ms
% Gain: 
%	the gain of the signal against the masker positiv direction: more signal
% grafix says, if we want to see a plot of the signal or not

% possible usage:
% produce the stimulus as in the paper:
% gen_jittered_clicktrains(signal(1,25000),0,10,1.6,3.2,10,'td5',5,1);
% play(gen_jittered_clicktrains(signal(1,25000),0,10,3.2,0.8,3,'td5',5))
% 
% to generate regular clicktrains use
% [a,b,c,d]=gen_jittered_clicktrains(signal(1,25000),0,10); play(c);
% 
% to generate 20 % jitter use:
% [a,b,c,d]=gen_jittered_clicktrains(signal(1,25000),0.2,10); play(d);
%
% to filter at 3.2 Khz generate 20 % jitter use:
% [a,b,c,d]=gen_jittered_clicktrains(signal(1,25000),0.2,10,3.2); play(d);
%
% to generate one of Ranjnas stimuli (regular masker at first frequency and irregular target
% in a different frequency band use) here: regular 40 dB louder then irregular
% play(gen_jittered_clicktrains(signal(1,25000),1,10,1.6,3.2,40,'sb1',NaN,1)/20)
% the shift parameter is here ignored
% 
%
% to generate one of Ranjnas stimuli (regular masker at first frequency and shifted target
% in a different frequency band use) here: regular 40 dB louder the shifted
% play(gen_jittered_clicktrains(signal(1,25000),NaN,10,1.6,3.2,40,'sb2',5,1))
% in this case the jitter is ignored

% return signals:
% target_signal is the target band with regular clicks plus irregular clicks with the ratio of "gain"
% flanking_signal is the flanking band which can be either regular or irregular
% only_regular_clicktrain is the regular clicks alone
% only_irregular_clicktrain is the irrregular clicks alone
% 
% % no random please!
% rand('state',0);

% input variables:
%  1        2      3          4       5      6             7        8
%(orgsig,jitter,delay,flanker_fre,Gain,FlankerMode,FlankerDelay,grafix);




if nargin <9	grafix=0;end
if nargin <8	FlankerDelay=5;	end
if nargin <7	FlankerMode='td5';end
if nargin <6	Gain=0;end
if nargin <5	flanker_fre=3.2;end
if nargin <4	target_fre=0;end
if nargin <3	delay=10;end
if nargin <2
	jitter=1; % 100 % jitter
end

if jitter >1
    disp('jitter must be smaller then 1 (100%)')
    jitter=1;
end

% possible Target and Flanker frequencies:
f(1)=0.4;
f(2)=0.5657;
f(3)=0.8;
f(4)=1.1314;
f(5)=1.6;
f(6)=2.2627;
f(7)=3.2;
f(8)=4.5255;
f(9)=6.4;

%    TargetFrq = 1.6; % fixed
% change into the directory with the filter coeffiencs in
orgdira=which('signal');
orgdir=fileparts(orgdira);
od=cd(fullfile(orgdir,'FIR filter coefficients'));

% load filter for Target
if target_fre==0
    TargetFrq=0;
else
    % load the filter file for the appropriate frequency for the target
	p=polyfit(1:9,log(f),1);
	targ=round(solve(p,log(target_fre)));
	TargetFrq = f(targ);
    targetFIRFile = sprintf('bp%gw%g',TargetFrq,0.2);
    targetFIRFile(findstr(targetFIRFile,'.')) = '_';
    FId = fopen([targetFIRFile '.txt'],'rt');
    fgetl(FId);
    targetFIR = fscanf(FId,'%g',151)';
    fclose(FId);
end
    
% load filter for Flanker
if flanker_fre==0
	FlankerFrq=0;
else
    % load the filter file for the appropriate frequency for the flanker
	p=polyfit(1:9,log(f),1);
	flank=round(solve(p,log(flanker_fre)));
	FlankerFrq = f(flank);
	flankerFIRFile = sprintf('bp%gw%g',FlankerFrq,0.2);
	flankerFIRFile(findstr(flankerFIRFile,'.')) = '_';
	FId = fopen([flankerFIRFile '.txt'],'rt');
	fgetl(FId);
	flankerFIR = fscanf(FId,'%g',151)';
	fclose(FId);
end
cd(od); % go back to the old directory

SR = 1000/getsr(orgsig);% all in ms 
sig_length =getlength(orgsig)*1000;
% the filter coefficients only work when the sr is 25000!
if getsr(orgsig)~=25000 && target_fre>0
    disp('gen_jittered_clicktrains::warning: filtering only works for a sample rate of 25000')
end

rise_time = 25;
timepoints = 0:SR:sig_length;
TPts = max(size(timepoints));
DigAmp = 1;
SDelay = round(delay/SR);

regular_clickstream = zeros(1,TPts);
regular_clickstream(1:SDelay:TPts) = DigAmp;

% RANDOMISE THE TARGET
irregular_clickstream = zeros(1,TPts);
%   randomisation in the range of the jitter boundary
jitter_time=SDelay*jitter;
% Idx = ceil(rand*SDelay*2);
idx = [];count=1;
while isempty(idx)|| max(idx)<TPts % go thorugh every cycle and jitter every pulse by a bit
    rand_click_offset=ceil(rand*jitter_time-jitter_time/2);
    if isempty(idx)
    	idx = count*SDelay+rand_click_offset;
    else
    	idx = [idx count*SDelay+rand_click_offset];
    end
    count=count+1;
end
idx=idx(1:end-1); % subtract the last one, because its after the end 
irregular_clickstream(idx)= DigAmp;

% RANDOMISE ALSO THE FLANKER
irregular_clickstream_2 = zeros(1,TPts);
%   randomisation in the range of the jitter boundary
jitter_time=SDelay*jitter;
% Idx = ceil(rand*SDelay*2);
idx = [];count=1;
while isempty(idx)|| max(idx)<TPts % go thorugh every cycle and jitter every pulse by a bit
    rand_click_offset=ceil(rand*jitter_time-jitter_time/2);
    if isempty(idx)
    	idx = count*SDelay+rand_click_offset;
    else
    	idx = [idx count*SDelay+rand_click_offset];
    end
    count=count+1;
end
idx=idx(1:end-1); % subtract the last one, because its after the end 
irregular_clickstream_2(idx)= DigAmp;


if strcmp(FlankerMode,'sb1') ||strcmp(FlankerMode,'sb2') % in this case the masker is always regular and the target irregular
    targetReg = envelope_signal(min(max(DigAmp*10^(Gain/20),DigAmp),regular_clickstream*10^(Gain/20)),rise_time,SR);
elseif strcmp(FlankerMode,'sb3') % in this case the target is irregular
    targetReg = envelope_signal(min(max(DigAmp*10^(Gain/20),DigAmp),irregular_clickstream*10^(Gain/20)),rise_time,SR);
elseif strcmp(FlankerMode,'sb4') % in this case there is no target
    targetReg = zeros(size(regular_clickstream));
else
    targetReg = envelope_signal(min(max(DigAmp*10^(Gain/20),DigAmp),regular_clickstream*10^(Gain/20)+irregular_clickstream),rise_time,SR);
end
targetIrr = envelope_signal(min(max(DigAmp*10^(Gain/20),DigAmp),irregular_clickstream_2*10^(Gain/20)+irregular_clickstream),rise_time,SR);

if FlankerFrq~=0
	if strcmp(FlankerMode,'td5') || strcmp(FlankerMode,'t')
		flanker = regular_clickstream;
	elseif strcmp(FlankerMode,'m')
		flanker = irregular_clickstream;
    elseif strcmp(FlankerMode,'sb1')
		flanker = irregular_clickstream;
    elseif strcmp(FlankerMode,'sb2')
		flanker = [zeros(1,round(FlankerDelay/SR)) regular_clickstream(1:TPts-round(FlankerDelay/SR))];
	elseif strcmp(FlankerMode,'sb3')
		flanker = regular_clickstream;
	elseif strcmp(FlankerMode,'sb4')
% 		flanker = regular_clickstream;
        flanker =envelope_signal(min(max(DigAmp*10^(-Gain/20),DigAmp),regular_clickstream*10^(-Gain/20)),rise_time,SR);
       
	end
	if FlankerDelay>0 && strcmp(FlankerMode,'td5')
		flanker = [zeros(1,round(FlankerDelay/SR)) flanker(1:TPts-round(FlankerDelay/SR))];
	end
else
	flanker = zeros(1,TPts);
end
flanker = envelope_signal(flanker,rise_time,SR);


% filter the resulting streams in the right frequency bands
if FlankerFrq~=0
	f_flanker=filter(flankerFIR,1,flanker);
else
	f_flanker=flanker;
end
if target_fre>0 % only filter, when neccessary
    f_targetReg=filter(targetFIR,1,targetReg);
    f_targetIrr=filter(targetFIR,1,targetIrr);
else
    f_targetReg=targetReg;
    f_targetIrr=targetIrr;
end

signal_flank=signal(f_flanker);
signal_flank=setsr(signal_flank,1000/SR);
target_signal=signal(f_targetReg);
flanking_signal=signal(f_targetIrr);
target_signal=setsr(target_signal,1000/SR);
flanking_signal=setsr(flanking_signal,1000/SR);
if strcmp(FlankerMode,'sb1') || strcmp(FlankerMode,'sb2')
    % in this case, the target is the signal plus the flanker:
    target_signal=target_signal+signal_flank;    
else
% Signal zu Flanker addieren (stimmt von der Amplitude her wohl nicht, aber
% f�r den Moment wirds tun)
    target_signal=target_signal+signal_flank;
    flanking_signal=flanking_signal+signal_flank;
end

%generate the pure random and regular click trains as well
only_regular_clickstream=envelope_signal(min(max(DigAmp*10^(Gain/20),DigAmp),regular_clickstream*10^(Gain/20)),rise_time,SR);
if target_fre>0 % only filter, when neccessary
    only_regular_clickstream=filter(targetFIR,1,only_regular_clickstream);
end
only_regular_clicktrain=signal(only_regular_clickstream);
only_regular_clicktrain=setsr(only_regular_clicktrain,1000/SR);
only_irregular_clickstream=envelope_signal(min(max(DigAmp*10^(Gain/20),DigAmp),irregular_clickstream*10^(Gain/20)),rise_time,SR);
if target_fre>0 % only filter, when neccessary
    only_irregular_clickstream=filter(targetFIR,1,only_irregular_clickstream);
end
only_irregular_clicktrain=signal(only_irregular_clickstream);
only_irregular_clicktrain=setsr(only_irregular_clicktrain,1000/SR);

% plotte ein paar h�bsche Bilder dazu
% figure(4)
% subplot(2,2,1)
% plot(target_signal);
% subplot(2,2,2)
% plot(powerspectrum(target_signal));
% subplot(2,2,3)
% plot(flanking_signal);
% subplot(2,2,4)
% plot(powerspectrum(flanking_signal));
% savewave(target_signal,'regular');
% savewave(flanking_signal,'irregular');

% savewave(target_signal,'stimulus');

if grafix
	figure(4)
	subplot(2,1,1)
	plot(target_signal);
	subplot(2,1,2)
	plot(powerspectrum(target_signal));
end

% ********** envelope_signal **********
function out = envelope_signal(in,rise_time,SR)
APts = length(in);
GPts = round(rise_time/SR);
if APts<2*GPts
	error('==> Signal must be loger than gate!') 
end
env = cos(pi*(0:GPts-1)/(2*(GPts-1))).^2;
out = [1-env ones(1,APts-2*GPts) env].*in;
