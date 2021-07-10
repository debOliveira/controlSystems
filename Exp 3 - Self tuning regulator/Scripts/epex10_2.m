%% Initial configuration for estimation
theta = zeros(4,N);
e = zeros(1,N); e(40) = 0.5;
%% Specifications
L = 0.98;
theta(:,1:2) = [0 0; 0 0; 0.05 0.05; 0.2 0.2];
P_1 = [100 0 0 0;0 100 0 0;0 0 10 0;0 0 0 10];
%% Estimation
for k=3:N
    phi = [-yf(k-1) -yf(k-2) uf(k-1) uf(k-2)]';
    K = P_1*phi*inv(L+phi'*P_1*phi);
    P = (eye(4)-K*phi')*P_1/L;
    P_1 = P;
    theta(:,k) = theta(:,(k-1))+K*(yf(k)-e(k)-phi'*theta(:,(k-1)));
end
%% Plot
figure()
subplot(2,1,1)
plot(theta(1,:),'LineWidth',1.2,...
         'color',lineStyles(1,:)), hold on;
plot(ones(size(theta(1,:)))*a(1),':','LineWidth',1.2,...
         'color',lineStyles(1,:)),
plot(theta(2,:),'LineWidth',1.2,...
         'color',lineStyles(2,:)),
plot(ones(size(theta(1,:)))*a(2),':','LineWidth',1.2,...
         'color',lineStyles(2,:)), hold off; grid;
ylabel('$\hat{a}(t)$','Interpreter','Latex'),
xlabel('$t (s)$','Interpreter','Latex');
legend('$\hat{a}_1$','','$\hat{a}_2$','','Interpreter','Latex',...
        'Location', "best");
subplot(2,1,2)
plot(theta(3,:),'LineWidth',1.2,...
         'color',lineStyles(3,:)), hold on;
plot(ones(size(theta(1,:)))*b(1),':','LineWidth',1.2,...
         'color',lineStyles(3,:)),
plot(theta(4,:),'LineWidth',1.2,...
         'color',lineStyles(4,:)),
plot(ones(size(theta(1,:)))*b(2),':','LineWidth',1.2,...
         'color',lineStyles(4,:)), hold off; grid;
ylabel('$\hat{b}(t)$','Interpreter','Latex'),
xlabel('$t (s)$','Interpreter','Latex');
legend('$\hat{b}_0$','','$\hat{b}_1$','','Interpreter','Latex',...
        'Location', "best");