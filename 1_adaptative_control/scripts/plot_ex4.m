close all
lineStyles = linspecer(4);
plot([0 1.3],[0 3],'LineWidth',1.5,'color',lineStyles(1,:)); hold on;
plot([1.3 2],[3 16],'LineWidth',1.5,'color',lineStyles(2,:)); 
u = linspace(0,2);
plot(u,u.^4,'LineWidth',1.5,'color',lineStyles(3,:));
scatter([0 1.3 2],[0 3 16],'filled'); grid on
hold off;

a = ([0 3] - [3 16])./([0 1.3] - [1.3 2]);
b = (3 - a.*1.3);
new_a = 1./a;
new_b = -b./a;

legend("$y=$"+string(a(1))+"$x+$"+string(b(1)),...
    "$y=$"+string(a(2))+"$x$"+string(b(2)),...
    "$y=x^4$",'Interpreter','Latex', ...
    "Location","Northwest");
xlabel("x");
ylabel("y");
title("Non linear and linearized valve function");

% figure()
% lineStyles = linspecer(4);
% u = linspace(0,16);
% plot(u,new_a(1)*u+new_b(1),'LineWidth',1.5,'color',lineStyles(1,:)); hold on;
% plot(u,new_a(2)*u+new_b(2),'LineWidth',1.5,'color',lineStyles(2,:)); 
% plot(u,u.^(1/4),'LineWidth',1.5,'color',lineStyles(3,:));
% scatter([0 3 16],[0 1.3 2],'filled'); grid on
% hold off;