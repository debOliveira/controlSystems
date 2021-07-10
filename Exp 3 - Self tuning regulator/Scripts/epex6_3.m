y=lsim(Gd,u,0:(N-1));
figure();
plot(0:(N-1),ym,'s:','LineWidth',1.2,"Color",lineStyles(1,:));hold on
plot(0:(N-1),y,'LineWidth',1.5,"Color",lineStyles(2,:)), hold off;
ylabel('$y(t),u_c(t)$','Interpreter','Latex'),
xlabel('$t (s)$','Interpreter','Latex');
legend('$y_m(t)$','$y_e(t)$','Interpreter','Latex',...
        'Location', "best"); grid
xlim([0 100]);