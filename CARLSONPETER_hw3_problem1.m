%Peter Carlson
%10.03.14
%HW3 Problem 1


%a

snowpack = xlsread('Snowpack.xlsx');
elevation = snowpack(1:6,1);
depth = snowpack(1:6,2:3);
temp = snowpack(1:6,4:5); 
density = snowpack(1:6,6:7); 
rel_dens = density/1000; %Relative snow density. density of water = 1000 kg/m^3

figure
plot(elevation,rel_dens)
ylabel('Relative Density (-)')
xlabel('Elevation (m)')
legend('21-Mar','7-Apr')

%b

h_m = rel_dens.*depth; %height of melt (SWE)

%linear regressions
h_s_model_m = polyfit(elevation(1:6),depth(1:6,1),1); %height of snow (March)
h_s_model_a = polyfit(elevation(1:6),depth(1:6,2),1); %height of snow (April)
h_m_model_m = polyfit(elevation(1:6),h_m(1:6,1),1); %SWE (March)
h_m_model_a = polyfit(elevation(1:6),h_m(1:6,2),1); %SWE (April)

%modeled heights (SWE, snow depth)
y_s_m = h_s_model_m(1).*elevation + h_s_model_m(2);
y_s_a = h_s_model_a(1).*elevation + h_s_model_a(2);
y_m_m = h_m_model_m(1).*elevation + h_m_model_m(2);
y_m_a = h_m_model_a(1).*elevation + h_m_model_a(2);

figure
plot(elevation,depth,elevation,y_s_m,'--b',elevation,y_s_a,'--g')
ylabel('Snow Depth (cm)')
xlabel('Elevation (m)')
legend('21-Mar','7-Apr','21-Mar-model','7-Apr-model')

figure
plot(elevation,h_m,elevation,y_m_m,'--b',elevation,y_m_a,'--g')
ylabel('Snow Water Equivalent (cm)')
xlabel('Elevation (m)')
legend('21-Mar','7-Apr','21-Mar-model','7-Apr-model')

%c

c_i = 2102; %heat capacity of ice = 2102 J/kg/K

Q_cc = -c_i*1000*h_m.*temp/100; %Cold content. :*1000 for density of water /100 to convert from h in cm to h in m


figure
plot(elevation,Q_cc)
ylabel('Cold Content Q_c_c (J/m^2)')
xlabel('Elevation (m)')
legend('21-Mar','7-Apr')

%d

lambda_f = 334000; %heat of fusion in J/kg 

theta_ret = -0.0735*rel_dens+0.000267*rel_dens.*density;  %volumetric water content the snow can support against gravity
Q_m2 = theta_ret.*depth*1000*lambda_f/10; %Heat of ripening:  *1000 for density of water /100 to convert from h in cm to h in m

figure
plot(elevation,Q_m2)
ylabel('Energy needed for ripening Q_m_2 (J/m^2)')
xlabel('Elevation (m)')
legend('21-Mar','7-Apr')