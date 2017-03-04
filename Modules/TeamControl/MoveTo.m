function desiredSpeed = MoveTo(agentIndex, Orientation, SpeedAbs)
% Get the Control signals and the desired Target
%
    %if the angle between the robot orientation and the direction the
    %target is greater than 40° the robot first change it's orientation and
    %after that it moves to the target.
        
        targetSpeed = Orientation;
        targetSpeed = Vector2(targetSpeed.RowForm()/norm(targetSpeed.RowForm())* SpeedAbs);
        desiredSpeedTemp = targetSpeed;
%         diffSpeed = robot.Simulation.Speed-targetSpeed;
%         diffSpeed = Vector2(diffSpeed.RowForm()/norm(diffSpeed.RowForm())* SimulationData.sampleTime* 10);
%         desiredSpeedTemp = robot.Simulation.Speed + diffSpeed;
        if (norm(desiredSpeedTemp.RowForm()) >= SpeedAbs)
            desiredSpeed = Vector2(desiredSpeedTemp.RowForm()/ norm(desiredSpeedTemp.RowForm())*SpeedAbs);
        else
            desiredSpeed = Vector2(desiredSpeedTemp.RowForm());
        end

%         if (cross([robot.Simulation.Speed.X,robot.Simulation.Speed.Y,0],[robot.Orientation.X,robot.Orientation.Y,0])==0)
%             if norm(robot.Simulation.Speed.RowForm()) >= SpeedAbs
%                 desiredSpeed = Vector2(robot.Simulation.Speed.RowForm()/ norm(robot.Simulation.Speed.RowForm())*SpeedAbs);
%             end
%         else 
%             %robot.Orientation = Vector2(robot.Simulation.Speed.RowForm()/ norm(robot.Simulation.Speed.RowForm()));
%             robot.Orientation = Vector2(desiredSpeed.RowForm()/ norm(desiredSpeed.RowForm()));
%         end    

end

