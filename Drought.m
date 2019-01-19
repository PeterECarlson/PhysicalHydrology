%Bivariate analysis of drought occurance in Texas (Edwards Plateau)
%Temperature and Precipitation anomalies
%Loosely based on AghaKouchak et al., 2014:
%Global Warming and Changes in Risk of Concurrent Climate Extremes:
%Insights from the 2014 California Drought
%
%Requires 'Texas Drought.xlsx', a record of yearly (October)Edwards Plateau 
%temperature, rainfall, and PDSI. For each date and record type, the value,
%the anomaly from the 1901-2000 average, and the anomaly rank are included.
%Data from NOAA: http://www.ncdc.noaa.gov/cag/time-series/us
%
%Peter Carlson, 12/7/14, petercarlson@utexas.edu

close all
clear all
clc

%% read file
data = xlsread('Texas Drought.xlsx', 'combined','A2:J120');
datestring = data(:,1);
Temp = data(:,2:4);    %Celsius
Precip = data(:,5:7);  %mm
PDSI = data(:,8:10);
PrecipDef = -1*Precip(:,2); %in mm, average rainfall - rainfall
%univariate return period (years) (Chow, 1964)
TempReturn = 120./Temp(:,3);
PrecipReturn = 120./Precip(:,3);
PDSIReturn = 120./PDSI(:,3);

%% initial plots
figure
plot(PrecipReturn, TempReturn,'.')
xlabel('Precipitation Return Period')
ylabel('Temperature Return Period')
title('Edwards Plateau Temperature and Precipitation Return Periods(Yearly)')

figure
bar(datestring/100-0.1,Temp(:,2))
xlabel('Date')
ylabel('Temperature Anomaly (C)')
title('Edwards Plateau Temperature (Yearly)')

figure
bar(datestring/100-0.1,Precip(:,2))
xlabel('Date')
ylabel('Precipitation Anomaly (mm)')
title('Edwards Plateau Precipitation (Yearly)')

figure
bar(datestring/100-0.1,PDSI(:,2))
xlabel('Date')
ylabel('PDSI Anomaly (-)')
title('Edwards Plateau PDSI (Yearly)')

figure
scatterhist(PrecipDef,Temp(:,2))
xlabel('Precipitation Deficit (mm)')
ylabel('Temperature Anomaly (C)')
title('Temperature versus Precipitation')




%% Fit univariate t-location scale distributions to data (not necessary)
Pdist = fitdist(PrecipDef,'tLocationScale')
Tdist = fitdist(Temp(:,2),'normal');
%generate cumulative distribution functions
Fx = cdf(Pdist,linspace(-500,500));
Fy = cdf(Tdist,linspace(-2,2));

figure
plot(linspace(-500,500),Fx)
xlabel('Precipitation Deficit (mm)')
ylabel('Cumulative Probability')
title('Precipitation Deficit CDF')

figure
plot(linspace(-2,2),Fy)
xlabel('Temperature Anomaly (C)')
ylabel('Cumulative Probability')
title('Temperature CDF')

figure
plot(linspace(-500,500),1-Fx)
xlabel('Precipitation Deficit (mm)')
ylabel('Survival Probability')
title('Precipitation Deficit Survival CDF')

figure
plot(linspace(-2,2),1-Fy)
xlabel('Temperature Anomaly (C)')
ylabel('Survival Probability')
title('Temperature Survival CDF')



%% convert values to copula scale (unit square)
[u,xi] = ksdensity(PrecipDef,PrecipDef,'function','cdf');
[v,yi] = ksdensity(Temp(:,2),Temp(:,2),'function','cdf');

figure
scatterhist(u,v)
xlabel('Precipitation variable')
ylabel('Temperature variable')
title('Temperature versus Precipitation Projected to Copula Scale')


%% Fit a t-copula to the projected data
[Rho,nu] = copulafit('t',[u, v],'Method','ApproximateML');

%Generate bivariate cdf from fitted t-copula
X = 1-linspace(0,1);
Y = 1-linspace(0,1);
[X1,X2] = meshgrid(X,Y);
G = copulacdf('t',[X1(:) X2(:)],Rho,nu); %G=C(Fx(X),Fy(Y)) for all X,Y
G = reshape(G,length(Y),length(X));

figure
surf(X,Y,G);
caxis([min(G(:))-.5*range(G(:)),max(G(:))]);
axis([0 1 0 1 0 1])
xlabel('Precipitation variable');
ylabel('Temperature variable');
zlabel('C(Fx(X),Fy(Y))');
title('C(Fx(X),Fy(Y)');

