function [TGDelay,MAXGDelay,AGDelay,TADelay,MAXADelay,AADelay] = ResultsWP2(GroundDelay,AirDelay)
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
fprintf('Results WP2\n');
fprintf('-----------------------\n');
fprintf('Total Ground Delay: %d min \n',TGDelay);
fprintf('Average Ground Delay: %d min\n',round(AGDelay));
fprintf('MAX Ground Delay: %d min\n',MAXGDelay);
fprintf('-----------------------\n');
fprintf('Total Air Delay: %d min\n',TADelay);
fprintf('Average Air Delay: %d min\n',round(AADelay));
fprintf('MAX Air Delay: %d min\n',MAXADelay);
fprintf('-----------------------\n');



end

