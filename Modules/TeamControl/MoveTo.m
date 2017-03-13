function desiredSpeed = MoveTo(Orientation, SpeedAbs)
% Get the Control signals and the desired Target
%
    %if the angle between the robot orientation and the direction the
    %target is greater than 40° the robot first change it's orientation and
    %after that it moves to the target.
        
        targetSpeed = Vector2(Orientation.RowForm() * SpeedAbs);
        
        if (norm(targetSpeed.RowForm()) >= SpeedAbs)
            desiredSpeed = Vector2((targetSpeed.RowForm()/norm(targetSpeed.RowForm()))*SpeedAbs);
        else
            desiredSpeed = Vector2(targetSpeed.RowForm());
        end

end

