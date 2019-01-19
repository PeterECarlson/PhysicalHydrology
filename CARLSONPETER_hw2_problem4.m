%Peter Carlson
%9.25.14
%HW2 Problem 4


%a

temps = xlsread('TempProfiles.csv'); %Temp Profiles created using a graph digitization software and rounding elevation to the nearest ten ft.
Midnight = temps(1:19,1:2); %12 AM
Sunrise = temps(1:11,3:4); %6 AM
Midday = temps(1:17,5:6); %12 PM
Siesta = temps(1:20,7:8); %2 PM
Sunset = temps(1:21,9:10); %6 PM

figure
plot(Midnight(1:19,2),Midnight(1:19,1))
xlabel('Temperature (deg F)')
ylabel('Height (ft)')
axis([50,80,0,5000])
title('12 AM')

figure
plot(Sunrise(1:11,2),Sunrise(1:11,1))
xlabel('Temperature (deg F)')
ylabel('Height (ft)')
axis([50,80,0,5000])
title('6 AM')

figure
plot(Midday(1:17,2),Midday(1:17,1))
xlabel('Temperature (deg F)')
ylabel('Height (ft)')
axis([50,80,0,5000])
title('12 PM')

figure
plot(Sunset(1:21,2),Sunset(1:21,1))
xlabel('Temperature (deg F)')
ylabel('Height (ft)')
axis([50,80,0,5000])
title('6 PM')


%c

r = [80;50]; %relative humidity
T_F = 75; %Temp in deg F
T_C = (T_F-32)*5/9; %Temperature in deg C
T_d = (r/100).^(1/8)*(112+0.9*T_C)-112+0.1*T_C; %dewpoint temp in C, calculated from relative humidity and temperature
T_d_F = T_d*9/5+32  %dewpoint temp in deg F

%d

gamma_d = -5.5/1000; %dry adiabatic lapse rate in deg F/ft
T_range = 50:5:80; %T in F from 50 tpo 80 at 5 deg intervals

dry = (T_range-75)/gamma_d; %elevations for the dry adiabatic profile
figure
plot(Siesta(1:20,2),Siesta(1:20,1), T_range,dry, [T_d_F(1),T_d_F(1)],[-10,5010], [T_d_F(2),T_d_F(2)],[-10,5010])
xlabel('Temperature (deg F)')
ylabel('Height (ft)')
axis([50,80,0,5000])
title('2 PM')
legend('Temperature Profile at 2PM','Dry adiabatic Lapse Profile', 'Dewpoint Temp at 80% relative humidity', 'Dewpoint Temp at 50% relative humidity') 

%e

condensation = (T_d_F(1)-75)/gamma_d %Condensation elevation for air starting at 75 deg F and 80% RH
