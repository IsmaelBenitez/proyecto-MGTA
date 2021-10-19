function [TGDelay,MAXGDelay,AGDelay,TADelay,MAXADelay,AADelay] = ResultsWP3(GroundDelay,AirDelay,ETD,Distances,International,Hfile,Controlled,slots,ETA,Hstart)
lenghtG=size(GroundDelay(:,2));
i=1;
TGDelay=0;
TADelay=0;
while (i<=lenghtG(1))
    TGDelay=TGDelay+GroundDelay(i,2);
    i=i+1;
end
MAXGDelay=max(GroundDelay(:,2));
AGDelay=TGDelay/lenghtG(1);

lenghtA=size(AirDelay(:,2));
i=1;
while (i<=lenghtA(1))
    TADelay=TADelay+AirDelay(i,2);
    i=i+1;
end
MAXADelay=max(AirDelay(:,2));
AADelay=TADelay/lenghtA(1);
fprintf('Results WP3\n');
fprintf('-----------------------\n');
fprintf('Total Ground Delay: %d min \n',TGDelay);
fprintf('Average Ground Delay: %d min\n',round(AGDelay));
fprintf('MAX Ground Delay: %d min\n',MAXGDelay);
fprintf('-----------------------\n');
fprintf('Total Air Delay: %d min\n',TADelay);
fprintf('Average Air Delay: %d min\n',round(AADelay));
fprintf('MAX Air Delay: %d min\n',MAXADelay);
fprintf('-----------------------\n');


radius=0:100:2000;
length=size(radius);
i=1;
VGroundDelay=zeros(1,length(2));
VAirDelay=zeros(1,length(2));
VUnrecDelay=zeros(1,length(2));
while (i<=length(2))
    [ ~,~, ~, Exempt, ControlledGDP] = computeAircraftStatus(ETD,Distances,International,Hfile,radius(i),Controlled);
    [~,GroundDelayGDP,AirDelayGDP,~]=assignSlotsGDP(slots,ControlledGDP, ETA, ETD, Hfile,Exempt);
    [VUnrecDelay(i)] = ComputeUnrecoverableDelay(ETD,Hstart,GroundDelayGDP);
    j=1;
    lenghtG=size(GroundDelayGDP);
    while (j<=lenghtG(1))
        VGroundDelay(i)=VGroundDelay(i)+GroundDelayGDP(j,2);
        j=j+1;
    end
    j=1;
    lenghtA=size(AirDelayGDP);
    while (j<=lenghtA(1))
        VAirDelay(i)=VAirDelay(i)+AirDelayGDP(j,2);
        j=j+1;
    end
    
    i=i+1;
end
plot(radius,VGroundDelay,'g');
hold on;
plot(radius,VAirDelay,'r');
plot(radius,VUnrecDelay,'b');
legend("Ground Delay","Air Delay","Unrecoverable Delay");
end


