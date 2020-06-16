    function [v] = third_state_vol(bore,stroke,con_rod,cr,v_1,v_3,starting_crank_angle,ending_crank_angle)
    %engine kinematics
    %crank angle
    cr = v_1/v_3;
    theta = linspace(starting_crank_angle,ending_crank_angle,180); 
    crank_length = stroke/2;
    R = con_rod/crank_length;
    term1 = 0.5*(cr-1);
    term2 = R +1 - cosd(theta);
    term3 = (R^2 - sind(theta).^2).^0.5;



    %using geometric relation between combustion chamber volume and crank angle
    v = (1 + term1*(term2 - term3))*v_3
    plot(v)
    end

