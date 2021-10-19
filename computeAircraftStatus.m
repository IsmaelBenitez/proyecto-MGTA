function [ ExemptRadius, ExemptInternational, ExemptFlying, Exempt, ControlledGDP] = computeAircraftStatus(ETD,Distances,International,Hfile,radius,Controlled)
length=size(Controlled);
ETDm=ETD(:,1)*60+ETD(:,2);
Mfile=Hfile(:,1)*60+Hfile(:,2);
i=1;
ExemptRadius=[];
ExemptInternational=[];
ExemptFlying=[];
Exempt=[];
ControlledGDP=[];
while(i<=length(1))
    j=Controlled(i);
    EX=0;
    if(Distances(j)>=radius)
        ExemptRadius=[ExemptRadius;j];
        EX=1;
    end
    if(International(j)==1)
        ExemptInternational=[ExemptInternational;j];
        EX=1;
    end
    if(ETDm(j)<Mfile)
        ExemptFlying=[ExemptFlying;j];
        EX=1;
    end
    
    if(EX==1)
        Exempt=[Exempt;j];
    else
        ControlledGDP=[ControlledGDP;j];
    end
    i=i+1;
           
end

 
end

