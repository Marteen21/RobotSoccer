function DesiredPlace = GoalShot( Agent, Ball, bGoalKeeper )
% bGoalKeeper is an enemy agent robot who is in the way of shooting
% If there is no "GoalKeeper" (another robot in the way) shoot the ball in
%      the middle of the goal
% TODO making the bGoalKeeper calculation function
    

if nargin == 3 
    bGKx = bGoalKeeper.Position.X;
    bGKy = bGoalKeeper.Position.Y;
    bR = bGoalKeeper.Radius;

    Bx=Ball.Position.X;
    By=Ball.Position.Y;
    Vx = Ball.Simulation.Speed.X;
    Vy = Ball.Simulation.Speed.Y;
    q=SimulationData.friction;
    
    %calculating the m
    if (By < bGKy)
        %trying shoot under the goalkeeper
        point = Vector2(Environment.xLim, bGKy-bR)-...
            Vector2(Environment.xLim, Environment.goalPos.Y-Environment.goalLength/2);
        m = (By-point.Y)/(Bx-point.X);
    else
        %trying to shoot above the goalkeeper
        point = Vector2(Environment.xLim, bGKy+bR)-...
            Vector2(Environment.xLim, Environment.goalPos.Y+Environment.goalLength/2);
        m = (By-point.Y)/(Bx-point.X);
    end
    %m = Vx/Vy;
    
    r = Ball.Position -Agent.Position;
    %calculating the two point which is in the given r distance in the
    %given m sloped line
    %quadratic function solution eq
    a = 1+m^2;
    b = -2*Bx-2*By*m;
    c = Bx^2 + By^2 - abs(r)^2;
    DesiredPlaceX = min(-b+sqrt(b^2-4*a*c)/2*a, -b-sqrt(b^2-4*a*c)/2*a);
    DesiredPlaceY = m * DesiredPlaceX;
    DesiredPlace = Vector2(real(DesiredPlaceX),real(DesiredPlaceY));
elseif nargin == 2
    goalX = Environment.xLim;
    goalY = Environment.yLim / 2;
    

    Bx=Ball.Position.X;
    By=Ball.Position.Y;
    Vx = Ball.Simulation.Speed.X;
    Vy = Ball.Simulation.Speed.Y;
    q=SimulationData.friction;
    
    point = Vector2(goalX, goalY);
    m = (By-point.Y)/(Bx-point.X);
    
    r = Ball.Position -Agent.Position;
    %calculating the two point which is in the given r distance in the
    %given m sloped line
    %quadratic function solution eq
    a = 1+m^2;
    b = -2*Bx-2*By*m;
    c = Bx^2 + By^2 - abs(r)^2;
    DesiredPlaceX = min(-b+sqrt(b^2-4*a*c)/2*a, -b-sqrt(b^2-4*a*c)/2*a);
    DesiredPlaceY = m * DesiredPlaceX;
    DesiredPlace = Vector2(real(DesiredPlaceX),real(DesiredPlaceY));
end
end

