%Peter Carlson
%9.24.14
%HW2 Problem 2


%a
g = 9.81; %m/s^2
P_o = 1009; %Pressure at z_o in mb
Column = xlsread('AtmosColumn.xls');
T_ave = mean(Column(1:12,2));
R_a = 0.288; %kJ/K/kg
R_v = 0.463; %kJ/K/kg
epsilon = 0.622; %R_a/R_v
lambda_v = 2495; %latent heat of vaporization in kJ/kg
T_o = 273.15; %0 deg C
e_sat_o = 6.11; %saturation vapor pressure at STP in mb

z = zeros(12,1);

for i = (1:12)
    
    z(i) = -1000*R_a*(T_ave+273.15)/g*log(Column(i,1)/P_o); %elevation from pressures
end

figure
[haxes,hline1,hline2] = plotyy(z, Column(1:12,1),z,Column(1:12,2));
ylabel(haxes(1),'Pressure (mb)');
ylabel(haxes(2),'T (deg C)');
xlabel(haxes(1),'z (m)');

%b

e = zeros(12,1); %vap. press. in mb
q = zeros(12,1); %Spec. hum. in g/kg
r_1 = zeros(12,1); %rel. hum. in % using its definition
r_2 = zeros(12,1); %rel. hum. in % using its relation to T_d

for j = (1:12)
    T = Column(j,2); %temp (in deg C)
    T_d = Column(j,3); %dew point (in deg C)
    
    e(j) = e_sat_o*exp(lambda_v/R_v*(1/T_o-1/(T_d+273.15))); %vapor pressure in mb (from dew point temp)
    q(j) = 1000*e(j)*epsilon/Column(j,1); %specific humidity in g/kg (from vapor pressure)
    
    e_sat = e_sat_o*exp(lambda_v/R_v*(1/T_o-1/(T+273.15))); %saturated vapor pressure in mb (from temp)
    r_1(j) = 100*e(j)/e_sat;                                %analytical relative humidity (%) (from vapor pressure)
    r_2(j) = 100*((112-0.1*(T)+T_d)/(112+0.9*(T)))^8;       %empirical relative humidity (%) (from temp and dew point)
end    

figure
plot(z, e);
ylabel('vapor pressure (mb)');
xlabel('z (m)');

figure
plot(z, q);
ylabel('specific humidity (g/kg)');
xlabel('z (m)');

figure
plot(z, r_1, z, r_2);
ylabel('relative humidity (%)');
xlabel('z (m)');
legend('analytical','empirical');

%c
w_p_mm = 0; %precipitable water content in mm

for k = (1:11)
   w_p_mm = w_p_mm + 0.01*(q(k+1)+q(k))/2*(Column(k,3)-Column(k+1,3));   %precipitable water content in mm  (from specific humidity and dew point)
end
w_p_mm
w_p_inches = w_p*0.0393701 %in inches


%d

alpha = zeros(11,1);
z_ave = zeros(11,1);
alpha_add = 0;
for m = (1:11)
   
    alpha(m) = 1000*(Column(m+1,2)-Column(m,2))/(z(m+1)-z(m)); %ambient lapse rate (from temp and Z)
    alpha_add = alpha_add + alpha(m)*(z(m+1)-z(m));  %Allows for the calculation of an average lapse rate
    z_ave(m) = (z(m+1)+z(m))/2000; %Center elevation between two data
end
alpha_ave = alpha_add/(z(12)-z(1)) %weighted average of lapse rate


figure
plot(z_ave, alpha);
ylabel('Ambient Lapse Rate (deg C/km)');
xlabel('z (km)');