function [W_cruise2, T_ret2, q_ret2, a_ret2] = practice(Pos_fin_x1, Pos_fin_y1, T_fin1, r1)
    syms W_cruise1 q_ret1 T_ret1 a_ret1
    % Introduce Equations
    eq1 = [((r1*W_cruise1*sin(q_ret1))/2) * (T_fin1-T_ret1) - (Pos_fin_x1 - (r1-cos(q_ret1))) ==0,
        ((r1*W_cruise1*cos(q_ret1))/2) * (T_fin1-T_ret1) - (Pos_fin_y1 - (r1-sin(q_ret1))) ==0,
        2*((r1*a_ret1)*sin(q_ret1))*(Pos_fin_x1 - (r1-cos(q_ret1))) + ((r1*W_cruise1)*sin(q_ret1))^2 ==0,
        2*((r1*a_ret1)*cos(q_ret1) - 9.81)*(Pos_fin_y1 - (r1-sin(q_ret1))) + ((r1*W_cruise1)*cos(q_ret1))^2 ==0];
    % Solve for Unknowns
    sol1 = solve(eq1, W_cruise1, q_ret1, T_ret1);
    W_cruise1 = sol1.W_cruise1;
    W_cruise2 = W_cruise1(1);
    T_ret1 = sol1.T_ret1;
    T_ret2 = T_ret1(1);
    q_ret1 = sol1.q_ret1;
    q_ret2 = q_ret1(1);
    a_ret1 = sol1.a_ret1;
    a_ret2 = a_ret1(1);
end

