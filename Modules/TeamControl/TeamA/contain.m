function bool = contain(robot, Field )
%Gives back true if the robot is in the given field
    
    xStep = Field(1);
    yStep = Field(2);
    bool = false;
    if (robot.Position.X > xStep{1,1}{1,1}(1,1) && robot.Position.X < xStep{1,1}{1,1}(1,end)...
            && robot.Position.Y > yStep{1,1}{1,1}(1,1) && robot.Position.Y < yStep{1,1}{1,1}(1,end))
        bool = true;
    end
end

