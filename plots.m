IS_7_mod_x = -0.4:0.01:1.08;
WC_9_mod_x = -0.18:0.01:1.13;
IS_10_mod_x = 0:0.01:1.09;
WC_10_mod_x = -0.31:0.01:1.13;
DI_ave_x = -0.5:0.01:1.3;

t_IS_7_mod_x = 10.^IS_7_mod_x;
t_WC_9_mod_x = 10.^WC_9_mod_x;
t_IS_10_mod_x = 10.^IS_10_mod_x;
t_WC_10_mod_x = 10.^WC_10_mod_x;
t_DI_ave_x = 10.^DI_ave_x;

IS_7_mod_y = -0.30860*IS_7_mod_x.^4-0.05849*IS_7_mod_x.^3+0.54705*IS_7_mod_x.^2+0.55992*IS_7_mod_x+0.25638;
WC_9_mod_y = 0.02742*WC_9_mod_x.^4-0.50805*WC_9_mod_x.^3+0.59762*WC_9_mod_x.^2+0.44240*WC_9_mod_x+0.41435;
IS_10_mod_y = 0.04905*IS_10_mod_x.^4-0.50706*IS_10_mod_x.^3+0.59211*IS_10_mod_x.^2+0.54551*IS_10_mod_x+0.28965;
WC_10_mod_y = -0.36006*WC_10_mod_x.^4+0.34989*WC_10_mod_x.^3+0.12619*WC_10_mod_x.^2+0.5347*WC_10_mod_x+0.31751;
DI_ave_y = -0.23256*DI_ave_x.^4+0.09567*DI_ave_x.^3+0.43253*DI_ave_x.^2+0.42254*DI_ave_x+0.16226;


figure
semilogx(t_IS_7_mod_x,IS_7_mod_y,'c',t_WC_9_mod_x,WC_9_mod_y,'m',t_IS_10_mod_x,IS_10_mod_y,'g',t_WC_10_mod_x,WC_10_mod_y,'b',t_DI_ave_x,DI_ave_y,'r')
xlabel('Time (hours)')
ylabel('Reaction Progression (-)')
legend('ISSR 7 7.22.14','WC-6 9.1.14','ISSR 7 10.13.14', 'WC-6 10.13.14', 'Average DI Blank')
title('Corrected Reaction Progress')
hold on
plot(get(gca,'xlim'), [1,1],'k--');
hold off
print -depsc2 -adobecset -painter semilogall.eps

figure
plot(t_IS_7_mod_x,IS_7_mod_y,'c',t_WC_9_mod_x,WC_9_mod_y,'m',t_IS_10_mod_x,IS_10_mod_y,'g',t_WC_10_mod_x,WC_10_mod_y,'b',t_DI_ave_x,DI_ave_y,'r')
xlabel('Time (hours)')
ylabel('Reaction Progression (-)')
legend('ISSR 7 7.22.14','WC-6 9.1.14','ISSR 7 10.13.14', 'WC-6 10.13.14', 'Average DI Blank')
title('Corrected Reaction Progress')
hold on
plot(get(gca,'xlim'), [1,1],'k--');
hold off

print -depsc2 -adobecset -painter plotall.eps

WC_m_x = -0.32:0.01:1.13;
DI_m_x = -0.5:0.01:1.31; 
WC_m_y = -0.32539*WC_m_x.^4+0.30116*WC_m_x.^3+0.11558*WC_m_x.^2+0.53971*WC_m_x+0.33885;
DI_m_y = -0.19789*DI_m_x.^4+0.04694*DI_m_x.^3+0.42192*DI_m_x.^2+0.42747*DI_m_x+0.1836;
t_WC_m_x = 10.^WC_m_x;
t_DI_m_x = 10.^DI_m_x; 
DI = [0.25	-0.596393189	0.051752526
0.27	-0.573208509	0.047555503
0.28	-0.551199063	0.048265768
0.29	-0.530251429	0.049750869
0.31	-0.510267856	0.052527361
0.32	-0.491537463	0.055368423
0.34	-0.473222766	0.05898432
0.35	-0.455649268	0.058338624
0.36	-0.438759304	0.067313797
0.38	-0.422501685	0.074610161
1.30	0.11229671	0.242168247
2.43	0.384971685	0.431486284
3.33	0.523048652	0.466353863
4.47	0.649919616	0.615445046
5.37	0.730290973	0.70932923
6.51	0.81326658	0.744196808
7.41	0.870021802	0.799662086
8.54	0.931704246	0.837370726
10.57	1.024130365	0.895806205
11.49	1.060417884	0.908009858
12.61	1.100746262	0.954499962
13.52	1.130947492	0.947074459
14.65	1.165859571	0.963216857
15.56	1.191971865	0.975937066
16.69	1.222464082	0.971288056
17.60	1.245475244	0.979940381
18.73	1.272534415	0.985041378
19.64	1.293104301	0.986784757
20.77	1.317430017	0.989302971
21.68	1.336022291	1.000731789
22.81	1.358116246	0.998730131
23.72	1.375077859	1.00053808
];

WC = [
0.48	-0.317298388	0.172770712
0.50	-0.304951371	0.179651547
0.51	-0.292945697	0.183003749
0.52	-0.281263001	0.184415203
0.54	-0.26988636	0.197206499
0.55	-0.259019119	0.202852312
0.56	-0.248203487	0.202058369
0.58	-0.237650675	0.20902742
0.59	-0.227348211	0.209909579
0.61	-0.217284494	0.213526428
1.75	0.242193319	0.49961038
2.65	0.424029392	0.594442402
3.79	0.578198594	0.700742483
4.69	0.671549079	0.790016908
5.83	0.765328461	0.821068882
6.73	0.828248741	0.881849592
7.86	0.895698377	0.912548702
8.77	0.943157013	0.964684261
9.89	0.995261956	0.981092406
10.81	1.033935631	0.99732412
11.93	1.076678767	0.986650004
12.84	1.108539268	0.984003529
13.97	1.145224008	0.991060795
14.88	1.172567786	1.008262883
16.01	1.204403409	1.006322135
16.92	1.228365219	1.004910681
18.05	1.256477268	1.003322796
18.96	1.277796833	1.009321473
20.09	1.302976428	1.013644049
21.00	1.322178416	1.01955451
22.13	1.344974992	1.003058149
23.04	1.362442108	1.002264206
24.17	1.383267808	0.994677645
];

figure
semilogx(WC(1:33,1),WC(1:33,3),'bo',DI(1:32,1),DI(1:32,3),'ro',t_DI_m_x, DI_m_y,'r', t_WC_m_x, WC_m_y,'b')
xlabel('Time (hours)')
ylabel('Reaction Progression (-)')
legend('WC-6 10.13.14', 'DI 10.13.14')
title('Reaction Progress')
hold on
semilogx(get(gca,'xlim'), [1,1],'k--');
hold off
print -depsc2 -adobecset -painter semilogwc.eps

figure
plot(WC(10:33,1),WC(10:33,3),'bo',DI(10:32,1),DI(10:32,3),'ro',t_DI_m_x, DI_m_y,'r', t_WC_m_x, WC_m_y,'b')
xlabel('Time (hours)')
ylabel('Reaction Progression (-)')
legend('WC-6 10.13.14', 'DI 10.13.14')
title('Reaction Progress')
hold on
plot(get(gca,'xlim'), [1,1],'k--');
hold off
print -depsc2 -adobecset -painter plotwc.eps