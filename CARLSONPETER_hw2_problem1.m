%Peter Carlson
%9.23.14
%HW2 Problem 1

%a
W6_65 = xlsread('Hubbard_Brook90.xls','1965'); %Read 1965 data
W6_66 = xlsread('Hubbard_Brook90.xls','1966'); %Read 1966 data

W6 = [W6_65;W6_66];     %concatenate 65 and 66
flow = [W6(1:730,6:7)];
    
figure
plot(1:730,flow)
ylabel('streamflow (mm/d)')
xlabel('Days')
legend('measured','modeled')
%b

storage = zeros(731,2); %initialize storage results
storage(1,1:2) = [225.5, 0]; %intial storage = 225.5 mm

for j = 1:730
    
    storage(j,2) = W6(j,5)-W6(j,6)-W6(j,8); %change in storage = Precip - Measured Flow - Evap
    storage(j+1,1) = storage(j,1)+storage(j,2); %Storage(t+1) = Storage(t) + change in storage(t)
end
y1 = sum(storage(1:366,2)) %net change in storage after 1965 (mm)
y2 = sum(storage(1:731,2)) %net change in storage after 1966 (mm)

%c
figure
plot(1:731,storage(1:731,1))
ylabel('Storage (mm)')
xlabel('Days')
figure
plot(1:730,W6(1:730,5))
ylabel('Precipitation (mm)')
xlabel('Days')
figure
plot(1:730,W6(1:730,6))
ylabel('Measured Flow (mm)')
xlabel('Days')
figure
plot(1:730,W6(1:730,8))
ylabel('Evapotranspiration (mm)')
xlabel('Days')
