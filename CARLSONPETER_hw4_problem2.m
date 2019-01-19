%Peter Carlson
%10.27.14
%HW4 Problem 2


z_m = 2; %m height of measurements
r = 65; % % rh
T_a = 28.3; %deg C air temp
v_a = 1.8; %m/s air speed
P = 100100; % Pa air pressure
G = 0; % W/m^2 ground flux
p_w = 999.87; %kg/m^3
A = [
    0 0
    1 70
    2 165
    3 238
    4 290
    5 325
    6 340
    7 325
    8 290
    9 238
    10 165
    11 70
    12 0
    ];


gamma = 66; %Pa/K psychrometric constant
R_v = 463; %J/K/kg gas constanf of vapor
c_a = 1005; %J/kg-K heat capacity of air
lambda_v = 2495000; %J/kg
e_star_o = 611; %Pa

%a
z_veg = 0.6; %m height of vegetation
r_s = 25; %s/m stomatal resistance
z_d = 0.7*z_veg; %height of zero-plane
z_o = 0.1*z_veg; %height of roughness
p_a = 352/(T_a + 273.2); %density of dry air kg/m^3
C_a = v_a/(6.25*log((z_m-z_d)/z_o)^2); %conductance of air m/s


r_a = 1/C_a; %resistance of air s/m
e_star = e_star_o*exp(lambda_v/R_v*(1/273.15-1/(T_a+273.15)));
e_a = r/100*e_star;
cap = 2508300/(T_a+237.3)^2*exp((17.3*T_a)/(T_a+237.3)); %de*/dT in Pa/K

E = (A(1:13,2).*cap*r_a + p_a*c_a*(e_star-e_a))./(cap*r_a+gamma*(r_a+r_s))/lambda_v; %kg/s/m^2
ET = E./p_w*1000*3600*24; %mm/day evaporated

figure
plot(A(1:13,1),ET)
xlabel('Hours')
ylabel('ET (mm/day)')
