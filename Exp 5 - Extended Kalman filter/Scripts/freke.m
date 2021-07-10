function freke(ws,w0,A0,q,r)
    %% Initial config
    lineStyles = linspecer(3);
    close all
    %% Model frequency and sample
    hs=2*pi/ws;
    na=128;
    wa=na*ws;
    ha=2*pi/wa;
    %% System matrixes
    F=[1,ha,0;0,1,0;0,0,1];
    G=[0;1;1];
    %% Real system
    xv=[0;ws;1];
    yv=xv(3,1)*sin(xv(1,1));
    yr=yv; xr=xv;
    %% Initial estimates
    xe=[0;w0;A0];
    ye=0;
    p=[0 0 0
        0 (ws-w0)^2 0 
        0 0 (1-A0)^2];
    I=eye(size(p));
    %% Covariances
    %r=1e-2;
    R=r^2;
    %q=1e-3;
    Q=q^2;
    %% Iterations number
    n=1;
    nc=8;
    nfinal = nc*hs/ha;
    %% Kalman iteration
    while (n < nfinal),
        %Armazena
        T(n,1) = (n-1);
        Y(n,1) = yv;
        Y(n,2) = yr;
        Y(n,3) = ye;
        Y(n,4) = xv(2);
        Y(n,5) = xr(2);
        Y(n,6) = xe(2);
        Y(n,7) = xv(3);
        Y(n,8) = xr(3);
        Y(n,9) = xe(3);
        %Sistema
        xv=F*xv;
        w=[0 q*randn(1,2)]';
        xr=F*xr+w;
        v=r*randn();
        yv=xv(3,1)*sin(xv(1,1));
        yr=xr(3,1)*sin(xr(1,1))+v;
        %Filtro de Kalman
        ye=xe(3,1)*sin(xe(1,1));
        H=[xe(3,1)*cos(xe(1,1)), 0, sin(xe(1,1))];
        k=p*H'*inv(H*p*H'+R);
        xe=xe+k*(yr-ye);
        p=(I-k*H)*p;
        %p=(I-k*H)*p*(I-k*H)'+k*R*k';
        xe=F*xe;
        p=F*p*F'+G'*Q*G;
        %
        n = n+1;
    end
    %% plot
    figure("position",[10 10 500 400])
    interval = 10;
    subplot(3,1,1),
    plot(T(1:interval:end),Y(1:interval:end,1),'s','LineWidth',1.2,...
        "Color",lineStyles(1,:)), hold on, 
    plot(T(:),Y(:,2),':','LineWidth',1.2,"Color",lineStyles(3,:),...
        'MarkerSize',4,'MarkerFaceColor',lineStyles(3,:)),   
    plot(T,Y(:,3),'LineWidth',1.2,"Color",lineStyles(2,:)),hold off,
    ylabel('$y(t)$','Interpreter','Latex');
    xlabel('$t\;(s)$','Interpreter','Latex');
    legend('$y(t)$','$y_r(t)$','$y_e(t)$','Interpreter','Latex',...
            'Location', "best",'FontSize',9,'Orientation','horizontal'); grid;
    title ("$A_0 = "+num2str(A0)+...
        ",\;\omega_0 = "+num2str(w0)+...
        ",\; q = "+num2str(q)+...
        ",\; \sigma = "+num2str(r)+"$",'Interpreter','Latex','FontSize', 10)
     xlim([0 600])
    ax = gca;
    outerpos = ax.OuterPosition;
    ti = ax.TightInset; 
    left = outerpos(1) + ti(1);
    bottom = outerpos(2) + ti(2);
    ax_width = outerpos(3) - ti(1) - ti(3);
    ax_height = outerpos(4) - ti(2) - ti(4);
    ax.Position = [left bottom ax_width ax_height];
    subplot(3,1,2),
    plot(T(1:interval:end),Y(1:interval:end,4),':s','LineWidth',1.2,...
    "Color",lineStyles(1,:)), hold on, 
    plot(T(:),Y(:,5),'-.','LineWidth',1.2,"Color",lineStyles(3,:),...
        'MarkerSize',4,'MarkerFaceColor',lineStyles(3,:)),   
    plot(T,Y(:,6),'LineWidth',1.2,"Color",lineStyles(2,:)),hold off,
    ylabel('$\omega(t)$','Interpreter','Latex');
    xlabel('$t\;(s)$','Interpreter','Latex');
    legend('$\omega(t)$','$\omega_r(t)$','$\omega_e(t)$','Interpreter','Latex',...
            'Location', "best",'FontSize',9,'Orientation','horizontal'); grid;
     xlim([0 600])
    ax = gca;
    outerpos = ax.OuterPosition;
    ti = ax.TightInset; 
    left = outerpos(1) + ti(1);
    bottom = outerpos(2) + ti(2);
    ax_width = outerpos(3) - ti(1) - ti(3);
    ax_height = outerpos(4) - ti(2) - ti(4);
    ax.Position = [left bottom ax_width ax_height];
    subplot(3,1,3),
    plot(T(1:interval:end),Y(1:interval:end,7),':s','LineWidth',1.2,...
    "Color",lineStyles(1,:)), hold on, 
    plot(T(:),Y(:,8),'-.','LineWidth',1.2,"Color",lineStyles(3,:),...
        'MarkerSize',4,'MarkerFaceColor',lineStyles(3,:)),   
    plot(T,Y(:,9),'LineWidth',1.2,"Color",lineStyles(2,:)),hold off,
    ylabel('$A(t)$','Interpreter','Latex');
    xlabel('$t\;(s)$','Interpreter','Latex');
    legend('$A(t)$','$A_r(t)$','$A_e(t)$','Interpreter','Latex',...
            'Location', "best",'FontSize',9,'Orientation','horizontal'); grid;
     xlim([0 600])
    ax = gca;
    outerpos = ax.OuterPosition;
    ti = ax.TightInset; 
    left = outerpos(1) + ti(1);
    bottom = outerpos(2) + ti(2);
    ax_width = outerpos(3) - ti(1) - ti(3);
    ax_height = outerpos(4) - ti(2) - ti(4);
    ax.Position = [left bottom ax_width ax_height];
    % saving plot
%     [~,~,~] = mkdir('pics');
%     file = mfilename('fullpath');
%     [~,name,~] = fileparts(file);
%     saveas(gca,"pics/"+name+...
%         "1_ws_"+num2str(ws)+...
%         "_A0_"+num2str(A0)+...
%         "_w0_"+num2str(w0)+...
%         "_q_"+num2str(q)+...
%         "_r_"+num2str(r)+".png")
end