function SimulationData = Simulate( startState, noSteps )
    %SIMULATE Summary of this function goes here
    %   Detailed explanation goes here
    FID = fopen('LogFile.txt', 'w');
    if FID < 0
       error('Cannot open file');
    end
    c = [startState];
    for i = 1:noSteps
        c(end+1) = c(end).NextState(FID);
        goal = Referee.isGoal(c(end));
        c(end) = Referee.fixMyState(c(end),FID,i);
        for k=1:length(c(end).robots)
           costDist(k) = CostFunction(c(end).robots(k),c(end).ball); 
        end
        c(end) = TeamA.controlMyState(c(end),costDist);
        c(end) = TeamB.controlMyState(c(end));
        
        %----Logging ball vectors----
            
%             if FID < 0
%                  error('Cannot open file');
%             end
%             %fprintf(FID, '%s\n', Data);  % Write to the screen at the same time:
%                                           % fprintf('%s\n', Data);
%             fprintf(FID, 'Step:%d \n',i);
%             fprintf(FID, 'Ball POS:%d_%d ',c(end).ball.Position.X,c(end).ball.Position.Y);
%             fprintf(FID, 'Ball speed:%d_%d ',c(end).ball.Simulation.Speed.X,c(end).ball.Simulation.Speed.Y);
%             fprintf(FID, 'CollisionVector:%d ',c(end).ball.Simulation.CollisionVector);
%             fprintf(FID, 'CollisionTime:%d \n\n',c(end).ball.Simulation.CollisionTime);

            
        %--------
        
        %Referee in progress
        if (goal)
            [c(end).ball, c(end).robots] = Referee.Reset(c(end).ball,c(end).robots);
            Referee.isGoal = false;
        else
        end
        if(i==16)
        end
    end
    fclose(FID);
    SimulationData = c;
end

