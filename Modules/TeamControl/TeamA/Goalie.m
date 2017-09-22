function target = Goalie(Ball,Radius)


    %Received parameters
    Bx=Ball.Position.X;
    By=Ball.Position.Y;
    
%     Vx=Vector2(Ball.Simulation.Speed.RowForm()/norm(Ball.Simulation.Speed.RowForm())).X;
%     Vy=Vector2(Ball.Simulation.Speed.RowForm()/norm(Ball.Simulation.Speed.RowForm())).Y;
    Vx = Ball.Simulation.Speed.X;
    Vy = Ball.Simulation.Speed.Y;
    %line eq solution to the exact point
    solution = Vy*Bx-Vx*By; %=Vy*X-Vx*Y -- X=0 -- solution/(-Vx) = Y
    
    
    q=SimulationData.friction;
    
    %slope = Vx/Vy;
    
    %x=0-side coordinate under attack
    %ua = slope*(Bx) + By;
    
    ua = solution/(-1*Vx);
    
    if (sign(Vx)<0)
        if (ua < (Environment.goalPos.Y + Environment.goalLength)) && (ua > (Environment.goalPos.Y - Environment.goalLength))
            %if ball is aimed at the goal - catch it!
            target = [Radius, ua];
        elseif ua <= Environment.goalPos.Y - Environment.goalLength
            target = [Radius, Environment.goalPos.Y - Environment.goalLength];
        elseif ua >= Environment.goalPos.Y + Environment.goalLength
            target = [Radius, Environment.goalPos.Y + Environment.goalLength];
        else
            target = 0;
        end
    else
        target = 0;
    end

end

