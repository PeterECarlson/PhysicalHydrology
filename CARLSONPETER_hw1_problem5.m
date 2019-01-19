%Peter Carlson
%9.15.14
%HW1 Problem 5


%a,b

w_list = [0.23,0.23,0.65,0.65]; %runoff ratios
p_list = [0.9,1.1,1.09,0.87];    %relative changes in precipitation
e_list = [1.0,1.0,1.07,1.07];    %relative changes in evaporation

for i = 1:4
q = (p_list(i) - ( 1 - w_list(i) ) * e_list(i)) / w_list(i)     %change in runoff
end

%c
e = 1; %no change in precipitation
w = linspace(0,1);  %100 values in a range from 0 to 1.
for j = 1:100
    
    q1(j) = (0.4 - ( 1 - w(j) ) * e ) / w(j);
    q2(j) = (0.6 - ( 1 - w(j) ) * e ) / w(j);
    q3(j) = (0.8 - ( 1 - w(j) ) * e ) / w(j);
    q4(j) = (1.0 - ( 1 - w(j) ) * e ) / w(j);
    q5(j) = (1.2 - ( 1 - w(j) ) * e ) / w(j);
    q6(j) = (1.4 - ( 1 - w(j) ) * e ) / w(j);
    q7(j) = (1.6 - ( 1 - w(j) ) * e ) / w(j);
end

figure

h = plot(w,q1,w,q2,w,q3,w,q4,w,q5,w,q6,w,q7);
axis([0,1,-5,5])
ylabel('q')
xlabel('w')


%d

w = 0.23;
e = linspace(0,2); %100 values in a range from 0 to 2.

q1 = (0.4 - ( 1 - w ) * e ) / w;
q2 = (0.6 - ( 1 - w ) * e ) / w;
q3 = (0.8 - ( 1 - w ) * e ) / w;
q4 = (1.0 - ( 1 - w ) * e ) / w;
q5 = (1.2 - ( 1 - w ) * e ) / w;
q6 = (1.4 - ( 1 - w ) * e ) / w;
q7 = (1.6 - ( 1 - w ) * e ) / w;

figure

plot(e,q1,e,q2,e,q3,e,q4,e,q5,e,q6,e,q7)
ylabel('q')
xlabel('e')

%e
q_austin_dry = (0.8 - ( 1 - w ) * 1.2 ) / w
return