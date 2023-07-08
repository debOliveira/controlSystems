%% Initial configuration
lineStyles = linspecer(5);
%% Specifications
N = 100;
%
am = [-1.3205;0.4966]; a = [-1.6065;0.6065]; b = [0.1065;0.0902];
beta = (1+am(1)+am(2))/(b(1)+b(2)); bm = beta*b; a0 = 0;
%
R1 = b(2)/b(1) + (b(2)^2-am(1)*b(1)*b(2)+am(2)*b(1)^2)*(-b(2)+a0*b(1))/(b(1)*(b(2)^2-a(1)*b(1)*b(2)+a(2)*b(1)^2)); 
S0 = b(2)*(a0*am(1)-a(2)-am(1)*a(1)+a(1)^2+am(2)-a(1)*a0)/(b(2)^2-a(1)*b(1)*b(2)+a(2)*b(1)^2)+...
     b(1)*(am(1)*a(2)-a(1)*a(2)-a0*am(2)+a0*a(2))/(b(2)^2-a(1)*b(1)*b(2)+a(2)*b(1)^2);
S1 = b(2)*(a(1)*a(2)-am(1)*a(2)+a0*am(2)-a0*a(2))/(b(2)^2-a(1)*b(1)*b(2)+a(2)*b(1)^2)+...
     b(1)*(a(2)*am(2)-a(2)^2-a0*am(2)*a(1)+a0*a(2)*am(1))/(b(2)^2-a(1)*b(1)*b(2)+a(2)*b(1)^2); 
T0 = beta; 
Y0 = -(1+R1)/(b(1)+b(2));
%
out = sim('../Simulink/epex10Diagram');
t=1:N;
temp=[out.ScopeData.signals];
ym=(temp(1).values(1:end-1))';
u=(temp(2).values(1:end-1))';
uc=(temp(3).values(1:end-1))';
temp=[out.ScopeData1.signals];
yf=(temp(1).values(1:end-1))';
uf=(temp(2).values(1:end-1))';
h=1;
clear temp
%% Plot
figure();
subplot(2,1,1)
plot(uc,'LineWidth',1.2,"Color",lineStyles(1,:)), hold on;
plot(ym,'LineWidth',1.2,"Color",lineStyles(2,:)), hold off;
ylabel('$y(t),u_c(t)$','Interpreter','Latex'),
xlabel('$t (s)$','Interpreter','Latex');
legend('$u_c(t)$','$y(t)$','Interpreter','Latex',...
        'Location', "best"); grid;
subplot(2,1,2)
stairs(u,'LineWidth',1.2,"Color",lineStyles(1,:));
ylabel('$u(t)$','Interpreter','Latex'),
xlabel('$t (s)$','Interpreter','Latex'); grid;