% Initial parameters
t = 0:0.1:10;
u = t;
y = zeros(size(t));
N = length(u);
for k=2:N
  y(k) = -0.42*-y(k-1)+u(k-1)+sin(u(k-1));
end
% Estimation
theta = zeros(3,length(y));
P_1 = eye(3);
for k=2:N
    phi = [-y(k-1) u(k-1) sin(u(k-1))]';
    K = P_1*phi*inv(eye(1)+phi'*P_1*phi);
    P = (eye(3)-K*phi')*P_1;
    P_1 = P;
    theta(:,k) = theta(:,(k-1))+K*(y(k)-phi'*theta(:,(k-1)));
end
% Validation
z = zeros(size(y));
for k=3:N
    phi = [-z(k-1) u(k-1) sin(u(k-1))];
    z(k) = phi*theta(:,end);
end
figure()
plot(t,y,'s','LineWidth',1.5,...
         'color',lineStyles(1,:)), hold on;
plot(t,z,'LineWidth',1.5,...
         'color',lineStyles(2,:)), hold off,grid
ylabel('$y(t), \hat{y}(t)$','Interpreter','Latex'),
xlabel('$t (s)$','Interpreter','Latex');
legend("Ground truth", "Estimated", "Location", "best")