figure
[C1,h1]=contour(X,Y,G,[.0001 .001 .01 .05:.1:.95 .99 .999 .9999]);
xlabel('Precipitation Deficit variable');
ylabel('Temperature variable');
clabel(C1,h1,'LabelSpacing',4000);

%% Calculate  Survival Copula (from Salvadori, et al, 2011)
Fbar = G + 1 - (diag(1-linspace(0,1))*ones(100)).'...
    - diag(1-linspace(0,1))*ones(100);

figure
surf(X,Y,Fbar);
caxis([min(Fbar(:))-.5*range(Fbar(:)),max(Fbar(:))]);
axis([0 1 0 1 0 1])
xlabel('Precipitation Deficit variable');
ylabel('Temperature variable');
zlabel('Survival Probability');

figure
[C2,h2]=contour(X,Y,Fbar,[.0001 .001 .01 .05:.1:.95 .99 .999 .9999]);
xlabel('Precipitation Deficit variable');
ylabel('Temperature variable');
clabel(C2,h2, 'LabelSpacing',4000);


%% Determine P(G): Probability that X, Y,  > x,y

%generate random vectors according to fitted t-copula
r = copularnd('t',Rho,nu,100000); 
u1 = r(:,1); %precip variables
v1 = r(:,2); %temp variables

%plot generated values
figure;
scatterhist(u1,v1)
xlabel('Random Rainfall (Projected)')
ylabel('Random Temperature (Projected)')
set(get(gca,'children'),'marker','.')

%generate bivariate CDF from random vectors
C = copulacdf('t',[u1(:) v1(:)],Rho,nu);

%% Estimate Kendall's Distribution Function (After Salvadori et al, 2011).

%Note: this method will estimate the probability that a vector is beyond 
%some probability level t: Kc(t)=P(C(Fx(X),Fy(Y)>t)
%The inverse of this, Kendall's Quantile q(p), will then be estimated.
%A more direct and accurate method to estimate q(p) is described in 
%"Algorithm 2" of Salvadori, et al, 2011, but requires significantly more
%processing and was deemed unnecassry and out of the scope of this project.

Kc = zeros(11,2);  %initialize Kc list for 11 values of t 
index = 1;

for t = 0:0.0001:0.04
    count = nnz(C>t); %Counts values of C that are greater than t
    Kc(index,1) = count/100000;   %P=count/total numbers of C 
    Kc(index,2) = t;
    index = index+1;
end

figure;
plot(Kc(:,2), Kc(:,1))
xlabel('Constant probability level t')
ylabel('Probability that C(Fx(X),Fy(Y))>t')
title('Relationship between p and t');


RP  = [10 15 20 30 50 100 200 300];  %Return Period in Years
p = 1  - 1./RP;%Yearly probability of each return period level occuring

%sort Kc (smallest to largest)
[values, order] = sort(Kc(:,1)); 
SortedKc = Kc(order,:);

%% Estimate q(p) from Kc
%find the survival times t associated with the probabilities p of interest

qp = zeros(length(p),1);

for j = 1:length(p)   
    %find closest p (from RP) in Kc and use that value
    %This shold be accurate to 0.0001 p.
    
    [N,bin]=histc(p(j),SortedKc(:,1));  
    index=bin+1;

    if abs(p(j)-SortedKc(bin,1))<abs(p(j)-SortedKc(bin+1,1))
        qp(j)=SortedKc(bin,2);
        index=bin;
    else
        qp(j)=SortedKc(index,2);
    end
end


figure
[C3,h3] = contour(X,Y,Fbar,qp);
xlabel('Precipitation Deficit variable');
ylabel('Temperature variable');
%display RP instead of associated p on contours
text_handles = clabel(C3,h3,'LabelSpacing',4000);
n=length(text_handles);
for i=1:n
  set(text_handles(i), 'String', ['RP: ', num2str(RP(i))]);
end

%% Undo the original projection and plot
x1 = ksdensity(PrecipDef,X,'function','icdf'); 
y1 = ksdensity(Temp(:,2),Y,'function','icdf'); 

figure
[C4,h4] = contour(-x1,y1,Fbar,qp);
xlabel('Precipitation (mm)');
ylabel('Temperature (C)');
title('Historical Data against Return Periods')
hold on;
%display RP instead of associated p on contours
text_handles2 = clabel(C4,h4,'LabelSpacing',2000);
n=length(text_handles2);
for i=1:n
  set(text_handles2(i), 'String', ['RP: ', num2str(RP(i)),' years']);
end
set(gca,'Xdir', 'reverse')
plot(Precip(:,2),Temp(:,2),'.');
hold off;