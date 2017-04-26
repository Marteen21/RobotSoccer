function [potField, robotIndexes] = buildUpPotField(State, teamMemberOwn, Target, Team)
%Planning the trajectory with potential field, correcting the orientation
%Ha a robot es a target koze esik akadaly
    potField{1}{1,1} = nan;
    robotIndexes{1,1} = [0 0;];
    robotIndexes{1,2} = [0 0;];
    potObst = [];
    sigma = sqrt(10);  %Sulytenyezo a potencial ter szamitasanal,
                  %pontos beállítása kérdéses;
    robotValue = 8;
    targetValue = -1;
    %Selecting the given team members
    Obstacle = [teamMemberOwn.empty];
    
    
    
    for i = 1:length(teamMemberOwn)
          Orient = atan2(Target{i}.Y-teamMemberOwn(i).Position.Y,Target{i}.X-teamMemberOwn(i).Position.X);
          if (Orient < pi/2 && Orient > -pi/2)
              xStep{1,i} = (teamMemberOwn(i).Position.X-teamMemberOwn(i).Radius):2*(teamMemberOwn(i).Radius):(Target{i}.X+teamMemberOwn(i).Radius);
              if (xStep{1,i}(1,end) < Target{i}.X+teamMemberOwn(i).Radius)
                  xStep{1,i}(1,end+1) = xStep{1,i}(1,end)+2*(teamMemberOwn(i).Radius);
              end
              yStep{1,i} = 0:2*(teamMemberOwn(i).Radius):Environment.yLim;
          else
              xStep{1,i} = (teamMemberOwn(i).Position.X+teamMemberOwn(i).Radius):-2*(teamMemberOwn(i).Radius):(Target{i}.X-teamMemberOwn(i).Radius);
              if (xStep{1,i}(1,end) < Target{i}.X-teamMemberOwn(i).Radius)
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
%                     if ~(State.robots(l).Position.RowForm() == teamMemberOwn(i).Position.RowForm())
                        if (contain(State.robots(l),Field))
                            Obs = Obs+1;
                            Obstacle(Obs) = State.robots(l);
                        end
%                     end
                end
                
                if ~isempty(Obstacle)
                    for count = 1:length(Obstacle)
                        potObst(1,count) = (1/(abs(Vector2([xStep{1,i}(1,j) yStep{1,i}(1,k)]-Obstacle(count).Position.RowForm())) / ((sigma)^2)));
                    end
                    potObst = 2*mean(potObst);
                else
                    potObst{1}{1,1} = nan;
                    robotIndexes{1,1} = [0 0;];
                    robotIndexes{1,2} = [0 0;];
                    return
                end
                potField{i}{k,j} = abs(Vector2([xStep{1,i}(1,j) yStep{1,i}(1,k)]-Target{i}.RowForm())) / (sigma^2) + potObst;
            end
        end
        [robX, robY] = locateMyRobot(Field,teamMemberOwn(i));
        robotIndexes{1,i} = [robX robY;];
%         [tarX, tarY] = locateMyRobot(Field,Target{i},1);
% %         if ~(isnan(robX))
% %             potField{i}{robY,robX} = robotValue;
% %         end
%         if ~isnan(tarX)
%             potField{i}{tarY,tarX} = targetValue;
%         end
    end
    
    
    

end

