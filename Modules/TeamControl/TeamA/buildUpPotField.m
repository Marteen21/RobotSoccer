function [potField, robotIndexes] = buildUpPotField(State, teamMemberOwn, Target, Team)
%Planning the trajectory with potential field, correcting the orientation
%Ha a robot es a target koze esik akadaly
    potField{1}(1,1) = nan;
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
              
        Field = {xStep yStep};
        Obs = 0;
        Place{i}(1,:) = [0 0];
        Col = 0;
        for u = 1:length(xStep{1,i})
%             RowCur = size(Place{i},1);
            Place{i}(1:length(yStep{1,i}),u+Col) = xStep{1,i}(1,u);
            Col = Col + 1;
%             RowCur2 = size(Place{i},1);
            Place{i}(1:length(yStep{1,i}),u+Col) = yStep{1,i}(1,:);
        end
        Place{i}(1,:) = [];
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
                CurrentObst = Obstacle(count).Position.RowForm();
                PlaceOne = ones(size(Place{i},1),size(Place{i},2));
                PlaceOne(:,1:2:end) = CurrentObst(1)*PlaceOne(:,1:2:end);
                PlaceOne(:,2:2:end) = CurrentObst(2)*PlaceOne(:,2:2:end);
                potObst(1,count) = (1/(abs(Vector2(Place{i}-PlaceOne))) / ((sigma)^2));
            end
            potObst = 2*mean(potObst);
        else
            potObst{1}(1,1) = nan;
            robotIndexes{1,1} = [0 0;];
            robotIndexes{1,2} = [0 0;];
            return
        end
        TargetPot = Target{i}.RowForm();
        PlaceOne = ones(size(Place{i},1),size(Place{i},2));
        PlaceOne(:,1:2:end) = TargetPot(1)*PlaceOne(:,1:2:end);
        PlaceOne(:,2:2:end) = TargetPot(2)*PlaceOne(:,2:2:end);
        potFieldXY = (Place{i}-PlaceOne).^2 / (sigma^2); % + potObst;
        OszlopInt = round(size(potFieldXY,1)/2);
        potField{i} = zeros(size(potFieldXY,1),OszlopInt);
        potField{i}(:,1:size(potFieldXY,2)/2) = sqrt(potFieldXY(:,1:2:end)+potFieldXY(:,2:2:end));
    end
    [robX, robY] = locateMyRobot(Field,teamMemberOwn(i));
    robotIndexes{1,i} = [robX robY;];
end
        
                    
                    
                    
                    
                    
        
        
%         for j = 1:length(xStep{1,i})
%             for k = 1:length(yStep{1,i})
%                 for l=1:length(State.robots)
% %                     if ~(State.robots(l).Position.RowForm() == teamMemberOwn(i).Position.RowForm())
%                         if (contain(State.robots(l),Field))
%                             Obs = Obs+1;
%                             Obstacle(Obs) = State.robots(l);
%                         end
% %                     end
%                 end
%                 
%                 if ~isempty(Obstacle)
%                     for count = 1:length(Obstacle)
%                         potObst(1,count) = (1/(abs(Vector2([xStep{1,i}(1,j) yStep{1,i}(1,k)]-Obstacle(count).Position.RowForm())) / ((sigma)^2)));
%                     end
%                     potObst = 2*mean(potObst);
%                 else
%                     potObst{1}{1,1} = nan;
%                     robotIndexes{1,1} = [0 0;];
%                     robotIndexes{1,2} = [0 0;];
%                     return
%                 end
%                 potField{i}{k,j} = abs(Vector2([xStep{1,i}(1,j) yStep{1,i}(1,k)]-Target{i}.RowForm())) / (sigma^2) + potObst;
%             end
%         end
%         [robX, robY] = locateMyRobot(Field,teamMemberOwn(i));
%         robotIndexes{1,i} = [robX robY;];
%         [tarX, tarY] = locateMyRobot(Field,Target{i},1);
% %         if ~(isnan(robX))
% %             potField{i}{robY,robX} = robotValue;
% %         end
%         if ~isnan(tarX)
%             potField{i}{tarY,tarX} = targetValue;
%         end
%     end
%     
%     
%     
% 
% end

