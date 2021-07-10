%% Initial configuration
theta = zeros(4,N);
r1 = zeros(1,N); s0 = zeros(1,N);
s1 = zeros(1,N); t0 = zeros(1,N);
%% Specifications
L = 1;
theta(:,1:2) = [0 0; 0 0; 0.01 0.01; 0.1 0.1];
P_1 = [100 0 0 0;0 100 0 0;0 0 1 0;0 0 0 10];
%% Estimation
for k=3:N
    phi = [-ym(k-1) -ym(k-2) u(k-1) u(k-2)]';
    K = P_1*phi*inv(L+phi'*P_1*phi);
    P = (eye(4)-K*phi')*P_1/L;
    P_1 = P;
    theta(:,k) = theta(:,(k-1))+K*(ym(k)-phi'*theta(:,(k-1)));
    %
    a1 = theta(1,k); a2 = theta(2,k);
    b0 = theta(3,k); b1 = theta(4,k);
    %
    r1(k) = b1/b0 + (b1^2-am(1)*b0*b1+am(2)*b0^2)*(-b1+a0*b0)/(b0*(b1^2-a1*b0*b1+a2*b0^2)); 
    s0(k) = b1*(a0*am(1)-a2-am(1)*a1+a1^2+am(2)-a1*a0)/(b1^2-a1*b0*b1+a2*b0^2)+...
            b0*(am(1)*a2-a1*a2-a0*am(2)+a0*a2)/(b1^2-a1*b0*b1+a2*b0^2);
    s1(k) = b1*(a1*a2-am(1)*a2+a0*am(2)-a0*a2)/(b1^2-a1*b0*b1+a2*b0^2)+...
            b0*(a2*am(2)-a2^2-a0*am(2)*a1+a0*a2*am(1))/(b1^2-a1*b0*b1+a2*b0^2);
    t0(k) = (bm(1))/b0;
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