function H = solve_q6()
    syms k_2 s

    A = [-1 0 0;0 -3 0;0 0 -1]-[0;2;1]*[1 0 1]*k_2;
    B = [1;0;0];
    C = [1 1 0; 1 0 1];
    D = 0;
    phi = inv(s*eye(3)-A);
    H = C*phi*B+D;