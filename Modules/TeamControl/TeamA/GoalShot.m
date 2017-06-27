function [DesiredPlaceX, DesiredPlaceY] = GoalShot( Agent, Ball )
%GoalShot Summary of this function goes here
%   Detailed explanation goes here
    m = Ball.Simulation.Speed.X/Ball.Simulation.Speed.Y;
    r = Ball.Position -Agent.Position;
    %quadratic function solution eq
    a = 1+m^2;
    b = -2*Ball.Position.X-2*Ball.Position.Y*m;
    c = Ball.Position.X^2 + Ball.Position.Y^2 - abs(r)^2;
    DesiredPlaceX = min(-b+sqrt(b^2-4*a*c)/2*a, -b-sqrt(b^2-4*a*c)/2*a);
    DesiredPlaceY = m * DesiredPlaceX;
end

