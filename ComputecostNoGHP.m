function [cost] = ComputecostNoGHP(ground,Air,PAX,ConnectingPAX,Internacional,eps)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

cost=0;
i=1;
maxP=max(PAX);
maxC=max(ConnectingPAX);
length=size(ground);
while(i<=length(1))
    cost=cost+((200/365)*((1+PAX(ground(i,1))/maxP)+(1+ConnectingPAX(ground(i,1))/maxC)^2)*(1+Internacional(ground(i,1)))*(ground(i,2)))^(1+eps);
    i=i+1;
end
i=1;
length=size(Air);
while(i<=length(1))
    cost=cost+((1000/365)*((1+PAX(Air(i,1))/maxP)+(1+ConnectingPAX(Air(i,1))/maxC)^2)*(1+Internacional(Air(i,1)))*(Air(i,2)))^(1+eps);
    i=i+1;
end




end

