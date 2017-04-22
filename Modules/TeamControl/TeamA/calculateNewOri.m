function newControlSignal = calculateNewOri(State, potField, oldControl )
%Calculates the new orientation of the robots if needed
    Own = 1;
    Opp = 1;
    for i=1:length(State.robots)
        if (strcmp(State.robots(i).Owner,Team))
            teamMemberOwn(Own) = State.robots(i);
            robotPos(i) = Vector2(teamMemberOwn(Own).Radius*SimulationData.sampleTime,teamMemberOwn(Own).Radius*SimulationData.sampleTime);
            targetPos(i) = Vector2(size(potField{Own},2)-teamMemberOwn(Own).Radius*SimulationData.sampleTime,...
            size(potField{Own},1)-teamMemberOwn(Own).Radius*SimulationData.sampleTime);
            Own = Own + 1;
        else
            teamOpponent(Opp) = State.robots(i);
            Opp = Opp + 1; 
        end
    end
    
    R = teamMemberOwn.robots(1).Radius;

    for i=1:length(teamMemberOwn)
        robotPos(i)
    end
end

