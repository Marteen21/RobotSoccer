function [ControlSignal, Target, Time] = MoveTo(agentIndex,  robot, Target, File, Nev )
%MOVETO Summary of this function goes here
%   Moving to the desired target
    if nargin > 3
        if (agentIndex == 1)
            fprintf(File,'Funtion name: %s\n', Nev);
            fprintf(File,'RobotSpeed before Moveto: %d_%d \n',robot.Simulation.Speed.X, robot.Simulation.Speed.Y);
        end
    end
%     TargetOri = Target-robot.Position;
%     TempSpeedRobot = robot.Simulation.Speed;
%     %if the angle between the robot orientation and the direction the
%     %target is greater than 40° the robot first change it's orientation and
%     %after that it moves to the target.
%     AngleS = ceil((CIncidentAngle(TargetOri,robot.Orientation)*180)/pi);
% %     if AngleS<40
%         
%         targetSpeed = robot.Position-(Target);
%         targetSpeed = Vector2(targetSpeed.RowForm()/norm(targetSpeed.RowForm())* 15);
%         diffSpeed = robot.Simulation.Speed-targetSpeed;
%         diffSpeed = Vector2(diffSpeed.RowForm()/norm(diffSpeed.RowForm())* SimulationData.sampleTime* 10);
%         desiredSpeedTemp = robot.Simulation.Speed + diffSpeed;
%         if (norm(desiredSpeedTemp.RowForm()) >= 15)
%             desiredSpeed = Vector2(desiredSpeedTemp.RowForm()/ norm(desiredSpeedTemp.RowForm())*15);
%         else
%             desiredSpeed = Vector2(desiredSpeedTemp.RowForm());
%         end
% 
%         if (cross([robot.Simulation.Speed.X,robot.Simulation.Speed.Y,0],[robot.Orientation.X,robot.Orientation.Y,0])==0)
%             if norm(robot.Simulation.Speed.RowForm()) >= 15
%                 desiredSpeed = Vector2(robot.Simulation.Speed.RowForm()/ norm(robot.Simulation.Speed.RowForm())*15);
%             end
%         else 
%             %robot.Orientation = Vector2(robot.Simulation.Speed.RowForm()/ norm(robot.Simulation.Speed.RowForm()));
%             robot.Orientation = Vector2(desiredSpeed.RowForm()/ norm(desiredSpeed.RowForm()));
%         end    
%         if (agentIndex == 1)
%             fprintf(File,'RobotSpeed after Moveto: %d_%d \n\n',desiredSpeed.X, desiredSpeed.Y);
%         end
%%
%NEW MoveTo with ControlSignal
 [ControlSignal OriEnd] = DifferentialEQ(robot, Target);
 Target = robot.Target;
 [s o] = size(ControlSignal);
 Time = s;
    

end

