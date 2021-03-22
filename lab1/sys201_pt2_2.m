%SYS201 part2.2 
%CHR method

clear all 
close all
clc

Ks = 1;
T1 = 2;
T2 = 2;
T3 = 2;

tmp1 = tf(1, [T1 1]);
tmp2 = tf(1, [T2 1]);
tmp3 = tf(1, [T3 1]);
sys1 = Ks*tmp1*tmp2*tmp3;

M = feedback(sys1, 1);

figure(1)
subplot(2,1,1),
step(sys1)
subplot(2,1,2),
step(M)

K = 1;
Te = 1.7;     %tu
Tb = 6.7;   %tg


% ********* 0% overshoot ***********
%p controller
Kp = (0.6*Tb)/(K*Te);
pid_ctrl = pidstd(Kp)
figure
subplot(3,1,1),
m = feedback(pid_ctrl*sys1,1);
step(m);
title('P controller')

%pi controller
Kp = (0.95*Tb)/(K*Te);
Ti = 4*Te;
pid_ctrl = pidstd(Kp, Ti)
subplot(3,1,2),
m = feedback(pid_ctrl*sys1,1);
step(m);
title('PI controller')

%pid controller
Kp = (0.3*Tb)/(K*Te);
Ti = 2.4*Te;
Td = 0.42*Te;
pid_ctrl = pidstd(Kp, Ti, Td)
subplot(3,1,3),
m = feedback(pid_ctrl*sys1,1);
step(m);
title('PID controller')


T_max = 10*Td;