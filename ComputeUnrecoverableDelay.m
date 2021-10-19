function [UnrecDelay] = ComputeUnrecoverableDelay(ETD,Hstart,GroundDelay)
ETDm=ETD(:,1)*60+ETD(:,2);
Mstart=Hstart(:,1)*60+Hstart(:,2);
CTDm=ETDm;
UnrecDelay=0;
length=size(GroundDelay);
i=1;
while(i<length(1))
    CTDm(GroundDelay(i,1))=CTDm(GroundDelay(i,1))+GroundDelay(i,2);
    
    if(CTDm(GroundDelay(i,1))<Mstart)
        UnrecDelay=UnrecDelay+CTDm(GroundDelay(i,1))-ETDm(GroundDelay(i,1));
    elseif( ETDm(GroundDelay(i,1)) < Mstart && CTDm(GroundDelay(i,1))>Mstart)
        UnrecDelay=UnrecDelay+Mstart-ETDm(GroundDelay(i,1));
    end
        
        
    i=i+1;
end


    

end

