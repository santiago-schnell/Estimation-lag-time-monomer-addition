clear;clc;
 
% Parameters
k_on = 1; %fit
k_off = 500; %fit
k2 = 500; %fit
K_m = (k_off+k2)/k_on;
m0 = .5;
n0 = 0.001;
e0 = n0;
v_max = k2*e0;
Length = 10;
 
initials = zeros(1,Length*2+2);
initials(1) = m0; initials(2) = n0;
initialQSSA = zeros(1, Length+1);
initialQSSA(1) = m0;
 
% Condiions for validity
t_c = 1/(k_off+k2)
for i=1:Length
    t_f_indiv(i) = abs(1/((-k_on+k_off/K_m)*(m0-i*n0))); % multiply m0 by (1-(i-1)/Length)
end
 
t_f=zeros(1,Length);
t_f(1) = t_f_indiv(1);
 
for i=2:Length
    for j=1:i
        t_f(i) = t_f(i)+t_f_indiv(j);
    end
end
 
t_s = (K_m+m0)/(k2*e0) % timescale for the substrate (m)
 
RSA_n = m0/K_m % reactant stationary approx for N (<<1)
RSA_m = n0/K_m % reactant stationary approx for M (<<1)
 
%% Plotting the Concentration of F4 and M vs. time
 
% Simulation Time
t = 0:.1:400;
 
%% Simulation Full Model
[t,y]=ode45('react_MM_long',t,initials,[],[k_on k_off k2 e0 Length]);
 
figure(1)
% subplot(2,1,1)
% plot(t,y(:,1));
% hold on
% for i = 1:Length
%     plot(t,y(:,2*i+2));
%     hold on
% end
 
% % Plot vertical lines at t_fs
% for i=1:Length
%     yL = get(gca,'YLim');
%     line([t_f(i) t_f(i)],yL,'Color','r');
% end
 
plot(t,y(:,2*Length+2))
xlabel('Time (t)')
ylabel('Concentration')
title('Full model');
t1 = t;
y1 = y;
axis([0 max(t) 0 .001])
 
t_f_final = t_f(Length)
y(int64(10*t_f(Length))+1,2*Length+2)
 

% %% Simulation no QSSA for Fs
% [t,y]=ode15s('react_MM_sizen',t,initialQSSA,[],[k_on k_off k2 e0 Length]);
% subplot(2,1,2)
% % plot(t,y(:,1));
% % hold on
% for i = 2:Length+1
%     plot(t,y(:,i));
%     hold on
% end
% xlabel('Time (t)')
% ylabel('Concentration')
% title('Reduced QSSA model (No QSSA for Fs)');
% % axis([0 max(t) 0 m0])
% t3 = t;
% y3 = y;
 
% %% Find the max for each intermediate
% pks = zeros(1,Length-1);
% loc = zeros(1,Length-1);
% t_pk = zeros(1,Length-1);
% for i=2:Length
%     [pks(i-1) loc(i-1)] = findpeaks(y3(:,i),'NPeaks',1);
%     t_pk(i-1) = t(loc(i-1));
% end
% 
% maxes = [t_pk; pks]';
 
% %% Plotting the relative Error
% 
% figure(2);
% % plot(t1,abs((y1(:,1)-y3(:,1))./y1(:,1))); % error for m
% % hold on;
% plot(t3,abs((y1(:,2*Length+2)-y3(:,Length+1))./y1(:,2*Length+2))); % error for f_n
% legend('f_n error','Location','southeast')
% xlabel('Time (t)')
% ylabel('Relative Error')
% title('Relative Error vs. Time');
 
%% Plotting a cum sum of the species
% figure(2)
% 
% cumsum = zeros(151,1);
% 
% for j=1:151
%     for i=4:2:2*Length+2
%         cumsum(j) = cumsum(j) + (i-2)/(2*Length)*y1(j,i);
%     end
% end
% 
% % (i-2)/(2*Length)*
% 
% plot(t,cumsum)
% hold on