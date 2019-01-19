clc;clear all;
%% estimate average daily optical air mass for Austin
  x1=[-20,-10,0,10,20]*pi/180;     %declination (northern hemisphere)
  y1=[3.8,3.35,3.08,2.94,2.87];    % optical air mass at latitude 30.25N  (austin)
  
D=[90,91];  %days
for i=1:length(D) 
    decli(i)=23.45*(pi/180)*cos((2*pi/365)*(172-D(i)));   %calculate declination 
end

ma= interp1(x1,y1,decli,'linear','extrap')  %optical air mass at latitude 30.25N  (austin)
