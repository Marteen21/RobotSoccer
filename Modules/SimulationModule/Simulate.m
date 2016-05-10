function SimulationData = Simulate( startState, noSteps )
%SIMULATE Summary of this function goes here
%   Detailed explanation goes here
    c = [startState];
    for i = 1:noSteps
       c(end+1) = c(end).NextState();
       c(end) = Referee.fixMyState(c(end));
       c(end) = TeamA.controlMyState(c(end));
       c(end) = TeamB.controlMyState(c(end));
       if(i==89)
       end
    end
    SimulationData = c;
end

