function [TGDelay,MAXGDelay,AGDelay,TADelay,MAXADelay,AADelay] = ResultsWP3(GroundDelay,AirDelay,ETD,Distances,International,Hfile,Controlled,slots,ETA,Hstart,UnrecDelay,airlines)
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
fprintf('Unrecoverable Delay: %d min\n',UnrecDelay);


radius=0:100:4000;
length=size(radius);
i=1;
VGroundDelay=zeros(1,length(2));
VAirDelay=zeros(1,length(2));
VUnrecDelay=zeros(1,length(2));
while (i<=length(2))
    [ ~,~, ~, Exempt, ControlledGDP] = computeAircraftStatus(ETD,Distances,International,Hfile,radius(i),Controlled);
    [~,GroundDelayGDP,AirDelayGDP,~]=assignSlotsGDP(slots,ControlledGDP, ETA, ETD, Hfile,Exempt,airlines);
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
hold on;
yyaxis left;
plot(radius,VGroundDelay,'g');

yyaxis right;
plot(radius,VAirDelay,'r');
plot(radius,VUnrecDelay,'b');
title('Delays in funtion of the radius');
ylabel('Delays(min)');
xlabel('radius(m)');
legend("Ground Delay","Air Delay","Unrecoverable Delay");



Hfile=[3 0];
Mfile=Hfile(:,1)*60+Hfile(:,2);
file=Mfile:30:480;
length=size(file);
radius=1000;
i=1;
VGroundDelay=zeros(1,length(2));
VAirDelay=zeros(1,length(2));
VUnrecDelay=zeros(1,length(2));

while (i<=length(2))
    Hfile=[ fix(file(i)/60) rem(file(i),60)];
    [ ~,~, ~, Exempt, ControlledGDP] = computeAircraftStatus(ETD,Distances,International,Hfile,radius,Controlled);
    [~,GroundDelayGDP,AirDelayGDP,~]=assignSlotsGDP(slots,ControlledGDP, ETA, ETD, Hfile,Exempt,airlines);
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

figure(5);
hold on;
yyaxis left;
plot(file,VGroundDelay,'g');
ylabel('Delay(min)');
yyaxis right;
plot(file,VAirDelay,'r');
plot(file,VUnrecDelay,'b');
xticks([1:60:810]);
xticklabels({0:13});
title('Delays in function of Hfile');
xlabel('time(h)');
ylabel('Delay(min)');
legend("Ground Delay","Air Delay","Unrecoverable Delay");
end


