%Peter Carlson
%10.27.14
%HW4 Problem 1


z_m = 2; %m height of measurements
r = 65; % % rh
T_a = 28.3; %deg C air temp
v_a = 1.8; %m/s air speed
P = 100.100; % kPa air pressure
R_n = 320; % W/m^2 radiation
G = 0; % W/m^2 ground flux
p_w = 999.87; %kg/m^3
A = R_n; %That took a really long time to track down what A was. Total guess here. Would it normally be R_n-G?

gamma = 0.066; %kPa/K psychrometric constant
R_v = 463; %J/K/kg gas constanf of vapor
c_a = 1005; %J/kg-K heat capacity of air
lambda_v = 2495000; %J/kg
e_star_o = 0.611; %kPa

%a
z_veg = 0.6; %m height of vegetation
r_s = 25; %s/m stomatal resistance
z_d = 0.7*z_veg; %height of zero-plane
z_o = 0.1*z_veg; %height of roughness
p_a = 352/(T_a + 273.2); %density of dry air kg/m^3
C_a = v_a/(6.25*log((z_m-z_d)/z_o)^2); %conductance of air m/s


r_a = 1/C_a; %resistance of air s/m
e_star = e_star_o*exp(lambda_v/R_v*(1/273.15-1/(T_a+273.15))); %in kPa
e_a = r/100*e_star;
cap = 2508.3/(T_a+237.3)^2*exp((17.3*T_a)/(T_a+237.3)); %de*/dT in kPa/K

E = (A*cap*r_a + p_a*c_a*(e_star-e_a))/(cap*r_a+gamma*(r_a+r_s))/lambda_v; %kg/s/m^2
ET = E/p_w*1000*3600*24 %mm/day evaporated



%b

H = -R_n+G+lambda_v*E % in W/m^2
B = H/(lambda_v*E)
EF = 1/(1+B)

%c
r_s = 0; %s/m stomatal resistance
PE = (A*cap*r_a + p_a*c_a*(e_star-e_a))/(cap*r_a+gamma*(r_a+r_s))/lambda_v;
PET = PE/p_w*1000*3600*24 %mm/day evaporated
Beta = ET/PET

%d

r_s = 0:1:100;
E = (A*cap*r_a + p_a*c_a*(e_star-e_a))./(cap*r_a+gamma.*(r_a+r_s))./lambda_v;
ET = E./p_w*1000*3600*24; %mm/day evaporated

figure
plot(r_s,ET)
xlabel('Stomatal resistance r_s (s/m)')
ylabel('ET (mm/day)')

%e
r_s = 25;
v_a = 0:0.1:5;
C_a = v_a./(6.25*log((z_m-z_d)/z_o)^2); %conductance of air m/s
r_a = 1./C_a; %resistance of air s/m
E = (A*cap.*r_a + p_a*c_a*(e_star-e_a))./(cap.*r_a+gamma.*(r_a+r_s))./lambda_v;
ET = E./p_w*1000*3600*24; %mm/day evaporated

figure
plot(v_a,ET)
xlabel('Wind Speed v_a (m/s)')
ylabel('ET (mm/day)')

%f
v_a = 1.8;
C_a = v_a/(6.25*log((z_m-z_d)/z_o)^2); %conductance of air m/s
r_a = 1/C_a; %resistance of air s/m
T_a = 0:1:55;
p_a = 352./(T_a + 273.2); %density of dry air kg/m^3
e_star = e_star_o.*exp(lambda_v/R_v.*(1/273.15-1./(T_a+273.15)));
e_a = r/100.*e_star;
cap = 2508300./(T_a+237.3).^2.*exp((17.3.*T_a)./(T_a+237.3)); %de*/dT in Pa/K
E = (A*cap*r_a + p_a.*c_a.*(e_star-e_a))./(cap.*r_a+gamma.*(r_a+r_s))./lambda_v;
ET = E./p_w*1000*3600*24; %mm/day evaporated

figure
plot(T_a,ET)
xlabel('Air Temp T_a (deg C)')
ylabel('ET (mm/day)')