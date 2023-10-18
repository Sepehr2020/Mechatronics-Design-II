function [w_cruise, q_ret, t_ret] = calculation(des_position)
 % des_position = desired x position
 % w_cruise = desired speed to release the ball at
 % Assumptions = no air friction, little to no friction between the ball
 % and the cup (causes little rotational acceleration, magnus force?)
 g = -9.81;
 
 %% First thing is calculate the constant release position of the ball (assumed to be at 45 degrees relative to ground)
 % From measurements of the system, relative to the origin,
 % x direction from origin to cup release
 beam_length = 0.140 % 140mm Obtained from solidworks file from center rotation to ball
 x_origin_to_rod = -0.095 % 95mm Obtained from solidworks file
 x_release = x_origin_to_rod + -1*beam_length*cos(pi/4) % point of release for x coordinate relative to origin

 y_origin_to_rod = 0.095 % Happens to be square
 y_release = y_origin_to_rod + beam_length*sin(pi/4) % point of release for y coordinate relative to origin
%  
%  disp(x_origin_to_rod)
%  disp(-1*beam_length*cos(pi/sqrt(2)))

 radius_ball = 0.0315;
 
 syms velocity time
 eqn1 = radius_ball == y_release + velocity*sin(pi/4)*time + (1/2)*g*(time^2);
 eqn2 = des_position == (velocity*cos(pi/4)*time)+x_release;
 
 sol = solve([eqn1, eqn2],[velocity, time]);
 velocity_sol = sol.velocity;
 time_sol = sol.time;

 if velocity_sol(1)>0 && time_sol(1)>0
    real_velocity = velocity_sol(1);
    real_time = time_sol(1);
 elseif velocity_sol(2)>0 && time_sol(2)>0
    real_velocity = velocity_sol(2);
    real_time = time_sol(2);
 else
     disp('looks like the solver has solved that either velocity or time is negative, which doesnt make sense')
 end
 w_cruise = real_velocity/beam_length % obtained from the equation v=rw
 q_ret = (pi/2)
 t_ret = 0.5
 

 

 % t_ret = time which arm begins retracting
end
