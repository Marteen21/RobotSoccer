function desiredSpeed = MoveTo( robot, Target )
%MOVETO Summary of this function goes here
%   Moving to the desired target
    TargetOri = Target-robot.Position;
    %if the angle between the robot orientation and the direction the
    %target is greater than 40° the robot first change it's orientation and
    %after that it moves to the target.
    if ((CIncidentAngle(TargetOri,robot.Orientation)*180)/pi)<40
        targetSpeed = robot.Position-(Target);
        targetSpeed = Vector2(targetSpeed.RowForm()/norm(targetSpeed.RowForm())* 15);
        diffSpeed = robot.Simulation.Speed-targetSpeed;
        diffSpeed = Vector2(diffSpeed.RowForm()/norm(diffSpeed.RowForm())* SimulationData.sampleTime* 10);
        desiredSpeedTemp = robot.Simulation.Speed + diffSpeed;
        if (norm(desiredSpeedTemp.RowForm()) >= 15)
            desiredSpeed = Vector2(desiredSpeedTemp.RowForm()/ norm(desiredSpeedTemp.RowForm())*15);
        else
            desiredSpeed = Vector2(desiredSpeedTemp.RowForm());
        end

        if (cross([robot.Simulation.Speed.X,robot.Simulation.Speed.Y,0],[robot.Orientation.X,robot.Orientation.Y,0])==0)
            if norm(robot.Simulation.Speed.RowForm()) >= 15
                robot.Simulation.Speed = Vector2(robot.Simulation.Speed.RowForm()/ norm(robot.Simulation.Speed.RowForm())*15);
            end
        else 
            %robot.Orientation = Vector2(-1*(targetSpeed.RowForm())/norm(targetSpeed.RowForm()));
            robot.Orientation = Vector2(robot.Simulation.Speed.RowForm()/ norm(robot.Simulation.Speed.RowForm()));
        end            
    else %Backfire of the differential movements.
        
        
    end

end

