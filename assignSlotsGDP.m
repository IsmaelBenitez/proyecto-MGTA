function [slots,GroundDelay,AirDelay,CTA]=assignSlotsGDP(slots,Controlled, ETA, ETD, Hfile,Exempt,Airlines)
GroundDelay=[];
AirDelay=[];
ETAm=ETA(:,1)*60+ETA(:,2);
ETDm=ETD(:,1)*60+ETD(:,2);
Mfile=Hfile(:,1)*60+Hfile(:,2);
slotsm=slots(:,1)*60+slots(:,2);
CTAm=ETAm;
i=1;%La i correrá el vector de slots
j=1;% La j correrá el vector de exempt
length=size(Exempt);
while (j<=length(1))
    if (slotsm(i)-ETAm(Exempt(j))<-2)
        
    else
        slots(i,3)=Exempt(j);
        slots(i,4)=Airlines(Exempt(j));
        op=slotsm(i)-ETAm(Exempt(j));
        if (op<0)
            op=0;
        end
        %CTAm(Exempt(j))=CTAm(Exempt(j))+op;
        CTAm(Exempt(j))=slotsm(i);
        
        if (ETDm(Exempt(j))< Mfile)
            AirDelay=[AirDelay;Exempt(j) op];

        else
            GroundDelay=[GroundDelay;Exempt(j) op];
        end
        j=j+1;
    end
    i=i+1;
end


i=1;%La i correrá el vector de slots
j=1;% La j correrá el vector de controlled

length=size(slots);
length2=size(Controlled);
while(i<=length(1) && j<=length2(1))
    if(slots(i,3)~=0)
        
    elseif(slotsm(i)-ETAm(Controlled(j))<-2)
        
    else
        slots(i,3)=Controlled(j);
        slots(i,4)=Airlines(Controlled(j));
        op=slotsm(i)-ETAm(Controlled(j));
        if (op<0)
            op=0;
        end
            %CTAm(Controlled(j))=CTAm(Controlled(j))+op;
             CTAm(Controlled(j))=slotsm(i);
        if (ETDm(Controlled(j))< Mfile)
            AirDelay=[AirDelay;Controlled(j) op];

        else
            GroundDelay=[GroundDelay;Controlled(j) op];
        end
        j=j+1;
    end
    i=i+1;
end
        
    
CTA=[fix(CTAm/60),rem(CTAm,60)];
end

