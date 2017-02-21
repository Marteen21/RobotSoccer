function [ v1, v2, v3 ] = OmniEQ( robot, w )
%The beta function of omnidirectional robots
%    Gets the robot's Vx, Vy, w and gives back the speed of the wheels
    
    Theta1 = 0.524; % 30° in rad
    Theta2 = 2.618; % 150° in rad
    Theta3 = 4.712; % 270° in rad
    R = robot.Radius;
    
    P = [-1*sin(Theta1) cos(Theta1) R;
         -1*sin(Theta2) cos(Theta2) R;
         -1*sin(Theta3) cos(Theta3) R;];
    
    V = [robot.Simulation.Speed.X;
         robot.Simulation.Speed.Y;
         w];
     
    Wspeeds = P * V;
    v1 = Wspeeds (1,:);
    v2 = Wspeeds (2,:);
    v3 = Wspeeds (3,:);


    
end
    