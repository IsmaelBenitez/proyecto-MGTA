clear all;
close all;
load('G:\Aerotelecom\3A\MGTA\proyecto MGTA\demandQ12021\demandQ12021\demand_dataPHL.mat');
%Constantes
PAAR=40;
AAR=60;
Hstart=[8 00];
Hend=[13 00];
Hfile=[7 00];
%------------------------------------------------------
%WP1
[HNoReg,delay]=aggregateDemand(ETA,Hstart,Hend,PAAR,AAR);
[slots] = computeSlotsGDP(Hstart,Hend,HNoReg);
%------------------------------------------------------
%WP2
[NotAffected,Controlled] = computeAircraftStatusRBS(ETA,Hstart,HNoReg);
[slotsRBS,GroundDelay,AirDelay,CTA]=assignSlotsRBS(slots,Controlled, ETA, ETD, Hfile);
figure(2);
plotHistograms(CTA,AAR,PAAR,Hstart,Hend);
ResultsWP2(GroundDelay,AirDelay);
%------------------------------------------------------
%WP3
radius=1400;
[ ExemptRadius,ExemptInternational, ExemptFlying, Exempt, ControlledGDP] = computeAircraftStatus(ETD,Distances,International,Hfile,radius,Controlled);
[slotsGDP,GroundDelayGDP,AirDelayGDP,CTAGDP]=assignSlotsGDP(slots,ControlledGDP, ETA, ETD, Hfile,Exempt,airlines);
figure(3);
plotHistograms(CTAGDP,AAR,PAAR,Hstart,Hend);
[UnrecDelay] = ComputeUnrecoverableDelay(ETD,Hstart,GroundDelayGDP);
figure(4);
ResultsWP3(GroundDelayGDP,AirDelayGDP,ETD,Distances,International,Hfile,Controlled,slots,ETA,Hstart,UnrecDelay,airlines);
[slotsGDP] = ComputeCTACancellations(1,slotsGDP,GroundDelayGDP,AirDelayGDP,airlines);