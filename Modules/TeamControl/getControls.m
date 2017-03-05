function [ ControlSignal, Target, Time ] = getControls(robot, TargetNew, File, Nev )
%Get the Control signals and the desired Target

    %LogFile.txt
    if nargin > 3
            fprintf(File,'Funtion name: %s\n', Nev);
            fprintf(File,'RobotSpeed before Moveto: %d_%d \n',robot.Simulation.Speed.X, robot.Simulation.Speed.Y);
    end
    %-----------

    [ControlSignal OriEnd] = DifferentialEQ(robot, TargetNew);
    Target = TargetNew;
    [s o] = size(ControlSignal);
    Time = s;

end

