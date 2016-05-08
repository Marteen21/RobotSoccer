function SimulationData = Simulate( startState, noSteps )
%SIMULATE Summary of this function goes here
%   Detailed explanation goes here
    c = [startState];
    for i = 1:noSteps
        c(end+1) = c(end).NextState();
    end
    SimulationData = c;
end

