%Peter Carlson
%9.25.14
%HW2 Problem 3


%b

DEM = xlsread('topo_gage_data.xls','topo_data','C3:S21'); %digital elevation profile provided (km)
Gage = xlsread('topo_gage_data.xls','gage_data'); %precipitation rates for certain elevations (mm)


figure
surf(DEM)
xlabel('Easting (km)');
ylabel('Northing (km)');
zlabel('Elevation (km)');


%c

fit = polyfit(Gage(1:8,2),Gage(1:8,1),1) %determines m and b of the best fit line y=mx+b, where y is precipitation (mm) and x is elevation (m)
x = 0:100:2500; %0 to 2500 in increments of 100
y = fit(1)*x + fit(2); %y values of best fit line
figure
plot(Gage(1:8,1),Gage(1:8,2),'o',x,y)
xlabel('elevation (m)');
ylabel('precipitation (mm)');


y_predicted = fit(1)*Gage(1:8,2) + fit(2); %The predicted precipitation for every elevation with a measurement
R_squared = R2(Gage(1:8,2),y_predicted) %using provided R-squared program

%d
Precip = 1000*fit(1)*DEM+fit(2); %precipitation for every elevation in the DEM. The 1000 is there to convert between DEM elevation in km and precip elevation in m
figure
surf(Precip)
xlabel('Easting (km)');
ylabel('Northing (km)');
zlabel('precipitation (mm)');

%e
Maximum = max(max(Precip)); %Find the maximum precipitation
Minimum = min(min(Precip)); %find the minimum precipitation
per_inc = (Maximum-Minimum)/Minimum*100 %the percent increase in precipitation