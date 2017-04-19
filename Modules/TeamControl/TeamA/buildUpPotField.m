function potField = buildUpPotField(State, Target, Team)
%Planning the trajectory with potential field, correcting the orientation
%Ha a robot es a target koze esik akadaly
    
    sigma = sqrt(10);  %Sulytenyezo a potencial ter szamitasanal,
                  %pontos beállítása kérdéses;
    %Selecting the given team members
    Own = 1;
    Opp = 1;
    for i=1:length(State.robots)
        if (strcmp(State.robots(i).Owner,Team))
            teamMemberOwn(Own) = State.robots(i);
            Own = Own + 1;
        else
            teamOpponent(Opp) = State.robots(i);
            Opp = Opp + 1; 
        end
    end
    
    for i = 1:length(teamMemberOwn)
        xStep{1,i} = linspace(teamMemberOwn(i).Position.X-teamMemberOwn(i).Radius,...
            Target{i}.X+teamMemberOwn(i).Radius,...
            (abs(Target{i}.X-teamMemberOwn(i).Position.X+2*teamMemberOwn(i).Radius))/SimulationData.sampleTime);
        yStep{1,i} = linspace(teamMemberOwn(i).Position.Y-teamMemberOwn(i).Radius,...
            Target{i}.Y+teamMemberOwn(i).Radius,...
            (abs(Target{i}.Y-teamMemberOwn(i).Position.Y+2*teamMemberOwn(i).Radius))/SimulationData.sampleTime);
        
        for j = 1:length(xStep{1,i})
            for k = 1:length(yStep{1,i})
                potField{i}{j,k} = abs(Vector2([xStep{1,i}(1,j) yStep{1,i}(1,k)]-Target{i}.RowForm())) / (sigma^2);
            end
        end
        
    end
    
    
    

end

