function target = Goalie(Ball,Radius)


    %Received parameters
    Bx=Ball.Position.X;
    By=Ball.Position.Y;
    Vx=Ball.Simulation.Speed.X;
    Vy=Ball.Simulation.Speed.Y;
    q=SimulationData.friction;
    
    slope = Vy/Vx;
    
    %x=0-side coordinate under attack
    ua = slope*(Bx-3) + By;
    
    
    if ua < Environment.yLim/2 + Environment.goalLength && ua > Environment.yLim/2 - Environment.goalLength
        %if ball is aimed at the goal - catch it!
        target = [Radius, ua];
    elseif ua < Environment.yLim/2 - Environment.goalLength
        target = [Radius, Environment.yLim/2 - Environment.goalLength];
    elseif ua > Environment.yLim/2 + Environment.goalLength
        target = [Radius, Environment.yLim/2 + Environment.goalLength];
    else
        target = 0;
    end

end

