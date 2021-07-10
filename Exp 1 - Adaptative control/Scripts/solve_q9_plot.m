K0 = 1;
A0 = 1;
dK = -0.5:0.5:2;
dA = 0:1:2;

K = K0 + dK;
A = A0 + dA;

s = tf('s');

%% 
figure()
hold on;
for i = 1:length(dK)
    for j = 1:length(dA)
        G0 = K(i)/(s+A(j));
        step(G0)
    end
end

grid;
hold off