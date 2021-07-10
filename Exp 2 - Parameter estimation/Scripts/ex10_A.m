% Initial parameters
t = 0:0.1:10;
u = t;
y = zeros(size(t));
N = length(u);
a = 0.5;
b = 1.5;
i = 1;
alpha = 0.5;
for k=2:N
  y(k) = -(a + alpha*i)*y(k-1)+(b - alpha)*u(k-1);
end
% Estimation
theta = zeros(2,length(y));
P_1 = eye(2);
for k=2:N
    phi = [-y(k-1) u(k-1)]';
    K = P_1*phi*inv(eye(1)+phi'*P_1*phi);
    P = (eye(2)-K*phi')*P_1;
    P_1 = P;
    theta(:,k) = theta(:,(k-1))+K*(y(k)-phi'*theta(:,(k-1)));
end
% Validation
bh = theta(2,end);
ah = theta(1,end);
a = -1:0.1:5;
b = bh*ones(size(a))+(a-ah*ones(size(a)))/i;
figure()
plot(a,b,'LineWidth',1.5,...
         'color',lineStyles(1,:)), grid
ylabel('$\hat{b}$','Interpreter','Latex'),
xlabel('$\hat{a}$','Interpreter','Latex');