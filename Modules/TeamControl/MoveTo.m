function desiredSpeed = MoveTo(Orientation, SpeedAbs)
% Get the Control signals and the desired Target
%
    %if the angle between the robot orientation and the direction the
    %target is greater than 40° the robot first change it's orientation and
    %after that it moves to the target.
        
        targetSpeed = Vector2(Orientation.RowForm() * SpeedAbs);
%         targetSpeed = Vector2(targetSpeed.RowForm()/norm(targetSpeed.RowForm())* SpeedAbs);
%         diffSpeed = oldSpeed-targetSpeed;
%         diffSpeed = Vector2(diffSpeed.RowForm()/norm(diffSpeed.RowForm())* SimulationData.sampleTime* 10);
%         targetSpeed = oldSpeed + diffSpeed;
        if (norm(targetSpeed.RowForm()) >= SpeedAbs)
            desiredSpeed = Vector2(targetSpeed.RowForm()/ norm(targetSpeed.RowForm())*SpeedAbs);
        else
            desiredSpeed = Vector2(targetSpeed.RowForm());
        end

%         if (cross([oldSpeed.X,oldSpeed.Y,0],[robot.Orientation.X,robot.Orientation.Y,0])==0)
%             if norm(oldSpeed.RowForm()) >= SpeedAbs
%                 desiredSpeed = Vector2(oldSpeed.RowForm()/ norm(oldSpeed.RowForm())*SpeedAbs);
%             end
%         else 
%             %robot.Orientation = Vector2(oldSpeed.RowForm()/ norm(oldSpeed.RowForm()));
%             robot.Orientation = Vector2(desiredSpeed.RowForm()/ norm(desiredSpeed.RowForm()));
%         end    

end

