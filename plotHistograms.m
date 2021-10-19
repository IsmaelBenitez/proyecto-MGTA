function  plotHistograms(CTA,AAR,PAAR,Hstart,Hend)
histogram(CTA(:,1));
hold on;
ylim([0,70]);
xlim([0,24]);
x1=0:0.5:(Hstart(:,1)-0.5);
y1=x1*0+AAR;
plot(x1,y1,'g','linewidth',3)
x2=(Hstart(:,1)-0.5):0.5:(Hend(:,1)-0.5);
y2=x2*0+PAAR;
plot(x2,y2,'r','linewidth',3)
x3=(Hend(:,1)-0.5):0.5:24;
y3=x3*0+AAR;
plot(x3,y3,'g','linewidth',3)
title('Histogram after regulation');
xlabel('Time(h)');
ylabel('Flights');
legend('Flights','AAR','PAAR');


end

