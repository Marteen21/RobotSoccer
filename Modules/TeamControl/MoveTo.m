function desiredSpeed = MoveTo( robot, Target )
%MOVETO Summary of this function goes here
%   Moving to the desired target
    
    targetSpeed = robot.Position-(Target);
    targetSpeed = Vector2(targetSpeed.RowForm()/norm(targetSpeed.RowForm())* 15);
    diffSpeed = robot.Simulation.Speed-targetSpeed;
    diffSpeed = Vector2(diffSpeed.RowForm()/norm(diffSpeed.RowForm())* SimulationData.sampleTime* 10);
    desiredSpeedTemp = robot.Simulation.Speed + diffSpeed;
    if norm(desiredSpeedTemp.RowForm()) >= 15
        desiredSpeed = Vector2(robot.Simulation.Speed.RowForm()/ norm(robot.Simulation.Speed.RowForm())*15);
    else
        desiredSpeed = Vector2(robot.Simulation.Speed.RowForm());
    end


end

