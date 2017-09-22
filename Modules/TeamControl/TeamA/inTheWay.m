function bool = inTheWay(robot,ball,allRobot)
if nargin == 2
    bool = false;
    if robot.Position.X<ball.Position.X
        Bx=ball.Position.X;
        By=ball.Position.Y;
        Vx=ball.Simulation.Speed.X;
        Vy=ball.Simulation.Speed.Y;

        slope = Vy/Vx;

        %x=xLim-side coordinate under attack
        if (Vx>0)
            bool = true;
%             ua = slope*(Bx-3) + By;
%             if ua > (robot.Position.Y-robot.Radius) && ua < (robot.Position.Y+robot.Radius)
%                 bool = true;
%             end
        end
    else
        bool = false;
    end
else
    bool = false;
    if ball.Position.X>robot.Position.X && robot.Position.X > Environment.xLim/2 && ball.Position.X > Environment.xLim/2 && Distance(robot.Position,ball.Position)<3*robot.Radius
        for j = 1:length(allRobot)
            if allRobot(j)~=robot
                if allRobot(j).Position.X>robot.Position.X && allRobot(j).Position.X<ball.Position.X
                    if ball.Position.Y > robot.Position.Y
                        if allRobot(j).Position.Y>robot.Position.Y && allRobot(j).Position.Y<ball.Position.Y
                            bool = true;
                        end
                    else
                        if allRobot(j).Position.Y<robot.Position.Y && allRobot(j).Position.Y>ball.Position.Y
                            bool = true;
                        end
                    end
                end
            end
        end
    end
end
end