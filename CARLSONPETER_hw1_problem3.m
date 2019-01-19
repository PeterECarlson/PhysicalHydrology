%Peter Carlson
%9.12.14
%HW1 Problem 3

[Day,OAM_A,OAM_M]=textread('OpticalAirMass.txt');% Read days, optical air masses from file

%For these lists, each value is the corresponding value needed for a
%different run of the calculation: Austin clear, Austin smoggy, and Melbourne.

Lat_list = [30.2500,30.2500,-37.8136]; %latitude in decimal degrees
Turb_list = [0,5,2];        
cloud_list = [1/3,1/3,0];
OAM_index_list = [1,1,2];

I_sc = 1367 %W/m^2
a = 0.15; %Estimated value.


answers = zeros(length(Day),4);

for i = 1:3
    phi = pi/180*Lat_list(i);       %latitude in radians
    n = Turb_list(i);
    N = cloud_list(i); 
    for j = 1:length(Day)
       D = Day(j); 
       r = 1+0.017*cos(2*pi/365*(186-D)); %distance ratio
       delta = 23.45*pi/180*cos(2*pi/365*(172-D)); %Declination
       tau = 2*pi;  %Hour Angle
       sin_alpha = sin(delta)*sin(phi)+cos(delta)*cos(phi)*cos(tau);    %solar altitude
       if OAM_index_list(i) == 1
          m = OAM_A(j); %use Austin OAM
       elseif OAM_index_list(i) == 2
          m = OAM_M(j); %use melbourne OAM
       else
           return   %end program
       end
       a_l = 0.128-0.054*log(m);
       
       
       I_o = I_sc*sin_alpha/(r^2);   %corrected for geometry
       I_c = I_o*exp(-n*a_l*N^2);    %corrected for air effects
       I_cl = I_c*(1-0.65*N^2);      %corrected for clouds
       I_s = I_cl*(1-a);             %corrected for albedo
       
       
       answers(j,1:4) = [I_o, I_c, I_cl,I_s];
    end
    figure
    plot(Day, answers)
    answers
end
return