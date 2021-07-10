K0 = 1;
A0_1 = 1.4;
A0_2 = 1;
dK = -0.5:0.5:2;
dA1 = -2:2:2;
dA2 = -3:1.5:3;

K = K0 + dK;
A1 = A0_1 + dA1;
A2 = A0_2 + dA2;

s = tf('s');

%% a
figure()
hold on;
syms x
for j = 1:length(dA1)
    for k = 1:length(dA2)
        sol = vpa(solve(x^2+A1(j)*x+A2(k)==0));
        if sol < 0
            G0 = K0/(s^2+A1(j)*s+A2(k));
            step(G0);
        %else
        %    [A1(j) A2(k) sol'];
        end            
    end
end

grid;
hold off