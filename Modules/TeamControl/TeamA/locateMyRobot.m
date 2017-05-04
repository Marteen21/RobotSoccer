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
                if (posX >= xStep(1,i) && posX < xStep(1,i+1) && ...
                        posY >= yStep(1,j) && posY < yStep(1,j+1))
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