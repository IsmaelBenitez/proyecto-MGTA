function [HNoReg,delay]=aggregateDemand(ETA,Hstart,Hend,PAAR,AAR)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
ETAm=ETA(:,1)*60+ETA(:,2);
minutes=1:1440;
minutes=transpose(minutes);
Flights=zeros(1,1440);
Flights=transpose(Flights);
Aggdemand=[minutes Flights];

i=1;
length=size(ETAm(:,1));
while(i<=length(1))
    Aggdemand(ETAm(i),2)=Aggdemand(ETAm(i),2)+1;
    i=i+1;  
end
suma=cumsum(Aggdemand(:,2));
Aggdemand=[minutes suma];
plot(Aggdemand(:,2));
hold on;

xticks([1:60:1500]);
xticklabels({0:24});

regulated=[];
Mstart=Hstart(:,1)*60+Hstart(:,2);
Mend=Hend(:,1)*60+Hend(:,2);
i=Mstart;
while(i<=Mend)
    regulated=[regulated;Aggdemand(Mstart,2)+(i-Mstart)*PAAR/60];
    i=i+1;
end

i=Mend;
bool=0;
notregulated=[];
while(bool==0)
    notregulated=[notregulated;regulated(Mend-Mstart+1)+(i-Mend)*AAR/60];
    if(round(notregulated(i-Mend+1))==Aggdemand(i,2))
        bool=1;
    else
        i=i+1;
    end

    
end
x1=(Mstart:1:Mend);
x2=(Mend:1:i);

plot(x1,regulated,'r.');
plot(x2,notregulated,'g--');
legend('Aggregated demand','Reduced capacity','Nominal capacity');
MNoReg=i;

j=Mstart;
delay=0;
while(j<Mend)
    delay=delay+(Aggdemand(j,2)-regulated(j-Mstart+1));
    j=j+1;
end
while(j<MNoReg)
    delay=delay+(Aggdemand(j,2)-notregulated(j-Mend+1));
    j=j+1;
end

HNoReg=[fix(MNoReg/60),rem(MNoReg,60)];




end

