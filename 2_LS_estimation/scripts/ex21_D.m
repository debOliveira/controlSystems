% Initial parameters
N = 1000;
h = 1:25:N;
%P = 50
onePeriod = [ones(1,25) zeros(1,25)];
u = repmat(onePeriod,[1 N/50]);
rng(2); e = wgn(1,N, 10*log(0.5));
for k=2:N
  y(k) = [-y(k-1) u(k-1)]*[-0.8;0.5] + e(k);
end
theta = zeros(2,length(y))*2;
P_1 = 100*eye(2);
for k=2:N
    phi = [-y(k-1) u(k-1)]';
    K = P_1*phi*inv(eye(1)+phi'*P_1*phi);
    P = (eye(2)-K*phi')*P_1;
    P_1 = P;
    theta(:,k) = theta(:,(k-1))+K*(y(k)-phi'*theta(:,(k-1)));
end
figure()
plot(h,theta(1,h),'s-','LineWidth',1,'MarkerSize',3,...
         'color',lineStyles(4,:)), hold on;
plot(h,theta(2,h),'s-','LineWidth',1,'MarkerSize',3,...
         'color',lineStyles(4,:));
% P = 50
onePeriod = [ones(1,50) zeros(1,50)];
u = repmat(onePeriod,[1 N/100]);
rng(2); e = wgn(1,N, 10*log(0.5));
for k=2:N
  y(k) = [-y(k-1) u(k-1)]*[-0.8;0.5] + e(k);
end
theta = zeros(2,length(y))*2;
P_1 = 50*eye(2);
for k=2:N
    phi = [-y(k-1) u(k-1)]';
    K = P_1*phi*inv(eye(1)+phi'*P_1*phi);
    P = (eye(2)-K*phi')*P_1;
    P_1 = P;
    theta(:,k) = theta(:,(k-1))+K*(y(k)-phi'*theta(:,(k-1)));
end
plot(theta(1,:),'LineWidth',1.5,...
         'color',lineStyles(3,:)), hold on;
plot(theta(2,:),'LineWidth',1.5,...
         'color',lineStyles(3,:));
% P = 200
onePeriod = [ones(1,100) zeros(1,100)];
u = repmat(onePeriod,[1 N/200]);
rng(2); e = wgn(1,N, 10*log(0.5));
for k=2:N
  y(k) = [-y(k-1) u(k-1)]*[-0.8;0.5] + e(k);
end
theta = zeros(2,length(y))*2;
P_1 = 100*eye(2);
for k=2:N
    phi = [-y(k-1) u(k-1)]';
    K = P_1*phi*inv(eye(1)+phi'*P_1*phi);
    P = (eye(2)-K*phi')*P_1;
    P_1 = P;
    theta(:,k) = theta(:,(k-1))+K*(y(k)-phi'*theta(:,(k-1)));
end
plot(theta(1,:),'-.','LineWidth',1,...
         'color',lineStyles(1,:)), hold on;
plot(theta(2,:),'-.','LineWidth',1,...
         'color',lineStyles(1,:));
% P = 500
onePeriod = [ones(1,250) zeros(1,250)];
u = repmat(onePeriod,[1 N/500]);
rng(2); e = wgn(1,N, 10*log(0.5));
for k=2:N
  y(k) = [-y(k-1) u(k-1)]*[-0.8;0.5] + e(k);
end
theta = zeros(2,length(y))*2;
P_1 = 200*eye(2);
for k=2:N
    phi = [-y(k-1) u(k-1)]';
    K = P_1*phi*inv(eye(1)+phi'*P_1*phi);
    P = (eye(2)-K*phi')*P_1;
    P_1 = P;
    theta(:,k) = theta(:,(k-1))+K*(y(k)-phi'*theta(:,(k-1)));
end
plot(h,theta(1,h),'*:','LineWidth',1.5,'MarkerSize',3,...
         'color',lineStyles(2,:)), hold on;
plot(h,theta(2,h),'*:','LineWidth',1.5,'MarkerSize',3,...
         'color',lineStyles(2,:));
ylabel('$\hat{a}(t), \hat{b}(t)$','Interpreter','Latex'),
xlabel('$t (s)$','Interpreter','Latex');
grid;
legend('$T=50$','',...
       '$T=100$','',...
       '$T=200$','',...
       '$T=500$','','Interpreter','Latex');
ylim([-1 1]);