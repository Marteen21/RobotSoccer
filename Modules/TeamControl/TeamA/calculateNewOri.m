function newControlSignal = calculateNewOri(State, cellpotField, oldControl ,robotIndexes, Target, Radius)
%Calculates the new orientation of the robots if needed
    newControlSignal = oldControl;
    Field = cellpotField{1,1};
    
    for i=1:length(oldControl)
        Field = cellpotField{1,i};
        if isempty(oldControl{i}) || (oldControl{i}(1,1) == 0)            
            return
        elseif (oldControl{i}(1,2) == 0)
            %midnen egyes potField elemre meg kell csinálni
            for count = 1:length(oldControl)
                robX = robotIndexes{1,i}(1,1);
                robY = robotIndexes{1,i}(1,2);
                [minValueIndeces(count,1) minValueIndeces(count,2) minValueIndeces(count,3)] = minAround(robX, robY, Field,Target{i},Radius);
                
                %robot.pos-hoz kellene adni minValue-t valahogyan ez így
                %nem jó (kövi sor)
                diff = minValueIndeces(count,1:2)-[robX robY];
                diffPotAng = atan2(diff(1,2),diff(1,1));
                %Changing the orient of the robot
                if ~(isnan(diffPotAng)) && ~(isinf(diffPotAng))
                    oldControl{i}(1,2) = diffPotAng;
                end
            end
            
        end
        newControlSignal{i} = oldControl{i};
    end
end
function [minX, minY, value] = minAround(robX,robY,Field)
    minX = nan;
    minY = nan;
    value = nan;
    yLim = size(Field,1);
    xLim = size(Field,2);
    if isnan(robX)
        return
    end
%     Field itt matrix
    around = [];
    
        if (robX == 1)&&(robY == 1 )
            around = [Field{robY+1, robX} Field{robY, robX+1} Field{robY+1, robX+1} Field{robY, robX}];
            [row, col] = find(around == min(around));
            switch col
                case 1
                    minX = robX;
                    minY = robY+1;
                    value = Field{minY,minX};
                case 2
                    minX = robX+1;
                    minY = robY;
                    value = Field{minY,minX};
                case 3
                    minX = robX+1;
                    minY = robY+1;
                    value = Field{minY,minX};
                case 4
                    minX = robX;
                    minY = robY;
                    value = Field{minY,minX};
            end
        elseif (robX == 1)&&(robY == yLim)
            around = [Field{robY-1, robX} Field{robY, robX+1} Field{robY-1, robX+1} Field{robY, robX}];
            [row, col] = find(around == min(around));
            switch col
                case 1
                    minX = robX;
                    minY = robY-1;
                    value = Field{minY,minX};
                case 2
                    minX = robX+1;
                    minY = robY;
                    value = Field{minY,minX};
                case 3
                    minX = robX+1;
                    minY = robY-1;
                    value = Field{minY,minX};
                case 4
                    minX = robX;
                    minY = robY;
                    value = Field{minY,minX};
            end
        elseif (robX == 1)&&(robY < yLim)
            around = [Field{robY+1,robX}, Field{robY,robX+1}, Field{robY+1,robX+1},...
                    Field{robY-1,robX}, Field{robY-1,robX+1} Field{robY, robX}];
                [row, col] = find(around == min(around));
                switch col
                    case 1
                        minX = robX;   %robY+1;
                        minY = robY+1; %robX;
                        value = Field{minY,minX};
                    case 2
                        minX = robX+1;
                        minY = robY;
                        value = Field{minY,minX};
                    case 3
                        minX = robX+1;
                        minY = robY+1;
                        value = Field{minY,minX};
                    case 4
                        minX = robX;
                        minY = robY-1;
                        value = Field{minY,minX};
                    case 5
                        minX = robX+1;
                        minY = robY-1;
                        value = Field{minY,minX};
                    case 6
                        minX = robX;
                        minY = robY;
                        value = Field{minY,minX};
                end
        else
            if ((robY > 1) && (robY < yLim)) && robX ~= 1 && robX ~= xLim
                %ez után kellene breakpoint THX
                around = [Field{robY+1,robX}, Field{robY,robX+1}, Field{robY+1,robX+1},...
                    Field{robY-1,robX}, Field{robY-1,robX+1} Field{robY, robX} ...
                    Field{robY-1,robX-1} Field{robY,robX-1} Field{robY+1,robX-1}];
                [row, col] = find(around == min(around));
                switch col
                    case 1
                        minX = robX;   %robY+1;
                        minY = robY+1; %robX;
                        value = Field{minY,minX};
                    case 2
                        minX = robX+1;
                        minY = robY;
                        value = Field{minY,minX};
                    case 3
                        minX = robX+1;
                        minY = robY+1;
                        value = Field{minY,minX};
                    case 4
                        minX = robX;
                        minY = robY-1;
                        value = Field{minY,minX};
                    case 5
                        minX = robX+1;
                        minY = robY-1;
                        value = Field{minY,minX};
                    case 6
                        minX = robX;
                        minY = robY;
                        value = Field{minY,minX};
                    case 7
                        minX = robX-1;
                        minY = robY-1;
                        value = Field{minY,minX};
                    case 8
                        minX = robX-1;
                        minY = robY;
                        value = Field{minY,minX};
                    case 9
                        minX = robX-1;
                        minY = robY+1;
                        value = Field{minY,minX};
                end
            elseif (robY == 1)
                around = [Field{robY+1, robX} Field{robY, robX+1} Field{robY+1, robX+1} Field{robY, robX}];
                [row, col] = find(around == min(around));
                switch col
                    case 1
                        minX = robX;
                        minY = robY+1;
                        value = Field{minY,minX};
                    case 2
                        minX = robX+1;
                        minY = robY;
                        value = Field{minY,minX};
                    case 3
                        minX = robX+1;
                        minY = robY+1;
                        value = Field{minY,minX};
                    case 4
                        minX = robX;
                        minY = robY;
                        value = Field{minY,minX};
                end
            else
                around = [Field{robY+1, robX} Field{robY, robX+1} Field{robY-1, robX+1} Field{robY, robX}];
                [row, col] = find(around == min(around));
                switch col
                    case 1
                        minX = robX;
                        minY = robY+1;
                        value = Field{minY,minX};
                    case 2
                        minX = robX+1;
                        minY = robY;
                        value = Field{minY,minX};
                    case 3
                        minX = robX-1;
                        minY = robY+1;
                        value = Field{minY,minX};
                    case 4
                        minX = robX;
                        minY = robY;
                        value = Field{minY,minX};
                end 
            end
        end
        if (robX == size(Field,2))
            
            around = [Field{robY-1, robX} Field{robY-1, robX-1} Field{robY, robX-1} Field{robY+1, robX-1}...
                Field{robY+1, robX} Field{robY, robX}];
            [row, col] = find(around == min(around));
            switch col
                case 1
                    minX = robX;
                    minY = robY-1;
                    value = Field{minY,minX};
                case 2
                    minX = robX-1;
                    minY = robY-1;
                    value = Field{minY,minX};
                case 3
                    minX = robX-1;
                    minY = robY;
                    value = Field{minY,minX};
                case 4
                    minX = robX-1;
                    minY = robY+1;
                    value = Field{minY,minX};
                case 5
                    minX = robX;
                    minY = robY+1;
                    value = Field{minY,minX};
                case 6
                    minX = robX;
                    minY = robY;
                    value = Field{minY,minX};
            end
        end
            
    
end

