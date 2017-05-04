function SimulationData = Simulate( startState, noSteps )
    %SIMULATE Summary of this function goes here
    %   Detailed explanation goes here
    FID = fopen('LogFile.txt', 'w');
    if FID < 0
       error('Cannot open file');
    end
    c = [startState];
    [ControlSignalA, ControlSignalB, oldControlA, oldControlB, CompareTargetA, CompareTargetB]=initialForControls(length(c.robots));
    for i = 1:noSteps
        Own = 1;
        Opp = 1;
        c(end+1) = c(end).NextState(); % ebben van benne az aktualis collosionVector szamitas
        goal = Referee.isGoal(c(end));
        c(end) = Referee.fixMyState(c(end),i);
        
        %Referee in progress
        if (goal)
            [c(end).ball, c(end).robots] = Referee.Reset(c(end).ball,c(end).robots);
            Referee.isGoal = false;
        else
        end

        
        %EZT nem ide kéne-----
        for k=1:length(c(end).robots)
           costDist(k) = CostFunction(c(end).robots(k),c(end).ball); 
           
           if (strcmp(c(end).robots(k).Owner,'TeamA'))
               teamMemberA(Own) = c(end).robots(k);
               Own = Own + 1;
           else
               teamMemberB(Opp) = c(end).robots(k);
               Opp = Opp + 1;
           end
        end
        %---------------------
        
        %Ha a kovetkezo sorbol adodo ControlSignal valtozik, frissiteni
        %kell a local ControlSignalt. Ha nem a folytatni a ovetkezo
        %teraciot.

        %ControlSignal 3 blokkbol allo elem, oszlopai a kulonbozo robothoz
        %tartozó controllok
        [ControlSignalA, TargetA] = TeamA.controlMyState(c(end),costDist,FID,teamMemberA,teamMemberB);
        [ControlSignalB, TargetB] = TeamB.controlMyState(c(end),costDist,teamMemberA,teamMemberB);
        %Egymashoz kozel elhelyezkedo Targetet azonosnak tekintunk
        for k=1:length(TargetA)
            if (Distance(CompareTargetA(k),TargetA{k}) < 5)
                TargetA{k} = CompareTargetA(k);
                if ~isempty(oldControlA{k})
                    ControlSignalA{k} = oldControlA{k};
                end
            end
            CompareTargetA(k) = TargetA{k};
        end
        for k=1:length(TargetB)
            if (Distance(CompareTargetB(k),TargetB{k}) < 5)
                TargetB{k} = CompareTargetB(k);
                if ~isempty(oldControlB{k})
                    ControlSignalB{k} = oldControlB{k};
                end
            end
            CompareTargetB(k) = TargetB{k};
        end
        [c(end), oldControlA] = TeamA.calculateControls(c(end),ControlSignalA, TargetA, FID, teamMemberA);
        [c(end), oldControlB] = TeamB.calculateControls(c(end),ControlSignalB, TargetB, FID, teamMemberB);
        
        %Potential field and new orientation calculation
        [potField, robotIndexes] = buildUpPotField(c(end),teamMemberA, TargetA, 'TeamA');
        if ~isnan(potField{1}(1,1))
            oldControlA = calculateNewOri(c(end), potField, oldControlA, robotIndexes);
        end
        [potField, robotIndexes] = buildUpPotField(c(end),teamMemberB, TargetB, 'TeamB');
        if ~isnan(potField{1}(1,1))
            oldControlB = calculateNewOri(c(end), potField, oldControlB, robotIndexes);
        end
        
        
%         c(end) = TeamB.controlMyState(c(end),costDist,teamMemberA,teamMemberB);
        
%         %Referee in progress
%         if (goal)
%             [c(end).ball, c(end).robots] = Referee.Reset(c(end).ball,c(end).robots);
%             Referee.isGoal = false;
%         else
%         end
    end
    fclose(FID);
    SimulationData = c;
end

function [ControlSignalA, ControlSignalB, oldControlA, oldControlB, CompareTargetA, CompareTargetB] = initialForControls(count)
    ControlSignalA{1} = 0;
    ControlSignalB{1} = 0;
    for i = 1:count
        oldControlA{i} = zeros(1,2);
        oldControlB{i} = zeros(1,2);
        CompareTargetA(i) = Vector2(0,0);
        CompareTargetB(i) = Vector2(0,0);
    end
end

