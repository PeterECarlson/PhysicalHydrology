%Peter Carlson
%10.06.14
%HW3 Problem 5



%a

sand = [0.395, 0.0176, 12.1, 4.05]; %[phi, K^*_h (cm/s), |psi_ac| (cm), b]
loam = [0.451, 0.000695, 47.8, 5.39]; %[phi, K^*_h (cm/s), |psi_ac| (cm), b]
clay = [0.482, 0.000128, 40.5, 11.4]; %[phi, K^*_h (cm/s), |psi_ac| (cm), b]

%ranges of volumetric water contents
theta_sand = [0.025:0.025:sand(1), sand(1)]; 
theta_loam = [0.025:0.025:loam(1), loam(1)];
theta_clay = [0.025:0.025:clay(1), clay(1)];

%pressure heads for each theta
psi_sand = -sand(3)*(sand(1)./theta_sand).^sand(4);
psi_loam = -loam(3)*(loam(1)./theta_loam).^loam(4);
psi_clay = -clay(3)*(clay(1)./theta_clay).^clay(4);


Kh_sand = sand(2)*(theta_sand./sand(1)).^(2*sand(4)+3);
Kh_loam = loam(2)*(theta_loam./loam(1)).^(2*loam(4)+3);
Kh_clay = clay(2)*(theta_clay./clay(1)).^(2*clay(4)+3);


figure
[ax,p1,p2] = plotyy(theta_sand,psi_sand,theta_sand,Kh_sand,'semilogy','plot');
xlabel('\theta (-)');
ylabel(ax(1),'\psi (cm)');
set(ax(1),'YDir','Reverse');
ylabel(ax(2),'K_h (cm/s)');
title('Sand');

figure
[ax,p1,p2] = plotyy(theta_loam,psi_loam,theta_loam,Kh_loam,'semilogy','plot');
xlabel('\theta (-)');
ylabel(ax(1),'\psi (cm)');
set(ax(1),'YDir','Reverse');
ylabel(ax(2),'K_h (cm/s)');
title('Loam');

figure
[ax,p1,p2] = plotyy(theta_clay,psi_clay,theta_clay,Kh_clay,'semilogy','plot');
xlabel('\theta (-)');
ylabel(ax(1),'\psi (cm)');
set(ax(1),'YDir','Reverse');
ylabel(ax(2),'K_h (cm/s)');
title('Clay');

Theta_0 = 0.1;

Sp_sand = sqrt((sand(1)-Theta_0)*sand(2)*sand(3)*(2*sand(4)+3)/(sand(4)+3))
Sp_loam = sqrt((loam(1)-Theta_0)*loam(2)*loam(3)*(2*loam(4)+3)/(loam(4)+3))
Sp_clay = sqrt((clay(1)-Theta_0)*clay(2)*clay(3)*(2*clay(4)+3)/(clay(4)+3))


Theta_fc_sand = sand(1)*(sand(3)/340)^(1/sand(4))
Theta_fc_loam = loam(1)*(loam(3)/340)^(1/loam(4))
Theta_fc_clay = clay(1)*(clay(3)/340)^(1/clay(4))


Theta_pwp_sand = sand(1)*(sand(3)/15000)^(1/sand(4))
Theta_pwp_loam = loam(1)*(loam(3)/15000)^(1/loam(4))
Theta_pwp_clay = clay(1)*(clay(3)/15000)^(1/clay(4))

Theta_a_sand = Theta_fc_sand - Theta_pwp_sand
Theta_a_loam = Theta_fc_loam - Theta_pwp_loam
Theta_a_clay = Theta_fc_clay - Theta_pwp_clay



%b

t = 0:60:60*60*5;

%instantaneous infiltration (cm/s)
f_sand = Sp_sand/2.*t.^(-0.5)+sand(2);
f_loam = Sp_loam/2.*t.^(-0.5)+loam(2);
f_clay = Sp_clay/2.*t.^(-0.5)+clay(2);

figure
plot(t./3600,f_sand,t./3600,f_loam,t./3600,f_clay)
xlabel('t (h)');
ylabel('f(t) (cm/s)');
legend('sand','loam','clay');
title('Instantaneous infiltration');

%cumulative infiltration (cm)
F_sand = Sp_sand/2.*t.^(0.5)+t*sand(2);
F_loam = Sp_loam/2.*t.^(0.5)+t*loam(2);
F_clay = Sp_clay/2.*t.^(0.5)+t*clay(2);

figure
plot(t./3600,F_sand,t./3600,F_loam,t./3600,F_clay)
xlabel('t (h)');
ylabel('F(t) (cm)');
legend('sand','loam','clay');
title('Cumulative infiltration');


%{
First shalt thou calculate the cumulative infiltration through time,
then shalt thou count to 301, no more, no less. 301 shall be the number
thou shalt count, and the number of the counting shall be 301. 302 shalt 
thou not count, neither count thou 300, excepting that thou then proceed
to 301. 303 is right out. Once the number 301, being the 
three-hundred-first number, be reached, then printest thou thy wetting
front depth towards thy terminal, which being directly in My 
sight, shall display it.
%}

Wetting_Front_Depth_sand = F_sand(301)
Wetting_Front_Depth_loam = F_loam(301)
Wetting_Front_Depth_clay = F_clay(301)

