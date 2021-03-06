for k=1:length(D)
    D(k).CF=NaN;
    D(k).THR=NaN;
    D(k).thrfile=NaN;
    D(k).thrds=NaN;
    
    for n=1:length(Dthr36)
        if strcmp(Dthr36(n).ds.filename,D(k).ds1.filename)==1&...
                strncmp(Dthr36(n).ds.seqid,D(k).ds1.seqid,2)==1
            D(k).CF=Dthr36(n).thr.cf;
            D(k).THR=Dthr36(n).thr.minthr;
            D(k).thrfile=Dthr36(n).ds.filename;
            D(k).thrds=Dthr36(n).ds.seqid;
            
        end;
    end;
end;



for k=1:length(D)
    D(k).depth=NaN;
    
    for n=1:length(Dthr36)
        if strcmp(Dthr36(n).ds.filename,D(k).ds1.filename)==1&...
                strncmp(Dthr36(n).ds.seqid,D(k).ds1.seqid,2)==1
            D(k).depth=Dthr36(n).depth;
            
        end;
    end;
end;

for n=1:length(D)
    THR=evalthr(dataset(D(n).thrfile,D(n).thrds));close all
    D(n).thrfreq=THR.thr.freq;
    D(n).thrthr=THR.thr.thr;
    D(n).thrcf=THR.thr.cf;
    D(n).thrminthr=THR.thr.minthr;
    D(n).thrq10=THR.thr.q10;
    clear THR
    [CF,SR,minThr,BW,Qfactor]=evalthr(dataset(D(n).thrfile,D(n).thrds),'thr',40);close all
    D(n).thrq40=Qfactor;
end;
