function [outputArg1,outputArg2] = GHP(slots,Controlled,Hfile,Hstart,ETA)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
rf=1;
e=0;
slotsm=slots(:,1)*60+slots(:,2);
ETAm=ETA(:,1)*60+ETA(:,2);
c=[];
lengthS=size(slots);
lengthF=size(Controlled);
i=1;
A=[];
B=[];
lb=zeros(1,lengthF(1)*lengthS(1));
ub=ones(1,lengthF(1)*lengthS(1));
Aeq=[];
Beq=[];
% while(i<=lengthF(1))
%     j=1;
% 
%     while(j<=lengthS(1))
%         c=[c; rf*(slotsm(j)-ETAm(Controlled(i)))^(1+e)];
%         
%         j=j+1;
%     end
%     Ax1=zeros(1,(i-1)*lengthS(1));
%     Ax2=ones(1,i*lengthS(1)-(i-1)*lengthS(1));
%     Ax3=zeros(1,lengthF(1)*lengthS(1)-i*lengthS(1));
%     Ax=[Ax1 Ax2 Ax3];
%     Aeq=[Aeq;Ax];
%     i=i+1;
% end
% Beq=transpose(ones(1,lengthF(1))); 
i=1;
while(i<=lengthS(1))
    j=1;
    Axx=[];
    while(j<=lengthF(1))
         Ax1=zeros(1,(i-1));
         Ax2=ones(1,1);
         Ax3=zeros(1,lengthS(1)-i);
         Ax=[Ax1 Ax2 Ax3];
         Axx=[Axx Ax];
         j=j+1;
    end
    A=[A;Axx];
    i=i+1;

end
B=transpose(ones(1,lengthS(1))); 

end

