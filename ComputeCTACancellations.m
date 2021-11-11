function [SlotsGDP,GroundDelayGDP,cont] = ComputeCTACancellations(airline,SlotsGDP,GroundDelayGDP,AirDelayGDP,airlines,ETA)
slotsm=SlotsGDP(:,1)*60+SlotsGDP(:,2);
ETAm=ETA(:,1)*60+ETA(:,2);
i=1;
length=size(GroundDelayGDP);
l2=size(SlotsGDP);
cont=0;
encontrado2=0;
while (i<=length(1))
    encontradopos=0;
    encontradoi=0;

    while (i<=length(1)&& encontradopos==0 && encontradoi==0 )
        p=i;
        
        while(p<=l2(1) && encontradoi==0)
            if (SlotsGDP(p,3)==0 && SlotsGDP(p,4)==airline)
                encontradoi=1;
            else
                p=p+1;
            end
        end
        if(GroundDelayGDP(i,2)>=120 && airlines(GroundDelayGDP(i,1),1)==airline && encontrado2==0 )
            pos=0;
            k=1;
            while(k<=l2(1) && pos==0)
                if(SlotsGDP(k,3)==GroundDelayGDP(i,1))
                    pos=k;
                else
                    k=k+1;
                end
            end
            GroundDelayGDP(i,2)=0;
            GroundDelayGDP(i,1)=0;
            SlotsGDP(pos,3)=0;
            cont=cont+1;
            encontradopos=1;
        end
        i=i+1;
    end
    if (encontradopos==1 || encontradoi==1 )
        if (encontradopos==1)
            j=pos;
            y=pos;
        else
            j=p;
            y=p;
        end
        j=j+1;
        encontrado2=0;
        while(j<=l2(1) && encontrado2==0 && SlotsGDP(j,3)~=0 )
            if( SlotsGDP(j,4)==airline && slotsm(y)-ETAm(SlotsGDP(j,3))>-3)
                 if(j==270)
                     j=270;
                 end
                 SlotsGDP(y,3)=SlotsGDP(j,3);
                 
                 SlotsGDP(j,3)=0;
                 encontrado2=1;
                 k2=1;
                 pos2=0;
                 while(k2<=l2(1) && pos2==0)
                     if(GroundDelayGDP(k2,1)==SlotsGDP(y,3))
                         pos2=k2;
                     else
                         k2=k2+1;
                     end
                 end
                 if(slotsm(y)- ETAm(SlotsGDP(y,3))>=0)
                    GroundDelayGDP(pos2,2)=slotsm(y)-ETAm(SlotsGDP(y,3));
                 else
                    GroundDelayGDP(pos2,2)=0;
                 end
                 
            else
                j=j+1;
            end
        end
        if(encontrado2==0)
            j=y+1;
            while(j<=l2(1) && encontrado2==0 && SlotsGDP(j,3)~=0)
                if(slotsm(y)-ETAm(SlotsGDP(j,3))>-3)
                     SlotsGDP(y,3)=SlotsGDP(j,3);
                     SlotsGDP(y,4)=SlotsGDP(j,4);
                     SlotsGDP(j,3)=0;
                     SlotsGDP(j,4)=airline;
                     encontrado2=1;
                     k2=1;
                     pos2=0;
                     while(k2<=l2(1) && pos2==0)
                         if(GroundDelayGDP(k2,1)==SlotsGDP(y,3))
                             pos2=k2;
                         else
                             k2=k2+1;
                         end
                     end
                     if(slotsm(y)- ETAm(SlotsGDP(y,3))>=0)
                        GroundDelayGDP(pos2,2)=slotsm(y)-ETAm(SlotsGDP(y,3));
                     else
                        GroundDelayGDP(pos2,2)=0;
                     end
                else
                    j=j+1;
                end
            end
        end
            
        
    end
end         
end

