function SimulationData = Simulate( startState, noSteps )
    %SIMULATE Summary of this function goes here
    %   Detailed explanation goes here
    FID = fopen('LogFile.txt', 'w');
    if FID < 0
       error('Cannot open file');
    end
    c = [startState];
    ControlSignal{1} = 0;
    oldControl{1} = zeros(1,2);
    oldControl{2} = zeros(1,2);
    oldControl{3} = zeros(1,2);
    CompareTarget(1) = Vector2(0,0);
    CompareTarget(2) = Vector2(0,0);
    CompareTarget(3) = Vector2(0,0);
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

        %ControlSignal 3 blokkbol allo elem, oszlopai a kulonbozo robothoz
        %tartozó controllok
        [ControlSignal, Target] = TeamA.controlMyState(c(end),costDist,FID);
        %Egymashoz kozel elhelyezkedo Targetet azonosnak tekintunk
        for k=1:length(Target)
            if (Distance(CompareTarget(k),Target{k}) < 5)
                Target{k} = CompareTarget(k);
                ControlSignal{k} = oldControl{k};
            end
            CompareTarget(k) = Target{k};
        end
        [c(end), oldControl] = TeamA.calculateControls(c(end),ControlSignal, Target,FID);
        
        
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

