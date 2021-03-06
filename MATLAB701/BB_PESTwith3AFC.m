% BB_PESTwith3AFC
function RESULT=BB_PESTwith3AFC(F0,F1,W1,Z,p)
t=(1:(1/8192):3.5);
NoBB=[(sin(2*pi*t*F0))' (sin(2*pi*t*F0))'];
ISI2s=zeros([(8192*2),2]);
% Tnumber=1
Tnumber(1,1)=1;
Width(1,1)=W1;
Freq(1,1)=F1;
BB=[(sin(2*pi*t*F0))' (sin(2*pi*t*Freq(1,1)))'];
BBinterval(1,1)=unidrnd(3);
if BBinterval(1,1)==1
    Trial=[BB;ISI2s;NoBB;ISI2s;NoBB];
elseif BBinterval(1,1)==2
    Trial=[NoBB;ISI2s;BB;ISI2s;NoBB];
else
    Trial=[NoBB;ISI2s;NoBB;ISI2s;BB];
end;
sound(Trial)
Ans(1,1)=input('Which is BB? 1, 2 or 3?');
if Ans(1,1)==BBinterval(1,1)
    Judge(1,1)=1;C(1,1)=1;
else
    Judge(1,1)=0;C(1,1)=0;
end;
Tcurrent(1,1)=1;
X(1,1)=p*Tcurrent(1,1)-C(1,1);
if p*Tcurrent(1,1)-C(1,1)<=-1
    Direction(1,1)=-1;Tcurrent(1,2)=1;
elseif p*Tcurrent(1,1)-C(1,1)>=1
    Direction(1,1)=1;Tcurrent(1,2)=1;
else
    Direction(1,1)=0;Tcurrent(1,2)=Tcurrent(1,1)+1;
end;
Reverse(1,1)=0;
DirectionSum(1,1)=0;
DirectionSum(1,2)=DirectionSum(1,1)+Direction(1,1);
DoubleMark(1,1)=0;RevAfterDouble(1,1)=0;
Freq(1,2)=Freq(1,1)+Direction(1,1)*Width(1,1);
% Tnumber=2
Tnumber(1,2)=2;
BB=[(sin(2*pi*t*F0))' (sin(2*pi*t*Freq(1,2)))'];
BBinterval(1,2)=unidrnd(3);
if BBinterval(1,2)==1
    Trial=[BB;ISI2s;NoBB;ISI2s;NoBB];
elseif BBinterval(1,2)==2
    Trial=[NoBB;ISI2s;BB;ISI2s;NoBB];
else
    Trial=[NoBB;ISI2s;NoBB;ISI2s;BB];
end;
sound(Trial)
Ans(1,2)=input('Which is BB? 1, 2 or 3?');
if Ans(1,2)==BBinterval(1,2)
    Judge(1,2)=1;
    if Freq(1,2)==Freq(1,1)
        C(1,2)=C(1,1)+1;
    else
        C(1,2)=1;
    end;
else
    Judge(1,1)=0;
    if Freq(1,2)==Freq(1,1)
        C(1,2)=C(1,1);
    else
        C(1,2)=0;
    end;
end;
X(1,2)=p*Tcurrent(1,2)-C(1,2);
if p*Tcurrent(1,2)-C(1,2)<=-1
    Direction(1,2)=-1;Tcurrent(1,3)=1;
elseif p*Tcurrent(1,2)-C(1,2)>=1
    Direction(1,2)=1;Tcurrent(1,3)=1;
else
    Direction(1,2)=0;Tcurrent(1,3)=Tcurrent(1,2)+1;
end;
if Direction(1,1)*Direction(1,2)<0
    Reverse(1,2)=1;Width(1,2)=Width(1,1)*0.5;
    DirectionSum(1,3)=0;
    DoubleMark(1,2)=0;RevAfterDouble(1,2)=Reverse(1,1)*DoubleMark(1,2);
else
    Reverse(1,2)=0;Width(1,2)=Width(1,1);
    DirectionSum(1,3)=DirectionSum(1,2)+Direction(1,2);
    DoubleMark(1,2)=0;RevAfterDouble(1,2)=Reverse(1,1)*DoubleMark(1,2);
