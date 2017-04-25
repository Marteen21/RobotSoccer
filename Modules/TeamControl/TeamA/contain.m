function bool = contain(robot, Field )
%Gives back true if the robot is in the given field
    
%     roundRobotPos = Vector2(round(robot.Position.RowForm(),2));
    xStep = Field(1);
    yStep = Field(2);
    bool = false;
    if (robot.Position.X > xStep{1,1}{1,1}(1,1) && robot.Position.X < xStep{1,1}{1,1}(1,end)...
            && robot.Position.Y > yStep{1,1}{1,1}(1,1) && robot.Position.Y < yStep{1,1}{1,1}(1,end))
        bool = true;
    end
    
%     for i=1:size(Field(1),2) 
%         for j=1:size(Field(2),2) 
%             if (roundRobotPos.X == round(Field{1,1}{1,1}(1,j),2)) && ...
%                 (roundRobotPos.Y == round(Field{1,2}{1,2}(1,j),2))
%                 bool = true;
%             end
%         end
%     end

end

