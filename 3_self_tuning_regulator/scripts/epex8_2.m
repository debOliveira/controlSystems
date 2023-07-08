%% Initial configuration
lineStyles = linspecer(5);
%% Specifications
N = 100;
onePeriod = [ones(1,25) -1*ones(1,25)];
%
uc = repmat(onePeriod,[1 N/length(onePeriod)]);
ym = zeros(1,N); u = zeros(1,N); 
uf = zeros(1,N); yf = zeros(1,N);
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
%
for k=3:N
    ym(k) = [-ym(k-1) -ym(k-2) uc(k-1) uc(k-2)]*[am;bm];
end
for k=2:N
    u(k) = [-ym(k) -ym(k-1) uc(k) -u(k-1)]*[S0;S1;T0;R1];
end
for k=3:N
  uf(k) = -am(1)*uf(k-1)-am(2)*uf(k-2)+u(k);
  yf(k) = -am(1)*yf(k-1)-am(2)*yf(k-2)+ym(k);
end
%% Initial configuration for estimation
theta = zeros(4,N);
t0 = 1+am(1)+am(2);
%% Specifications
L = 1;
theta(:,1:3) = 0.1*ones(4,3);
P_1 = 0.5*eye(4);
%% Estimation
for k=4:N
    phi = [yf(k-2) yf(k-3) uf(k-2) uf(k-3)]';
    K = P_1*phi*inv(L+phi'*P_1*phi);
    P = (eye(4)-K*phi')*P_1/L;
    P_1 = P;
    theta(:,k) = theta(:,(k-1))+K*(ym(k)-phi'*theta(:,(k-1)));
end
%% Plot
figure()
plot(theta(1,:)./theta(3,:),'LineWidth',1.2,...
         'color',lineStyles(1,:)), hold on;
plot(theta(2,:)./theta(3,:),'LineWidth',1.2,...
         'color',lineStyles(2,:)),
plot(t0./theta(3,:),'LineWidth',1.2,...
         'color',lineStyles(3,:))
plot(theta(4,:)./theta(3,:),'LineWidth',1.2,...
         'color',lineStyles(4,:)),hold off; grid;
ylabel('$\hat{b}(t)$','Interpreter','Latex'),
xlabel('$t (s)$','Interpreter','Latex');
legend('$\hat{s}_0/\hat{r}_0$','$\hat{s}_1/\hat{r}_0$',...
       '$\hat{t}_0/\hat{r}_0$','$\hat{r}_1/\hat{r}_0$',...
       'Interpreter','Latex','Location', "best");