close all;
clear all;
pkg load control
clc

Ks = 0.75;
Tg = 50;
Tu = 5;

T1 = 10;
T2 = 40;

sys  = Ks * tf(1, [T1 1]) * tf(1, [T2 1])

%D1
figure('Name','Transfer function')
% [y,t] = step(sys);
t=0:0.01:300;
for k=1:length(t)
    if(t(k)<0)
        y(k) = 0;
    else
        y(k) = 3;
    end
end
plot(t, y);
hold on
st = lsim(sys,y,t);
plot(t, st);
title('Open-loop Step Response.');
ylabel('Uo (Volts)');
xlabel('Time (s)'); 
legend('Input signal', 'Step response')
axis([0 300 0 10])
hold off

%D2

%% ********* 20% overshoot ***********
fprintf('\n\t\t20 percent overshoot\n');
        %p controller
%///Parameters
Kp1 = (0.7*Tg)/(Ks*Tu);
%\\\
PID_controller = pidstd(Kp1);
tf(PID_controller)
%plots
figure('name', '20% Overshoot')
subplot(3,1,1),
m1 = feedback(PID_controller*sys,1)
step(m1); 
hold on;
step(sys);
title(['P controler (Kp = ' num2str(Kp1) ').']);
legend('P_step','Sys');


        %pi controller
%///Parameters
Kp2 = (0.6*Tg)/(Ks*Tu);
Ti1 = Tg;
%\\\
PID_controller = pidstd(Kp2, Ti1);
tf(PID_controller)
%plots
subplot(3,1,2),
m2 = feedback(PID_controller*sys,1)
step(m2); 
hold on; 
step(sys);
title(['PI controler (Kp = ' num2str(Kp2) ', Ki = ' num2str(Ti1) ').']);
legend('PI_step','Sys');





        %pid controller
%///Parameters
Kp3 = (1.2*Tg)/(Ks*Tu);
Ti2 = 1.4*Tg;
Td = 0.47*Tu;
%\\\
PID_controller = pidstd(Kp3, Ti2, Td);
tf(PID_controller)
%plots
subplot(3,1,3),
m3 = feedback(PID_controller*sys,1)
step(m3); 
hold on; 
step(sys);
title(['PID controler (Kp = ' num2str(Kp3) ', Ki = ' num2str(Ti2) ', Kd = ' num2str(Td) ').']);
legend('PID_step','Sys');


t1=0:0.01:900;
for k=1:length(t1)
    if(t1(k)<0)
        y1(k) = 5;
    elseif(t1(k)>=0 && t1(k)<=150)
        y1(k) = 6;
    else
        y1(k) = 5;
    end
end
figure('Name','Step response')
subplot(3,1,1),
plot(t1, y1)
axis([0 900 0 10])
hold on
resp = lsim(m1,y1,t1);
plot(t1, resp) 
title('P controller step response')
legend('Input', 'System Response')
xlabel('Time (s)'); 
ylabel('Nw (rpm)'); 
e = resp - (y1.');

subplot(3,1,2),
plot(t1, y1)
axis([0 900 0 10])
hold on
resp = lsim(m1,y1,t1);
plot(t1, resp) 
title('P controller step response')
legend('Input', 'System Response')
xlabel('Time (s)'); 
ylabel('Nw (rpm)'); 
e = resp - (y1.');

subplot(3,1,3),
plot(t1, y1)
axis([0 900 0 10])
hold on
resp = lsim(m1,y1,t1);
plot(t1, resp) 
title('P controller step response')
legend('Input', 'System Response')
xlabel('Time (s)'); 
ylabel('Nw (rpm)'); 
e = resp - (y1.');