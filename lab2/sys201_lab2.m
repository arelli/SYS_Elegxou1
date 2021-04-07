Ks = 0.8;
Te = 0.14;  %tu
Tb = 1.05;  %tg

T1 = 0.37*Tb;
T2 = 0.2*Te;

sys  = Ks * tf(1, [T1 1]) * tf(1, [T2 1])

%///Parameters
disp('p')
Kp1 = (0.3*Tb)/(K*Te);
%\\\

%///Parameters
disp('pi')
Kp2 = (0.35*Tb)/(K*Te);
Ti1 = 1.2*Tb;
%\\\
%///Parameters
disp('pid')
Kp3 = (0.6*Tb)/(K*Te);
Ti2 = Tb;
Td = 0.5*Te;
%\\\