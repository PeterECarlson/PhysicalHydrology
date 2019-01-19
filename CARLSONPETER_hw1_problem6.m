%Peter Carlson
%9.16.14
%HW1 Problem 6

S = 1.74*10^17; %solar radiation in W
Q_e = 4.08*10^16; %latent heat flux from earth in W
Q_h = 8.67*10^15; %sensible heat flux from earth in W
W = 1.07*10^13; %man-made heat in W
a_p = 0.3; %albedo
k_u = 0.18; %proportion solar radiation absorbed in upper atm
k_l = 0.075; %proportion solar radiation absorbed in lower atm
f = 0.950; %fraction surface radiation absorbed in atm
sigma = 5.6704*10^-8; %Stefan-Boltzmann constant in W/m^2/K^-4
A = 5.1*10^14; %area in m^2

%b
T_s = (((3-3*a_p-2*k_u-k_l)*S-1.5*Q_e-Q_h+2*W)/((3-2*f)*sigma*A))^(1/4) %temp of surface in K
T_u = ((-a_p*S-(1-f)*sigma*A*T_s^4+S+W)/(sigma*A))^(1/4); %Temp of upper atm in K
T_l = ((2*S+2*W-2*a_p*S-2*(1-f)*sigma*A*T_s^4-k_u-0.5*Q_e)/(sigma*A))^(1/4); %Temp of lower atm in K

T_u-T_l %Temp difference between upper and lower atm in K.

%c
f_list = linspace(0.9,1.0); %range of GHG factors
T_s_list = zeros(1,100); %initialize surface temperature range

for i = 1:100
    T_s_list(i) = (((3-3*a_p-2*k_u-k_l)*S-1.5*Q_e-Q_h+2*W)/((3-2*f_list(i))*sigma*A))^(1/4)-273.15;
end

figure
plot(f_list,T_s_list);
ylabel('T_s')
xlabel('f')