end;
Freq(1,3)=Freq(1,2)+Direction(1,2)*Width(1,2);
% Tnumber=3
Tnumber(1,3)=3;
BB=[(sin(2*pi*t*F0))' (sin(2*pi*t*Freq(1,3)))'];
BBinterval(1,3)=unidrnd(3);
if BBinterval(1,2)==1
    Trial=[BB;ISI2s;NoBB;ISI2s;NoBB];
elseif BBinterval(1,2)==2
    Trial=[NoBB;ISI2s;BB;ISI2s;NoBB];
else
    Trial=[NoBB;ISI2s;NoBB;ISI2s;BB];
end;
sound(Trial)
Ans(1,3)=input('Which is BB? 1, 2 or 3?');
if Ans(1,3)==BBinterval(1,3)
    Judge(1,3)=1;
    if Freq(1,3)==Freq(1,2)
        C(1,3)=C(1,2)+1;
    else
        C(1,3)=1;
    end;
else
    Judge(1,3)=0;
    if Freq(1,3)==Freq(1,2)
        C(1,3)=C(1,2);
    else
        C(1,3)=0;
    end;
end;
X(1,3)=p*Tcurrent(1,3)-C(1,3);
if p*Tcurrent(1,3)-C(1,3)<=-1
    Direction(1,3)=-1;Tcurrent(1,4)=1;
elseif p*Tcurrent(1,3)-C(1,3)>=1
    Direction(1,3)=1;Tcurrent(1,4)=1;
else
    Direction(1,3)=0;Tcurrent(1,4)=Tcurrent(1,3)+1;
end;
DirectionSum(1,3)=DirectionSum(1,2)+Direction(1,3);
if Direction(1,3)*Direction(1,2)<0
    Reverse(1,3)=1;Width(1,3)=Width(1,2)*0.5;
    DirectionSum(1,4)=0;
    DoubleMark(1,3)=0;RevAfterDouble(1,3)=Reverse(1,2)*DoubleMark(1,3);
elseif (Direction(1,1)*Direction(1,2)==1)&(Direction(1,2)*Direction(1,3)==1)
    Reverse(1,3)=0;Width(1,3)=Width(1,2)*2;
    DirectionSum(1,4)=DirectionSum(1,3)+Direction(1,3);
    DoubleMark(1,3)=1;RevAfterDouble(1,3)=Reverse(1,2)*DoubleMark(1,3);
else
    Reverse(1,3)=0;Width(1,3)=Width(1,2);
    DirectionSum(1,4)=DirectionSum(1,3)+Direction(1,3);
    DoubleMark(1,3)=0;RevAfterDouble(1,3)=Reverse(1,2)*DoubleMark(1,3);
end;
Freq(1,4)=Freq(1,3)+Direction(1,3)*Width(1,3);
% Tnumber=4
Tnumber(1,4)=4;
BB=[(sin(2*pi*t*F0))' (sin(2*pi*t*Freq(1,4)))'];
BBinterval(1,4)=unidrnd(3);
if BBinterval(1,4)==1
    Trial=[BB;ISI2s;NoBB;ISI2s;NoBB];
elseif BBinterval(1,4)==2
    Trial=[NoBB;ISI2s;BB;ISI2s;NoBB];
else
    Trial=[NoBB;ISI2s;NoBB;ISI2s;BB];
end;
sound(Trial)
Ans(1,4)=input('Which is BB? 1, 2 or 3?');
if Ans(1,4)==BBinterval(1,4)
    Judge(1,4)=1;
    if Freq(1,4)==Freq(1,3)
        C(1,4)=C(1,3)+1;
    else
        C(1,4)=1;
    end;
else
    Judge(1,4)=0;
    if Freq(1,4)==Freq(1,3)
        C(1,4)=C(1,3);
    else
        C(1,4)=0;
    end;
end;
X(1,4)=p*Tcurrent(1,4)-C(1,4);
if p*Tcurrent(1,4)-C(1,4)<=-1
    Direction(1,4)=-1;Tcurrent(1,5)=1;
elseif p*Tcurrent(1,4)-C(1,4)>=1
    Direction(1,4)=1;Tcurrent(1,5)=1;
