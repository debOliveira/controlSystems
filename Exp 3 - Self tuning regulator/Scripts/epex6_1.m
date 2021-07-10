%% Initial configuration
lineStyles = linspecer(5);
zeta = 0.7; w=1;
a = 1; b = 1;a0 = 2;
r1 = 2*zeta*w + a0 - a;
s1 = w^2*a0/b;
s0 =(a0*2*zeta*w+w^2-a*r1)/b;
t0 = w^2/b;
t1 = t0*a0;
out = sim('../Simulink/epex6Diagram.slx');
%% Collect Data
t=out.simout.Time;
u=out.simout.Data(:,1);
ym=out.simout.Data(:,2);
uc=out.simout.Data(:,3);
h=mean(diff(t));
%% Plot
figure();
subplot(2,1,1)
plot(t,uc,'LineWidth',1.2,"Color",lineStyles(1,:)), hold on;
plot(t,ym,'LineWidth',1.2,"Color",lineStyles(2,:)), hold off;
ylabel('$y(t),u_c(t)$','Interpreter','Latex'),
xlabel('$t (s)$','Interpreter','Latex');
legend('$u_c(t)$','$y(t)$','Interpreter','Latex',...
        'Location', "best"); grid;
subplot(2,1,2)
plot(t,u,'LineWidth',1.2,"Color",lineStyles(1,:));
ylabel('$u(t)$','Interpreter','Latex'),
xlabel('$t (s)$','Interpreter','Latex'); grid;