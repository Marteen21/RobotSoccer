function DesiredPlace = Dribbling( Agent, ball )
%Gives back the target where should the robot go
    goalX = Environment.xLim;
    goalY = Agent.Position.Y;
    
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
    y = (Vy*(Bx-goalX)-Vx*By)/(-1*Vx);
    xPoints = linspace(Bx,goalX,1000);
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
    aim = [ones(size(xPoints))*goalX; ones(size(yPoints))*y];
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