else
    Direction(1,4)=0;Tcurrent(1,5)=Tcurrent(1,4)+1;
end;
if Direction(1,4)*Direction(1,3)<0
    Reverse(1,4)=1;Width(1,4)=Width(1,3)*0.5;
    DirectionSum(1,5)=0;
    DoubleMark(1,4)=0;RevAfterDouble(1,4)=Reverse(1,3)*DoubleMark(1,4);
elseif (Direction(1,2)*Direction(1,3)==1)&(Direction(1,3)*Direction(1,4)==1)
    Reverse(1,4)=0;Width(1,4)=Width(1,3)*2;
    DirectionSum(1,5)=DirectionSum(1,4)+Direction(1,4);
    DoubleMark(1,4)=1;RevAfterDouble(1,4)=Reverse(1,3)*DoubleMark(1,4);
else    
    Reverse(1,4)=0;Width(1,4)=Width(1,3);
    DirectionSum(1,5)=DirectionSum(1,4)+Direction(1,4);
    DoubleMark(1,4)=0;RevAfterDouble(1,4)=Reverse(1,3)*DoubleMark(1,4);
end;
Freq(1,5)=Freq(1,4)+Direction(1,4)*Width(1,4);
% Tnumber=5
Tnumber(1,5)=5;
BB=[(sin(2*pi*t*F0))' (sin(2*pi*t*Freq(1,5)))'];
BBinterval(1,5)=unidrnd(3);
if BBinterval(1,5)==1
    Trial=[BB;ISI2s;NoBB;ISI2s;NoBB];
elseif BBinterval(1,5)==2
    Trial=[NoBB;ISI2s;BB;ISI2s;NoBB];
else
    Trial=[NoBB;ISI2s;NoBB;ISI2s;BB];
end;
sound(Trial)
Ans(1,5)=input('Which is BB? 1, 2 or 3?');
if Ans(1,5)==BBinterval(1,5)
    Judge(1,5)=1;
    if Freq(1,5)==Freq(1,4)
        C(1,5)=C(1,4)+1;
    else
        C(1,5)=1;
    end;
else
    Judge(1,5)=0;
    if Freq(1,5)==Freq(1,4)
        C(1,5)=C(1,4);
    else
        C(1,5)=0;
    end;
end;
X(1,5)=p*Tcurrent(1,5)-C(1,5);
if p*Tcurrent(1,5)-C(1,5)<=-1
    Direction(1,5)=-1;Tcurrent(1,6)=1;
elseif p*Tcurrent(1,5)-C(1,5)>=1
    Direction(1,5)=1;Tcurrent(1,6)=1;
else
    Direction(1,5)=0;Tcurrent(1,6)=Tcurrent(1,5)+1;
end;
if Direction(1,5)*Direction(1,4)<0
    Reverse(1,5)=1;Width(1,5)=Width(1,4)*0.5;
    DirectionSum(1,6)=0;
    DoubleMark(1,5)=0;RevAfterDouble(1,5)=Reverse(1,4)*DoubleMark(1,5);
elseif (Direction(1,3)*Direction(1,4)==1)&(Direction(1,4)*Direction(1,5)==1)
    Reverse(1,5)=0;Width(1,5)=Width(1,4)*2;
    DirectionSum(1,6)=DirectionSum(1,5)+Direction(1,5);
    DoubleMark(1,5)=1;RevAfterDouble(1,5)=Reverse(1,4)*DoubleMark(1,5);
else
    Reverse(1,5)=0;Width(1,5)=Width(1,4);
    DirectionSum(1,6)=DirectionSum(1,5)+Direction(1,5);
    DoubleMark(1,5)=0;RevAfterDouble(1,5)=Reverse(1,4)*DoubleMark(1,5);
