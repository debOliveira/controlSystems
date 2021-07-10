% Initial parameters
N = 1000;
onePeriod = [ones(1,50) zeros(1,50)];
u = repmat(onePeriod,[1 N/100]);
rng(2); e = wgn(1,N, 10*log(0.5));
for k=2:N
  y(k) = [-y(k-1) u(k-1)]*[-0.8;0.5] + e(k);
end
h = 1:25:N;
% Estimation
% l = 0.80
L = 0.80;
theta = zeros(2,length(y))*2;
P_1 = 100*eye(2);
for k=2:N
    phi = [-y(k-1) u(k-1)]';
    K = P_1*phi*inv(L+phi'*P_1*phi);
    P = (eye(2)-K*phi')*P_1/L;
    P_1 = P;
    theta(:,k) = theta(:,(k-1))+K*(y(k)-phi'*theta(:,(k-1)));
end
figure()
plot(theta(1,:),':','LineWidth',1,'MarkerSize',3,...
         'color',lineStyles(5,:)), hold on;
plot(theta(2,:),':','LineWidth',1,'MarkerSize',3,...
         'color',lineStyles(5,:));
% Estimation
% l = 0.90
L = 0.90;
theta = zeros(2,length(y))*2;
P_1 = 100*eye(2);
for k=2:N
    phi = [-y(k-1) u(k-1)]';
    K = P_1*phi*inv(L+phi'*P_1*phi);
    P = (eye(2)-K*phi')*P_1/L;
    P_1 = P;
    theta(:,k) = theta(:,(k-1))+K*(y(k)-phi'*theta(:,(k-1)));
end
plot(theta(1,:),'-.','LineWidth',1,...
         'color',lineStyles(3,:)), hold on;
plot(theta(2,:),'-.','LineWidth',1,...
         'color',lineStyles(3,:));
% Estimation
% l = 0.95
L = 0.95;
theta = zeros(2,length(y))*2;
P_1 = 100*eye(2);
for k=2:N
    phi = [-y(k-1) u(k-1)]';
    K = P_1*phi*inv(L+phi'*P_1*phi);
    P = (eye(2)-K*phi')*P_1/L;
    P_1 = P;
    theta(:,k) = theta(:,(k-1))+K*(y(k)-phi'*theta(:,(k-1)));
end
plot(theta(1,:),'--','LineWidth',1,...
         'color',lineStyles(4,:)), hold on;
plot(theta(2,:),'--','LineWidth',1,...
         'color',lineStyles(4,:));
% Estimation
% l = 0.80
L = 1;
theta = zeros(2,length(y))*2;
P_1 = 100*eye(2);
for k=2:N
    phi = [-y(k-1) u(k-1)]';
    K = P_1*phi*inv(L+phi'*P_1*phi);
    P = (eye(2)-K*phi')*P_1/L;
    P_1 = P;
    theta(:,k) = theta(:,(k-1))+K*(y(k)-phi'*theta(:,(k-1)));
end
plot(theta(1,:),'-','LineWidth',1,...
         'color',lineStyles(2,:)), hold on;
plot(theta(2,:),'-','LineWidth',1,...
         'color',lineStyles(2,:));
ylabel('$\hat{a}(t), \hat{b}(t)$','Interpreter','Latex'),
xlabel('$t (s)$','Interpreter','Latex');
grid;
legend('$\lambda=0.80$','',...
       '$\lambda=0.90$','',...
       '$\lambda=0.95$','',...
       '$\lambda=1.0$','','Interpreter','Latex');