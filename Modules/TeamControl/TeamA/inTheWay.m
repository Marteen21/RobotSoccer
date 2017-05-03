function bool = inTheWay(robot,ball)
    if robot.Position.X>ball.Position.X
        Bx=Ball.Position.X;
        By=Ball.Position.Y;
        Vx=Ball.Simulation.Speed.X;
        Vy=Ball.Simulation.Speed.Y;

        slope = Vy/Vx;

        %x=xLim-side coordinate under attack
        ua = slope*(Bx-3) + By;
        if ua > robot.Position.Y-robot.Radius && ua < robot.Position.Y+robot.Radius
            bool = true;
        end
    else
        bool = false;
    end
end