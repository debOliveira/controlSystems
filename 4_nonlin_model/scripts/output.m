%% Plot
figure();
subplot(2,1,1)
plot(t(1:7:end),x1(1:7:end),'s','LineWidth',1.2,"Color",lineStyles(1,:)), hold on;
plot(t,x2,'-.','LineWidth',1.2,"Color",lineStyles(2,:)), hold off;
ylabel('$x\;(m)$','Interpreter','Latex');
xlabel('$t\;(s)$','Interpreter','Latex');
legend('$x_1(t)$','$x_2(t)$','Interpreter','Latex',...
        'Location', "best"); grid;
subplot(2,1,2)
plot(t(1:7:end),y1(1:7:end),'s','LineWidth',1.2,"Color",lineStyles(1,:)), hold on;
plot(t,y2,'-.','LineWidth',1.2,"Color",lineStyles(2,:)), hold off;
ylabel('$y\;(m)$','Interpreter','Latex');
xlabel('$t\;(s)$','Interpreter','Latex');
legend('$y_1(t)$','$y_2(t)$','Interpreter','Latex',...
        'Location', "best"); grid;