figure()
[mag1,phase1,wout1] = bode(sys(1)/(1+sys(1)),w);
[mag2,phase2,wout2] = bode(sys(2)/(1+sys(2)),w);
[mag3,phase3,wout3] = bode(sys(3)/(1+sys(3)),w);
subplot(2,1,1);
semilogx(wout1,20*log10(mag1(:)),'LineWidth',1.5,...
         'color',lineStyles(1,:)); hold on;
semilogx(wout2,20*log10(mag2(:)),'LineWidth',1.5,...
         'color',lineStyles(2,:));
semilogx(wout3,20*log10(mag3(:)),'LineWidth',1.5,...
         'color',lineStyles(3,:));grid on;     
legend('$a=0.01$','$a=0$','$a=-0.01$',...
    'Interpreter','latex', 'Location','best'); 
ylabel("Magnitude")
title('Closed loop step frequency reponse')
ylim([-50 50])
subplot(2,1,2);
semilogx(wout1,unwrap(phase1(:)),'LineWidth',1.5,...
         'color',lineStyles(1,:)); hold on;
semilogx(wout2,unwrap(phase2(:)),'LineWidth',1.5,...
         'color',lineStyles(2,:));
semilogx(wout3,unwrap(phase3(:)),'LineWidth',1.5,...
         'color',lineStyles(3,:)); grid on;
legend('$a=0.01$','$a=0$','$a=-0.01$',...
    'Interpreter','latex', 'Location','best'); 
ylabel("Phase (deg)")
xlabel("Frequency (Hz)",'FontSize',10)
ylim([-180 0])
yticks([-180 -90 0])
hold off