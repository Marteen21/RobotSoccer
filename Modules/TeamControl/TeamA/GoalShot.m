classdef GoalShot
    
    properties
    end
    
    methods (Static)
        function DesiredPlace = shotToGoal( Agent, Ball, bGoalKeeper )
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

                Rx = Agent.Position.X;
                Ry = Agent.Position.Y;
                Bx=Ball.Position.X;
                By=Ball.Position.Y;
                Vx = Ball.Simulation.Speed.X;
                Vy = Ball.Simulation.Speed.Y;
                q=SimulationData.friction;

                point = Vector2(goalX, goalY);
                m = (By-point.Y)/(Bx-point.X);

                %Collecting the point on the Balls line
                    %y is where the line crosses the enemy sideline
                y = (Vy*(Bx-Environment.xLim)-Vx*By)/(-1*Vx);
                xPoints = linspace(Bx,Environment.xLim,1000);
                Bx_vect = ones(size(xPoints))*Bx;
                By_vect = ones(size(xPoints))*By;
                if Vx==0
                    den = 1;
                else
                    den = -1*(1/Vx);
                end
                yPoints = (Vy*(Bx_vect-xPoints)-Vx*By_vect)*(den);
                linePoints = [xPoints;yPoints];
                %aim is the middle of the enemy goal
                aim = [ones(size(xPoints))*Environment.xLim; ones(size(yPoints))*y];
                %the new speed's orientation is given
                newSpeedOri = aim-linePoints;

            %   Example: If X = [2 8 4; 7 3 9] then 
            %                 min(X,[],1) is [2 3 4],
            %                 min(X,[],2) is [2; 3] and 
            %                 min(X,5)    is [2 5 4; 5 3 5].
                %Rx_vect = ones(size(xPoints))*Rx;
                %Ry_vect = ones(size(xPoints))*Ry;

                %Now we know every new orientation the ball can have to move to the
                %enemy's goal. We just have to choose the right one.
                %First find the nearest point for the robot it can reach alongside the
                %Ball's line before the ball
                [Index, reach] = GoalShot.reachAble(Agent, Ball, linePoints, size(xPoints));
                if reach.X==-1
                    DesiredPlace = reach;
                    return
                end

                BvelNew = Vector2(newSpeedOri(1,Index),newSpeedOri(2,Index));

                alpha = abs(atan2(Ball.Simulation.Speed.Y,Ball.Simulation.Speed.X));
                beta = abs(atan2(BvelNew.Y,BvelNew.X));
                theta = (alpha+beta)/2;
                BallSpeed = Ball.Simulation.Speed.RowForm();
                wall = ((BvelNew.RowForm()/(norm(BallSpeed)))+BallSpeed)/(2*cos(theta));
                wall = Vector2(wall);
                Position = wall.D2NVector+reach;
                Position = Position.RowForm()/norm(Position.RowForm());
                Position = Vector2(Position*Agent.Radius)+reach;
                DesiredPlace = Position;

                %Now have to find the correct place for the robot. (Correct means that
                %it can change the ball's speed in the correct way). The backward of
                %total reflection




                %DesiredPlace = Vector2(real(DesiredPlaceX),real(DesiredPlaceY));
            end
        end
        function [Index, reach] = reachAble(Agent,Ball,linePoints, size)
            %Chooses the closest (reachable) point where we can change the 
            %balls speed toward the enemy's goal
            %Gives back the the X-Y coordinate of the most reachable point
            %
            Rspeed = abs(Agent.Simulation.Speed);
            if (Agent.Simulation.Speed.X == 0)
                Index = 0;
                reach = Vector2(-1,-1);
                return;
            end
            RposX = ones(size)*Agent.Position.X;
            RposY = ones(size)*Agent.Position.Y;
            Rdistance = ((linePoints(1,:)-RposX).^2+(linePoints(2,:)-RposY).^2).^(1/2);
            %Rditsance - radius

            RadiusVect = (ones(size)*Agent.Radius);
            Rdistance = Rdistance - RadiusVect;
            Rtime = Rdistance/Rspeed;

            Bspeed = abs(Ball.Simulation.Speed);
%             if (abs(Bspeed) == 0)
%                 Index = 0;
%                 reach = Vector2(-1,-1);
%                 return;
%             end
            BposX = ones(size)*Ball.Position.X;
            BposY = ones(size)*Ball.Position.Y;
            Bdistance = ((linePoints(1,:)-BposX).^2+(linePoints(2,:)-BposY).^2).^(1/2);
            Bdistance = Bdistance - (ones(size)*Ball.Radius);
            Btime = Bdistance/Bspeed;

            Time = Rtime-Btime;
            [minTime minIndex] = min(Time(Time>0));
            if (isempty(minTime)) || (isempty(minIndex))
                reach = Vector2(-1,-1);
                Index = 0;
                return
            elseif (isinf(minTime))
                reach = Vector2(-1,-1);
                Index = 0;
                return
            end

            Index = minIndex(1);
            reach = Vector2(linePoints(1,Index),linePoints(2,Index));
        end
    end
end

