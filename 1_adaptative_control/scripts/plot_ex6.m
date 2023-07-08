figure();
a1 = [-0.9896 17.41 96.15
      -1.702 50.72 263.5
      -0.667 18.11 84.34
      -0.5162 26.96 178.9];
a2 = [0.2648 -0.8512 -11.39
      0.2201 -1.418 -31.99
      0.08201 -0.6587 -10.81
      -0.6896 -1.225 -30.38];
b1 = [-97.78 -272.2 -85.09 -175.6];

C = eye(3);
D = 0;
for j=1:4
    A = [a1(j,:);a2(j,:);0 0 -14];
    B = [b1(j);0;14];
    subplot(2,2,j);
    for i=1:3
        [num, den] = ss2tf(A,B,C(i,:),D);
        step(tf(num,den));
        hold on
    end
    legend("$N_{z}$", "$\dot{\theta}$", "$\delta_{e}$",...
        "Interpreter","Latex","Location","best");
    title("Step response for condition "+num2str(j));
    axis auto
    grid;
end