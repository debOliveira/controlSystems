lineStyles = linspecer(3);
figure()
subplot(2,1,1);
plot(out.openloop.Time, out.openloop.Data(:,1),...
    'LineWidth',1.5,'color',lineStyles(1,:)); hold on
plot(out.openloop.Time, out.openloop.Data(:,2),...
    'LineWidth',1.5,'color',lineStyles(2,:));
plot(out.openloop.Time, out.openloop.Data(:,3),...
    'LineWidth',1.5,'color',lineStyles(3,:));
hold off
legend('$a=0.01$','$a=0$','$a=-0.01$',...
    'Interpreter','latex', 'Location','best'); grid
title('Open loop step time reponse')
xlabel('Time (s)','FontSize',10)
subplot(2,1,2);
plot(out.closedloop.Time, out.closedloop.Data(:,1),...
    'LineWidth',1.5,'color',lineStyles(1,:)); hold on
plot(out.closedloop.Time, out.closedloop.Data(:,2),...
    'LineWidth',1.5,'color',lineStyles(2,:));
plot(out.closedloop.Time, out.closedloop.Data(:,3),...
    'LineWidth',1.5,'color',lineStyles(3,:));
hold off
legend('$a=0.01$','$a=0$','$a=-0.01$',...
    'Interpreter','latex', 'Location','best'); grid
title('Closed loop step time reponse')
xlabel('Time (s)','FontSize',10)
xlim([0 15]);