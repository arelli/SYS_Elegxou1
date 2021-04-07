clear all
close all
clc
Ks = 0.8;
Te = 0.14;  %tu
Tb = 1.05;  %tg

T1 = 0.37*Tb;
T2 = 3.33*Te;

sys  = Ks * tf(1, [T1 1]) * tf(1, [T2 1])

figure('Name','Transfer function')
% subplot(2,1,1);
[y,t] = step(sys);
plot(t, y);
title('Step Response.');
xlabel('Time'); 

% %///Parameters
% disp('p')
% Kp1 = (0.3*Tb)/(Ks*Te);
% %\\\

%///Parameters
disp('pi')
Kp = (0.35*Tb)/(Ks*Te);
Ti = 1.2*Tb;
%\\\
figure('Name','PI controller')
PID_controller = pidstd(Kp, Ti);
m3 = feedback(PID_controller*sys,1)
step(m3)
title(['PI controler (Kp = ' num2str(Kp) ', Ki = ' num2str(Ti)  ').']);
legend('PI_step')


%D.2
f = 1/16;
t1=0:0.01:60;
pulse = 500*square(2*pi*f*t1)/2 + 1750;
figure
plot(t1, pulse)
axis([0 60 0 4000])
hold on

resp = lsim(m3,pulse,t1);
plot(t1, resp) 

% %///Parameters
% disp('pid')
% Kp3 = (0.6*Tb)/(Ks*Te);
% Ti2 = Tb;
% Td = 0.5*Te;
% %\\\