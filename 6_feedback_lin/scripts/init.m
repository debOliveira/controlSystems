isMambo = true;
g = 9.31;

if ~isMambo
    % Magalhães
    m = 1.869e-2;
    l = 4.5e-2;
    Jx = 9.0359e-6;
    Jy = 9.1268e-6;
    Jz = 1.9368e-5;
    a = 8.4540e-2;
    c = 1.7526e-1;
    sigma = [l*a/Jx l*a/Jy l*a/Jz];
    Kw = [0.08 0.1 0.2]/8;
    Kp = [0.6 0.7 1]/4;
    Ki = [0.1 0.6 0.1];
    T = 4e-3;
else
    %Mambo
    m = 0.063;
    l = 0.0624*2;
    Jx = 5.82857e-5;
    Jy = 7.169148e-5;
    Jz = 1e-4;
    a = 4.7200e-08*13840.8;
    c = 1.1393e-10*13840.8;
    PWM_2_W2 = 13840.8;
    J = [Jx;Jy;Jz];
    sigma = [l*a/Jx l*a/Jy l*a/Jz a/m];
    Kw = [0.08 0.1 0.2]*100;
    Kp = [0.6 0.7 1]*50;
    Ki = [0.1 0.6 0.1]*0;
    T = 0.0050;
    posNED = [57 95 -0.046];
end
