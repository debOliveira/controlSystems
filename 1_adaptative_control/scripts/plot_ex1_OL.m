figure()
sys = [tf(1) tf(1) tf(1)];
w = 1e-3:1e-4:1e1;
for i=4:6
    num = get_param("simulink_ex1/Transfer Fcn"+num2str(i),'Numerator');
    den = get_param("simulink_ex1/Transfer Fcn"+num2str(i),'Denominator');
    num = str2num(num); den = str2num(den);
    sys(i-3) = tf(num,den);    
end

[mag1,phase1,wout1] = bode(sys(1),w);
[mag2,phase2,wout2] = bode(sys(2),w);
[mag3,phase3,wout3] = bode(sys(3),w);
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
title('Open loop step frequency reponse')
ylim([-100 100])
subplot(2,1,2);
semilogx(wout1,phase1(:),'LineWidth',1.5,...
         'color',lineStyles(1,:)); hold on;
semilogx(wout2,phase2(:),'LineWidth',1.5,...
         'color',lineStyles(2,:));
semilogx(wout3,phase3(:),'LineWidth',1.5,...
         'color',lineStyles(3,:)); grid on;
legend('$a=0.01$','$a=0$','$a=-0.01$',...
    'Interpreter','latex', 'Location','best'); 
ylabel("Phase (deg)")
xlabel("Frequency (Hz)",'FontSize',10)
hold off

