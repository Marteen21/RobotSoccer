function SimulationData = Simulate( startState, noSteps )
%SIMULATE Summary of this function goes here
%   Detailed explanation goes here
    c = [startState];
    for i = 1:noSteps
       c(end+1) = c(end).NextState();
       c(end) = Referee.fixMyState(c(end));
       c(end) = TeamA.controlMyState(c(end));
       c(end) = TeamB.controlMyState(c(end));
       %Referee in progress
       goal = Referee.isGoal(c(end));
       if (goal)
           [c(end).ball, c(end).robots] = Referee.Reset(c(end).ball,c(end).robots);
           Referee.isGoal = false;
       else
       end
       if(i==89)
       end
    end
    SimulationData = c;
end

