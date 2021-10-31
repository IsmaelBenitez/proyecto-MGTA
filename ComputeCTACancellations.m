function [SlotsGDP] = ComputeCTACancellations(airline,SlotsGDP,GroundDelayGDP,AirDelayGDP,airlines)

i=1;
length=size(GroundDelayGDP);
while (i<=length(1))
    if(GroundDelayGDP(i,2)>=120 && airlines(GroundDelayGDP(i,1),1)==airline)
        SlotsGDP(i,:)=0;
    end
    i=i+1;
end

