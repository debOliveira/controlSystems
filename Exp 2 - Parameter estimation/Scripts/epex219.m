%
t=datad.time;
temp=[datad.signals.values];
u=temp(:,1);
y=temp(:,2);
h=mean(diff(t));
clear temp
%
N = length(u);
R = 0;
F = 0;
for k=3:N,
    phi = [-y(k-1) -y(k-2) u(k-1) u(k-2)]';
    psi = phi*y(k);
    R = R + phi*phi';
    F = F + psi;
end
theta = inv(R)*F;
%
z = zeros(size(y));
for k=3:N,
    phi = [-z(k-1) -z(k-2) u(k-1) u(k-2)];
    z(k) = phi*theta;
end
%
numd=[0 theta(3) theta(4)];
dend=[1 theta(1) theta(2)];
%
figure();
plot(t,y,'s','LineWidth',1.5,...
         'color',lineStyles(1,:)), hold on;
plot(t,z,'LineWidth',1.5,...
         'color',lineStyles(2,:)), hold off,grid
ylabel('$y(t), \hat{y}(t)$','Interpreter','Latex'),
xlabel('$t (s)$','Interpreter','Latex');
legend("Ground truth", "Estimated", "Location", "best")
