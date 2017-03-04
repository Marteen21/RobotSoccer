function [ ControlSignal, Target, Time ] = getControls( robot, Target, File, Nev )
%Get the Control signals and the desired Target

    %LogFile.txt
    if nargin > 3
        if (agentIndex == 1)
            fprintf(File,'Funtion name: %s\n', Nev);
            fprintf(File,'RobotSpeed before Moveto: %d_%d \n',robot.Simulation.Speed.X, robot.Simulation.Speed.Y);
        end
    end
    %-----------

    [ControlSignal OriEnd] = DifferentialEQ(robot, Target);
    Target = robot.Target;
    [s o] = size(ControlSignal);
    Time = s;

end

