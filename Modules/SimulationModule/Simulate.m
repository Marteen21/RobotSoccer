function SimulationData = Simulate( startState, noSteps )
    %SIMULATE Summary of this function goes here
    %   Detailed explanation goes here
    FID = fopen('LogFile.txt', 'w');
    if FID < 0
       error('Cannot open file');
    end
    c = [startState];
    ControlSignal{1} = 0;
    Time = 1; %number of times when the controlsignal remain unchanged
    for i = 1:noSteps
        c(end+1) = c(end).NextState();
        %c(end).ball.Simulation.Speed
        goal = Referee.isGoal(c(end));
        c(end) = Referee.fixMyState(c(end),i);
        
        %EZT nem ide kéne-----
        for k=1:length(c(end).robots)
           costDist(k) = CostFunction(c(end).robots(k),c(end).ball); 
        end
        %---------------------
        
        %Ha a kovetkezo sorbol adodo ControlSignal valtozik, frissiteni
        %kell a local ControlSignalt. Ha nem a folytatni a ovetkezo
        %teraciot.
        if ~(ControlSignal{1} == 0)
          oldControl = ControlSignal;
        end
        %ControlSignal 3 blokkbol allo elem, sorai a kulonbozo robot
        %Controllok
        [ControlSignal, Target] = TeamA.controlMyState(c(end),costDist,FID);
 
        for k=1:length(ControlSignal)
            Compare(k) = (oldControl{k} == ControlSignal{k}(Time:end,:));
        end
        %all() logical AND operator
        Logic = all(Compare);
        if Logic
          c(end) = TeamA.calculateControls(c(end),oldControl, Target);
          Time = Time+1;
        else
          c(end) = TeamA.calculateControls(c(end),ControlSignal, Target);
          Time = 0;
        end
         
        
        %c(end) = TeamA.controlMyState(c(end),costDist,FID);
        
        c(end) = TeamB.controlMyState(c(end),costDist);
        
        %Referee in progress
        if (goal)
            [c(end).ball, c(end).robots] = Referee.Reset(c(end).ball,c(end).robots);
            Referee.isGoal = false;
        else
        end
        if(i==18)
            stop=0;
        end
    end
    fclose(FID);
    SimulationData = c;
end

