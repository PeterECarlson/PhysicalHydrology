%Peter Carlson
%9.12.14
%HW1 Problem 4



m = 3.0224;      %Optical Air Mass for D = 91 in Austin using the program written by Lizhi

phi = 30.2500*pi/180;    %latitude in radians
n = 3;                   %turbidity
N = 0.20;                %cloud cover
a = 0.40;                %albedo of solar panel
I_sc = 1367;             %W/m^2
D = 91;                  %solstice
nu = 0.13;                %efficiency of typical solar cell
Eo = 1;                  %standard efficiency = 1 kW/m^2
household = 12000/365;  %average daily household power consumption

answers = zeros(48,1);
for j = 0:47
   h = 0.5*j;            %hours
   r = 1+0.017*cos(2*pi/365*(186-D)); %distance ratio
   delta = 23.45*pi/180*cos(2*pi/365*(172-D)); %Declination
   tau = (h+12)/12*pi;  %Hour Angle
   sin_alpha = sin(delta)*sin(phi)+cos(delta)*cos(phi)*cos(tau);    %solar altitude

   a_l = 0.128-0.054*log(m);

   if I_sc*sin_alpha/(r^2) >= 0
       I_o = I_sc*sin_alpha/(r^2);   %corrected for geometry
   else
       I_o = 0;
   end
   I_c = I_o*exp(-n*a_l*N^2);    %corrected for air effects
   I_cl = I_c*(1-0.65*N^2);      %corrected for clouds
   I_s = I_cl*(1-a);

   answers(j+1) = [I_s];
end
figure
plot(0:47, answers)
answers

radiation = sum(answers(1:48))*12/1000     %daily kWhr/m2 in Austin
hours = radiation/12                        %hours of standard radiation equivalent
P_m = radiation*nu                       %power generation in kWhr/day for 13% efficient 1 m^2 cell
area = household/P_m                    %area in m^2 to power one household

return