end;
Freq(1,6)=Freq(1,5)+Direction(1,5)*Width(1,5);
% Tnumber>=6
for m=6:Z
    Tnumber(1,m)=m;
    BB=[(sin(2*pi*t*F0))' (sin(2*pi*t*Freq(1,m)))'];
    BBinterval(1,m)=unidrnd(3);
    if BBinterval(1,m)==1
        Trial=[BB;ISI2s;NoBB;ISI2s;NoBB];
    elseif BBinterval(1,m)==2
        Trial=[NoBB;ISI2s;BB;ISI2s;NoBB];
    else
        Trial=[NoBB;ISI2s;NoBB;ISI2s;BB];
    end;
    sound(Trial)
    Ans(1,m)=input('Which is BB? 1, 2 or 3?');
    if Ans(1,m)==BBinterval(1,m)
        Judge(1,m)=1;
        if Freq(1,m)==Freq(1,(m-1))
            C(1,m)=C(1,(m-1))+1;
        else
            C(1,m)=1;
        end;
    else
        Judge(1,m)=0;
        if Freq(1,m)==Freq(1,(m-1))
            C(1,m)=C(1,(m-1));
        else
            C(1,m)=0;
        end;
    end;
    X(1,m)=p*Tcurrent(1,m)-C(1,m);
    if p*Tcurrent(1,m)-C(1,m)<=-1
        Direction(1,m)=-1;Tcurrent(1,(m+1))=1;
    elseif p*Tcurrent(1,m)-C(1,m)>=1
        Direction(1,m)=1;Tcurrent(1,(m+1))=1;
    else
        Direction(1,m)=0;Tcurrent(1,(m+1))=Tcurrent(1,m)+1;
    end;
    if Direction(1,m)*Direction(1,(m-1))<0
        Reverse(1,m)=1;
    else
        Reverse(1,m)=0;
    end;
    if Reverse(1,m)==0
        DirectionSum(1,(m+1))=DirectionSum(1,m)+Direction(1,m);
    else
        DirectionSum(1,(m+1))=0;
    end;
    if (Reverse(1,m)==0)&(Direction(1,m)==1)
        if (RevAfterDouble(1,(m-3))==0)&(DirectionSum(1,m)>=2)
            Width(1,m)=Width(1,(m-1))*2;DoubleMark(1,m)=1;
        elseif (RevAfterDouble(1,(m-4))==1)&(DirectionSum(1,m)>=3)
            Width(1,m)=Width(1,(m-1))*2;DoubleMark(1,m)=1;
        else
            Width(1,m)=Width(1,(m-1));DoubleMark(1,m)=0;
        end;
    elseif (Reverse(1,m)==0)&(Direction(1,m)==-1)
        if (RevAfterDouble(1,(m-3))==0)&(DirectionSum(1,m)<=-2)
            Width(1,m)=Width(1,(m-1))*2;DoubleMark(1,m)=1;
        elseif (RevAfterDouble(1,(m-4))==1)&(DirectionSum(1,m)<=-3)
            Width(1,m)=Width(1,(m-1))*2;DoubleMark(1,m)=1;
        else
            Width(1,m)=Width(1,(m-1));DoubleMark(1,m)=0;
        end;
    elseif Reverse(1,m)==1
        Width(1,m)=Width(1,(m-1))*0.5;DoubleMark(1,m)=0;
    else
        Width(1,m)=Width(1,(m-1));DoubleMark(1,m)=0;
    end;
    RevAfterDouble(1,m)=Reverse(1,(m-1))*DoubleMark(1,m);
    Freq(1,(m+1))=Freq(1,m)+Direction(1,m)*Width(1,m);
end;
RESULT=[Tnumber(1,(1:Z));Freq(1,(1:Z));BBinterval(1,(1:Z));Ans(1,(1:Z));Judge(1,(1:Z));Tcurrent(1,(1:Z));C(1,(1:Z));X(1,(1:Z));Direction(1,(1:Z));DirectionSum(1,(1:Z));Reverse(1,(1:Z));Width(1,(1:Z));DoubleMark(1,(1:Z));RevAfterDouble(1,(1:Z))];
assignin('base','RESULT',RESULT);
subplot(2,1,1)
plot(RESULT(1,(RESULT(5,:)==1)),RESULT(2,(RESULT(5,:)==1)),'ok'),hold on
plot(RESULT(1,(RESULT(5,:)==0)),RESULT(2,(RESULT(5,:)==0)),'xk'),hold on
subplot(2,1,2)
plot(RESULT(1,:),RESULT(8,:))
end
