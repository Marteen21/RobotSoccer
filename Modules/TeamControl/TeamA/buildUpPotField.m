function potField = buildUpPotField(State, Target, Team)
%Planning the trajectory with potential field, correcting the orientation
%Ha a robot es a target koze esik akadaly
    
    sigma = sqrt(10);  %Sulytenyezo a potencial ter szamitasanal,
                  %pontos beállítása kérdéses;
    robotValue = 40;
    targetValue = -1;
    %Selecting the given team members
    Own = 1;
    Opp = 1;
    for i=1:length(State.robots)
        if (strcmp(State.robots(i).Owner,Team))
            teamMemberOwn(Own) = State.robots(i);
            Own = Own + 1;
        else
            teamOpponent(Opp) = State.robots(i);
            Opp = Opp + 1; 
        end
    end
    
    
    
    for i = 1:length(teamMemberOwn)
          Orient = atan2(Target{i}.Y-teamMemberOwn(i).Position.Y,Target{i}.X-teamMemberOwn(i).Position.X);
          if (Orient < pi/2 && Orient > -pi/2)
              xStep{1,i} = (teamMemberOwn(i).Position.X-teamMemberOwn(i).Radius):2*(teamMemberOwn(i).Radius):(Target{i}.X+teamMemberOwn(i).Radius);
              if (xStep{1,i}(1,end) < Target{i}.X)
                  xStep{1,i}(1,end+1) = xStep{1,i}(1,end)+2*(teamMemberOwn(i).Radius);
              end
              yStep{1,i} = 0:2*(teamMemberOwn(i).Radius):Environment.yLim;
          else
              xStep{1,i} = (teamMemberOwn(i).Position.X+teamMemberOwn(i).Radius):2*(teamMemberOwn(i).Radius):(Target{i}.X-teamMemberOwn(i).Radius);
              if (xStep{1,i}(1,end) < Target{i}.X)
                  xStep{1,i}(1,end+1) = xStep{1,i}(1,end)+2*(teamMemberOwn(i).Radius);
              end
              yStep{1,i} = 0:2*(teamMemberOwn(i).Radius):Environment.yLim;
          end
%           if (Orient>0 && Orient > pi/2)
%               xStep{1,i} = (teamMemberOwn(i).Position.X-teamMemberOwn(i).Radius):2*(teamMemberOwn(i).Radius):(Target{i}.X+teamMemberOwn(i).Radius);
%               yStep{1,i} = (teamMemberOwn(i).Position.Y-teamMemberOwn(i).Radius):2*(teamMemberOwn(i).Radius):(Target{i}.Y+teamMemberOwn(i).Radius);
%           elseif (Orient > 0 && Orient > pi/2)
%               xStep{1,i} = (teamMemberOwn(i).Position.X-teamMemberOwn(i).Radius):2*(teamMemberOwn(i).Radius):(Target{i}.X+teamMemberOwn(i).Radius);
%               yStep{1,i} = (teamMemberOwn(i).Position.Y+teamMemberOwn(i).Radius):2*(teamMemberOwn(i).Radius):(Target{i}.Y-teamMemberOwn(i).Radius);
%           elseif (Orient > 0 && Orient < pi/2)
%               xStep{1,i} = (teamMemberOwn(i).Position.X+teamMemberOwn(i).Radius):2*(teamMemberOwn(i).Radius):(Target{i}.X-teamMemberOwn(i).Radius);
%               yStep{1,i} = (teamMemberOwn(i).Position.Y-teamMemberOwn(i).Radius):2*(teamMemberOwn(i).Radius):(Target{i}.Y+teamMemberOwn(i).Radius);
%           elseif (Orient < 0 && Orient < pi/2)
%               xStep{1,i} = (teamMemberOwn(i).Position.X+teamMemberOwn(i).Radius):2*(teamMemberOwn(i).Radius):(Target{i}.X-teamMemberOwn(i).Radius);
%               yStep{1,i} = (teamMemberOwn(i).Position.Y+teamMemberOwn(i).Radius):2*(teamMemberOwn(i).Radius):(Target{i}.Y-teamMemberOwn(i).Radius);
%           else
%               xStep{1,i} = [];
%               yStep{1,i} = [];
%           end
              
        Field = {xStep yStep};
        Obs = 0;
        for j = 1:length(xStep{1,i})
            for k = 1:length(yStep{1,i})
                for l=1:length(State.robots)
                    if ~(State.robots(l).Position.RowForm() == teamMemberOwn(i).Position.RowForm())
                        if (contain(State.robots(l),Field))
                            Obs = Obs+1;
                            Obstacle(Obs) = State.robots(l);
                        end
                    end
                end
                
                if ~isempty(Obstacle)
                    for count = 1:length(Obstacle)
                        potObst(i) = (sqrt(abs(Vector2([xStep{1,i}(1,j) yStep{1,i}(1,k)]-Obstacle(count).Position.RowForm())) / ((sigma/2)^2)))^2;
                    end
                    potObst = sum(potObst);
                else
                    potObst = 0;
                end
                potField{i}{k,j} = abs(Vector2([xStep{1,i}(1,j) yStep{1,i}(1,k)]-Target{i}.RowForm())) / (sigma^2) + potObst;
            end
        end
        for cObst = 1:length(Obstacle)
            [obstX, obstY] = locateMyRobot(Field,Obstacle(cObst));
            if ~(isnan(obstX))
                potField{i}{obstY,obstX} = robotValue;
            end
        end
        [robX, robY] = locateMyRobot(Field,teamMemberOwn(i));
        [tarX, tarY] = locateMyRobot(Field,Target{i},1);
        if ~(isnan(robX))
            potField{i}{robY,robX} = robotValue;
        end
        if ~isnan(tarX)
            potField{i}{tarY,tarX} = targetValue;
        end
    end
    
    
    

end
function [robX, robY] = locateMyRobot(Field,Robot,Target)
    if nargin < 3
        posX = Robot.Position.X;
        posY = Robot.Position.Y;
        xStepCell = Field(1);
        xStep = xStepCell{1,1}{1,1};
        yStepCell = Field(2);
        yStep = yStepCell{1,1}{1,1};

        robX = nan;
        robY = nan;

        for i =1 : size(xStep,2)-1
            for j =1 : size(yStep,2)-1
                if (posX > xStep(1,i) && posX < xStep(1,i+1) && ...
                        posY > yStep(1,j) && posY < yStep(1,j+1))
                    robX = i;
                    robY = j;
                end
            end
        end
    else
        posX = Robot.X;
        posY = Robot.Y;
        xStepCell = Field(1);
        xStep = xStepCell{1,1}{1,1};
        yStepCell = Field(2);
        yStep = yStepCell{1,1}{1,1};

        robX = nan;
        robY = nan;

        for i =1 : size(xStep,2)-1
            for j =1 : size(yStep,2)-1
                if (posX > xStep(1,i) && posX < xStep(1,i+1) && ...
                        posY > yStep(1,j) && posY < yStep(1,j+1))
                    robX = i;
                    robY = j;
                end
            end
        end
    end
end
