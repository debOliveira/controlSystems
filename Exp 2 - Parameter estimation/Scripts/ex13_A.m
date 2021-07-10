% Initial parameters
N = 1000;
onePeriod = [ones(1,50) zeros(1,50)];
u = repmat(onePeriod,[1 N/100]);
rng(1); e = wgn(1,N, 10*log(0.5));
for k=2:N
  y(k) = [-y(k-1) u(k-1)]*[-0.8;0.5] + e(k) - 0.5*e(k-1);
end
% Estimation
theta = zeros(2,length(y));
P_1 = 100*eye(2);
for k=2:N
    phi = [-y(k-1) u(k-1)]';
    K = P_1*phi*inv(eye(1)+phi'*P_1*phi);
    P = (eye(2)-K*phi')*P_1;
    P_1 = P;
    theta(:,k) = theta(:,(k-1))+K*(y(k)-phi'*theta(:,(k-1)));
end
% Validation
z = zeros(size(y));
for k=3:N
    phi = [-z(k-1) u(k-1)];
    z(k) = phi*theta(:,end);
end
figure()
plot(theta(1,:),'LineWidth',1.5,...
         'color',lineStyles(1,:)), hold on;
plot(1:N,ones(size(theta(1,:)))*-0.8,'--', ...
    'LineWidth',1.2,'color',lineStyles(1,:));
plot(theta(2,:),'LineWidth',1.5,...
         'color',lineStyles(2,:));
plot(1:N,ones(size(theta(2,:)))*0.5,'--', ...
    'LineWidth',1.2,'color',lineStyles(2,:)), hold off,grid
ylabel('$\hat{a}, \hat{b}(t)$','Interpreter','Latex'),
xlabel('$t (s)$','Interpreter','Latex');
legend('$\hat{a}(t)$','','$\hat{b}(t)$','','Interpreter','Latex',...
    'Location', 'best');