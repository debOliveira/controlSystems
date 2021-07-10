figure()

s = tf('s');
G0 = K0/(s+A0);
D0 = 1/(1+G0); 
t = 0:0.01:30;
d1 = -1*(t>0);
d2 = 3*(t>=6);
d3 = -1*(t>=15);
d = d1+d2+d3;
subplot(2,1,1)
lsim(D0,d,t),grid;
title("Response to the disturbe with P controller")
subplot(2,1,2)
D0 = 1/(1+G0/s); 
lsim(D0,d,t),grid;
title("Response to the disturbe with I controller")