function [NotAffected,Controlled] = computeAircraftStatusRBS(ETA,Hstart,HNoReg)

    ETAm=ETA(:,1)*60+ETA(:,2);
    Mstart=Hstart(:,1)*60+Hstart(:,2);
    MNoReg=HNoReg(:,1)*60+HNoReg(:,2);
    i=1;
    Identifier=1:size(ETAm);
    Identifier=transpose(Identifier);
    Controlled=[];
    NotAffected=[];
    length=size(ETAm);
    while(i<=length(1))
        if ((Mstart<=ETAm(i)) && (MNoReg>=ETAm(i)))
            Controlled=[Controlled;Identifier(i)];
        else
            NotAffected=[NotAffected;Identifier(i)];
        end
        i=i+1;
    end
            
        
    
    
end

