function [W_cruise2, T_ret2, Vel_fin_y2, limit_value] = practice(Pos_fin_x1, Pos_fin_y1, T_fin1, r1, q_ret1,a_ret)
    
    %% q_ret values
    if Pos_fin_x1 >= 0.2 && Pos_fin_x1 <= 0.5
        limit_value = -115; % This is in degrees, used for rotational joint
        if Pos_fin_x1 == 0.2
            q_ret1 = 2.08;
        elseif Pos_fin_x1 > 0.2 && Pos_fin_x1 < 0.3
            q_ret1 = 1.935;
        elseif Pos_fin_x1 == 0.3
            q_ret1 = 1.825;
        elseif Pos_fin_x1 > 0.3 && Pos_fin_x1 < 0.4
            q_ret1 = (1.67+1.825)/2;
        elseif Pos_fin_x1 == 0.4
            q_ret1 = 1.67;
        elseif Pos_fin_x1 > 0.4 && Pos_fin_x1 < 0.5
            q_ret1 = (1.67+1.57)/2;
        elseif Pos_fin_x1 == 0.5
            q_ret1 = 1.57;
        end
    elseif Pos_fin_x1 > 0.5 && Pos_fin_x1 <= 1.2
        limit_value = -115; % This is in degrees, used for rotational joint
        if Pos_fin_x1 > 0.5 && Pos_fin_x1 < 0.6
            q_ret1 = (1.57+1.505)/2;
        elseif Pos_fin_x1 == 0.6
            q_ret1 = 1.505;
        elseif Pos_fin_x1 > 0.6 && Pos_fin_x1 < 0.7
            q_ret1 = (1.505+1.46)/2;
        elseif Pos_fin_x1 == 0.7
            q_ret1 = 1.46;
        elseif Pos_fin_x1 > 0.7 && Pos_fin_x1 < 0.8
            q_ret1 = (1.44+1.46)/2;
        elseif Pos_fin_x1 == 0.8
            q_ret1 = 1.44;
        elseif Pos_fin_x1 > 0.8 && Pos_fin_x1 < 0.9
            q_ret1 = (1.44+1.433)/2;
        elseif Pos_fin_x1 == 0.9
            q_ret1 = 1.433;
        elseif Pos_fin_x1 > 0.9 && Pos_fin_x1 < 1.0
            q_ret1 = (1.555+1.433)/2;
        elseif Pos_fin_x1 == 1.0
            q_ret1 = 1.555;
        elseif Pos_fin_x1 > 1.0 && Pos_fin_x1 < 1.1
            q_ret1 = (1.555+1.716)/2;
        elseif Pos_fin_x1 == 1.1
            q_ret1 = 1.716;
        elseif Pos_fin_x1 > 1.1 && Pos_fin_x1 < 1.2 % not known after this point
            limit_value = -117; % This is in degrees, used for rotational joint
            q_ret1 = (1.716+1.716)/2;
        elseif Pos_fin_x1 == 1.2 
            limit_value = -120; % This is in degrees, used for rotational joint
            q_ret1 = 1.716;
        end
    elseif Pos_fin_x1 > 1.2 && Pos_fin_x1 <= 1.5
        limit_value = -130; % This is in degrees, used for rotational joint
        if Pos_fin_x1 > 1.2 && Pos_fin_x1 < 1.3
            q_ret1 = 1.59; % value too high
        elseif Pos_fin_x1 == 1.3
            q_ret1 = 1.67;
        elseif Pos_fin_x1 > 1.3 && Pos_fin_x1 < 1.4
            q_ret1 = 1.695;
        elseif Pos_fin_x1 == 1.4
            limit_value = -135;
            q_ret1 = 1.6785; % going to land short, limit is at around 1.38 meter
        elseif Pos_fin_x1 > 1.4 && Pos_fin_x1 < 1.5
            limit_value = -135;
            q_ret1 = 1.7; % going to land short
        elseif Pos_fin_x1 == 1.5
            limit_value = -140;
            q_ret1 = 1.685; % going to land short
        end

    end

    %% Solove unknonws
    syms W_cruise1 T_ret1 Vel_fin_y1
    eq1 = [((r1*W_cruise1*sin(q_ret1))) * (T_fin1-T_ret1) - (Pos_fin_x1 - (-0.095-(r1*cos(q_ret1)))) == 0,
        (((r1*W_cruise1*cos(q_ret1)) + Vel_fin_y1)/2) * (T_fin1-T_ret1) - (Pos_fin_y1 - (0.095+(r1*sin(q_ret1)))) == 0,
        2*((r1*a_ret)*sin(q_ret1))*(Pos_fin_x1 - (-0.095-(r1*cos(q_ret1)))) == 0, 
        2*((r1*a_ret)*cos(q_ret1)-9.81) * (Pos_fin_y1 - (0.095+(r1*sin(q_ret1)))) - ((Vel_fin_y1)^2 - ((r1*W_cruise1)*cos(q_ret1))^2) == 0];
%         (Pos_fin_x1 - (-0.095-(r1*cos(q_ret1)))) - (r1*W_cruise1*sin(q_ret1)*(T_fin1-T_ret1)) - (0.5*(r1*a_ret)*sin(q_ret1)*(T_fin1-T_ret1)^2) == 0,
%         (Pos_fin_y1 - (0.095+(r1*sin(q_ret1)))) - (r1*W_cruise1*cos(q_ret1)*(T_fin1-T_ret1)) - (0.5*((r1*a_ret)*cos(q_ret1)-9.81)*(T_fin1-T_ret1)^2) == 0];
    %% Solve 3 unknowns and save those values
    sol1 = solve(eq1, W_cruise1, T_ret1, Vel_fin_y1);

    W_cruise1 = sol1.W_cruise1;
    W_cruise2 = W_cruise1(1);

    T_ret1 = sol1.T_ret1;
    T_ret2 = T_ret1(1);

    Vel_fin_y1 = sol1.Vel_fin_y1;
    Vel_fin_y2 = Vel_fin_y1(1);
end

