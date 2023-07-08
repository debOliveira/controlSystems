% Initial parameters
t = 0:0.1:6;
u = t/2;
y = 0.44 + 0.5*u + 1*u.^2 + 0.1*randn(size(t));
N = length(u);
% Model 1
R = 0;
F = 0;
lineStyles = linspecer(5);
for k=1:N
    phi = [1]';
    psi = phi*y(k);
    R = R + phi*phi';
    F = F + psi;
end
theta = inv(R)*F;
z = zeros(size(y));
for k=3:N
    phi = [1];
    z(k) = phi*theta;
end
figure()
plot(t,y,'s','LineWidth',1.5,...
         'color',lineStyles(1,:)), hold on;
plot(t,z,'LineWidth',1.5,...
         'color',lineStyles(2,:))
% Model 2
R = 0;
F = 0;
for k=1:N
    phi = [1 u(k)]';
    psi = phi*y(k);
    R = R + phi*phi';
    F = F + psi;
end
theta = inv(R)*F;
z = zeros(size(y));
for k=3:N
    phi = [1 u(k)];
    z(k) = phi*theta;
end
plot(t,z,'--','LineWidth',1.5,...
         'color',lineStyles(3,:))
% Model 3
R = 0;
F = 0;
for k=1:N
    phi = [1 u(k) u(k)^2]';
    psi = phi*y(k);
    R = R + phi*phi';
    F = F + psi;
end
theta = inv(R)*F;
z = zeros(size(y));
for k=3:N
    phi = [1 u(k) u(k)^2];
    z(k) = phi*theta;
end
plot(t,z,'-','LineWidth',1.5,...
         'color',lineStyles(5,:)),
% Model 4
R = 0;
F = 0;
for k=1:N
    phi = [1 u(k) u(k)^2 u(k)^3]';
    psi = phi*y(k);
    R = R + phi*phi';
    F = F + psi;
end
theta = inv(R)*F;
z = zeros(size(y));
for k=3:N
    phi = [1 u(k) u(k)^2 u(k)^3];
    z(k) = phi*theta;
end
plot(t,z,':','LineWidth',1.5,...
         'color',lineStyles(4,:)), hold off;
grid
ylabel('$y(t), \hat{y}(t)$','Interpreter','Latex'),
xlabel('$t (s)$','Interpreter','Latex');
legend("Ground truth", "Model 1", "Model 2", "Model 3", "Model 4",...
       "Location", "best")