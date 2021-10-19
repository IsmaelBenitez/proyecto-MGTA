function [slots] = computeSlotsGDP(Hstart,Hend,HNoReg)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
Mstart=Hstart(:,1)*60+Hstart(:,2);
MNoReg=HNoReg(:,1)*60+HNoReg(:,2);
Mend=Hend(:,1)*60+Hend(:,2);
i=Mstart;
slots=[];
x=Hstart(:,1);
y=Hstart(:,2);
while(i<Mend)
    %x=Hstart(:,1);
    
    if(y>=60)
        x=x+1;
        y=y-60;
    end
    if(x*60+y==Mend)
        break;
    end
    slots=[slots; x y 0 0];
    slots=[slots; x y 0 0];
    y= y+3;
    i=i+1;
end
y=y-1;
while(i<MNoReg)
   
    y= y+1;
    if(y>=60)
        x=x+1;
        y=y-60;
    end
    if(x*60+y==MNoReg)
        break;
    end
    slots=[slots; x y 0 0];
   
    i=i+1;
end
j=1;
y=y-1;

while(j<=50)
   
    y= y+1;
    if(y>=60)
        x=x+1;
        y=y-60;
    end
    
    slots=[slots; x y 0 0];
   
    i=i+1;
    j=j+1;
    
    
    
end

