function [ ControlSignal, Target, Time ] = getControls( robot, Target )
%Get the Control signals and the desired Target
    [ControlSignal OriEnd] = DifferentialEQ(robot, Target);
    Target = robot.Target;
    [s o] = size(ControlSignal);
    Time = s;

end

