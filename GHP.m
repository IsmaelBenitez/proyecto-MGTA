function [Val,AirDelaynum,GroundDelaynum,TotalDelay] = GHP(Controlled,Hstart,ETA,HNoReg,Hend,ConnectingPAX,PAX,eps,Hfile,ETD,Internacional)
Mstart=Hstart(:,1)*60+Hstart(:,2);
MNoReg=HNoReg(:,1)*60+HNoReg(:,2);
Mend=Hend(:,1)*60+Hend(:,2);
Mfile=Hfile(:,1)*60+Hfile(:,2);
ETDm=ETD(:,1)*60+ETD(:,2);
ETAm=ETA(:,1)*60+ETA(:,2);


slotsm1 = Mstart:3:Mend;
slotsm2=(Mend+1):1:MNoReg;
slotsm=[slotsm1 slotsm2];
slotsm=transpose(slotsm);


maxC=max(ConnectingPAX);
maxP=max(PAX);
rf=((1+PAX./maxP)+(1+ConnectingPAX./maxC).^2).*(1+Internacional);
AirDelay=[];
GroundDelay=[];
c=[];

lengthS=size(slotsm);
lengthF=size(Controlled);
i=1;
A=[];
B=[];
lb=zeros(1,lengthF(1)*lengthS(1));
ub=ones(1,lengthF(1)*lengthS(1));
Aeq=[];
Beq=[];
while(i<=lengthF(1))
    j=1;

    while(j<=lengthS(1))
        if ((slotsm(j)-ETAm(Controlled(i)))>=0)
            if (ETDm(Controlled(i))-Mfile<0) %Air Delay
                c=[c; (1000/365)*rf(Controlled(i))*(slotsm(j)-ETAm(Controlled(i)))^(1+eps)];
                AirDelay=[AirDelay; slotsm(j)-ETAm(Controlled(i))];
                GroundDelay=[GroundDelay; 0];
            else
                c=[c; (200/365)*rf(Controlled(i))*(slotsm(j)-ETAm(Controlled(i)))^(1+eps)];
                AirDelay=[AirDelay; 0];
                GroundDelay=[GroundDelay; slotsm(j)-ETAm(Controlled(i))];
                
            end
                
                
        else
            c=[c;1e20];
            AirDelay=[AirDelay; 0];
            GroundDelay=[GroundDelay; 0];
        end
        j=j+1;
    end
    Ax1=zeros(1,(i-1)*lengthS(1));
    Ax2=ones(1,i*lengthS(1)-(i-1)*lengthS(1));
    Ax3=zeros(1,lengthF(1)*lengthS(1)-i*lengthS(1));
    Ax=[Ax1 Ax2 Ax3];
    Aeq=[Aeq;Ax];
    i=i+1;
end
Beq=transpose(ones(1,lengthF(1))); 
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

lengthS1=size(slotsm1);
B1=ones(1,lengthS1(2)).*2;
lengthS2=size(slotsm2);
B2=ones(1,lengthS2(2));
B=[B1 B2];
B=transpose(B);
lengthc=size(c);
int=(1:lengthc(1));
[X,Val]=intlinprog(c,int,A,B,Aeq,Beq,lb,ub);

CopiaG=GroundDelay.*X;

MAXAir=round(max(AirDelay.*X));
K=find(AirDelay.*X);
lenghtK=size(K);
AirDelay=cumsum(AirDelay.*X);
AirDelaynum=AirDelay(lengthc(1));
MAXGround=round(max(GroundDelay.*X));
K2=find(GroundDelay.*X);
lenghtK2=size(K2);
GroundDelay=cumsum(GroundDelay.*X);
GroundDelaynum=GroundDelay(lengthc(1));
TotalDelay=AirDelaynum+GroundDelaynum;
i=1;
sumatorio=0;
while(i<=lengthc(1))
    if(CopiaG(i)~=0)
        sumatorio=sumatorio+(CopiaG(i)-GroundDelaynum/lenghtK2(1))^2;
    end
    i=i+1;
end
desv=sqrt(sumatorio/lenghtK2(1));


fprintf('Results WP4\n');
fprintf('-----------------------\n');
fprintf('Cost of delay per day: %d $\n',round(Val));
fprintf('-----------------------\n');
fprintf('Total Delay: %d min \n',round(TotalDelay));
fprintf('-----------------------\n');
fprintf('Total Ground Delay: %d min\n',round(GroundDelaynum));
fprintf('Average Ground Delay: %d min\n',round(GroundDelaynum/lenghtK2(1)));
fprintf('Max Ground Delay: %d min\n',MAXGround);
fprintf('-----------------------\n');
fprintf('Total Air Delay: %d min\n',round(AirDelaynum));
fprintf('Average Air Delay: %d min\n',round(AirDelaynum/lenghtK(1)));
fprintf('Max Air Delay: %d min\n',MAXAir);
fprintf('-----------------------\n');
fprintf('Standar deviation of Ground Delay: %d\n',round(desv));
end

