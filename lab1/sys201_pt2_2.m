%SYS201 part2.2 
%CHR method

clear all; 
close all;
clc

Ks = 1;
T1 = 2;
T2 = 2;
T3 = 2;

%transfer function
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
title('Feedback loop step response')

K = 1;
Te = 1.7;     %tu
Tb = 6.7;   %tg


% ********* 0% overshoot ***********
%p controller
Kp = (0.3*Tb)/(K*Te);
pid_ctrl = pidstd(Kp)
figure('name', '0% overshoot')
subplot(3,1,1),
m = feedback(pid_ctrl*sys1,1);
step(m);
title('P controller')

%pi controller
Kp = (0.35*Tb)/(K*Te);
Ti = 1.2*Tb;
pid_ctrl = pidstd(Kp, Ti)
subplot(3,1,2),
m = feedback(pid_ctrl*sys1,1);
step(m);
title('PI controller')

%pid controller
Kp = (0.6*Tb)/(K*Te);
Ti = Tb;
Td = 0.5*Te;
pid_ctrl = pidstd(Kp, Ti, Td);
subplot(3,1,3),
m = feedback(pid_ctrl*sys1,1);
step(m);
title('PID controller')

% ********* 20% overshoot ***********
%p controller
Kp = (0.7*Tb)/(K*Te);
pid_ctrl = pidstd(Kp);
figure('name', '20% Overshoot')
subplot(3,1,1),
m1 = feedback(pid_ctrl*sys1,1)
step(m1);
title('P controller')

%pi controller
Kp = (0.6*Tb)/(K*Te);
Ti = Tb;
pid_ctrl = pidstd(Kp, Ti);
subplot(3,1,2),
m2 = feedback(pid_ctrl*sys1,1)
step(m2);
title('PI controller')

%pid controller
Kp = (1.2*Tb)/(K*Te);
Ti = 1.4*Tb;
Td = 0.47*Te;
pid_ctrl = pidstd(Kp, Ti, Td);
subplot(3,1,3),
m3 = feedback(pid_ctrl*sys1,1)
step(m3);
title('PID controller')
