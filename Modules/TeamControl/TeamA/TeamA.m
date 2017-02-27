classdef TeamA
    %TEAMA Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods (Static)
        function controlledState = controlMyState(originalState,Cost,File)
            %originalState.ball.Simulation.Speed
            min = 5*10E6;
            MaxSpeed = 15;
            for i=1:length(originalState.robots)
                if(strcmp(originalState.robots(i).Owner,'TeamA'))
                    if Cost(i)<min
                        min = Cost(i);
                    end
                end
            end
            distToBall = Cost;
            %originalState.robots and robotsB first element is the robotindex
            
            %--------HLS implementation with fuzzy--------
            bestShot(3, 2) = 0;
            kickAble(3, 1) = 0;
            if (originalState.ball.Simulation.Speed.RowForm() ~= [0 0])
                ballSpeed = abs(Vector2(originalState.ball.Simulation.Speed.RowForm()));
            else
                ballSpeed = abs(originalState.ball.Simulation.Speed);
            end
            
            %Choosing the member of TeamA with the agentIndex
            k=1;
            for i=1:length(originalState.robots)
                if (strcmp(originalState.robots(i).Owner,'TeamA'))
                    teamAgentA(k) = originalState.robots(i);
                    k = k+1;
                end
            end
            k=1;
            for i=1:length(originalState.robots)
                if (strcmp(originalState.robots(i).Owner,'TeamB'))
                    teamAgentB(k) = originalState.robots(i);
                    k = k+1;
                end
            end
            %
            
            %probably the Kickability is not even needed....................
            fuz = readfis('kickAbility');
            for i = 1:length(teamAgentA)
                bestShot(i,:) = BestTarget(i, teamAgentA, teamAgentB);
                kickAble(i, 1) = evalfis([distToBall(1, i) ballSpeed], fuz);
            end
            %fuzzy system assigns a position for each team member depending on the role
            %(permanent assignment for now - defender, midfielder and attacker.
            %output is x, y position.
            fuz = readfis('Formation');
            for i = 1:3
                formation(i, 1:2) = evalfis([(i/3 - 0.1) originalState.ball.Position.X originalState.ball.Position.Y], fuz);
            end
            %formation 1: Offense; 2: defense; 3: middle;
            DesiredPlace{1} = [ bestShot(1,:) formation(1,:)];
            DesiredPlace{2} = [ bestShot(2,:) formation(3,:)];
            DesiredPlace{3} = [ bestShot(3,:) formation(2,:)];
            %!!!!!crude situation estimation. use fuzzy logic rules or simply think about
            %better way of deciding. At least come up with buffer, so that the roles
            %are not changed all the time.
            if originalState.ball.Simulation.Speed.X >= 0 && originalState.ball.Position.X > 50
                Situation = 'offense';
            else
                Situation = 'hidefense';
            end;
            
            %if offensive - use fuzzy logic for role assignment and BestTarget for
            %pass/shoot decision
            %if defensive - use Reacheable, try to intercept the ball and prevent
            %opponent from scoring

            switch Situation
                case 'offense'
                    for agentIndex = 1:(length(teamAgentA))
%                         CS0=zeros(CycleBatch,2);

                        DesiredSpeedTime=1;

                        %closest to the ball gets to attack (for now)
                        % if (kickAble(agentIndex) == max(kickAble) && max(kickAble) > 0.5) %what should be this number??? probability of successful kick..
                        if (distToBall(agentIndex)==min && distToBall(agentIndex) < 10)
                            [teamAgentA(agentIndex).Simulation.Speed,teamAgentA(agentIndex).Target]= haromszog(agentIndex,originalState.robots,originalState.ball,DesiredPlace{agentIndex},MaxSpeed,File);
                        else
                            teamAgentA(agentIndex).Target=Vector2(DesiredPlace{agentIndex}(3:4));
                            %[CS,teamAgentA(agentIndex).Target,teamAgentA(agentIndex).TargetSpeedTime]= MoveTo(agentIndex,originalState.robots,DesiredSpeedTime);
                            %Moving to the target, added agentIndex for the
                            %logFile, 
                            teamAgentA(agentIndex).Simulation.Speed = MoveTo(agentIndex, teamAgentA(agentIndex), teamAgentA(agentIndex).Target, File, 'TeamA.m offense');
                            %End of moving
                            
                        end;
                    end
                  case 'hidefense'
                        %agent 3 - defence
                        agentIndex = 3;
                        DesiredSpeedTime = 1;
                        target = Goalie(originalState.ball);
                        if target > 0
                            teamAgentA(agentIndex).Target=Vector2(target);
                        else
                            teamAgentA(agentIndex).Target=Vector2(0,0);
                        end
                        Target = teamAgentA(agentIndex).Target;
                        
                        %Moving to the target
                        teamAgentA(agentIndex).Simulation.Speed = MoveTo(agentIndex, teamAgentA(agentIndex),teamAgentA(agentIndex).Target, File,'TeamA.m hidefense');

                        for agentIndex = 1:(length(teamAgentA)-1)
                            %CS0=zeros(CycleBatch,2);
                            %if (i~=2)
                                DesiredSpeedTime=1;

                                %closest to the ball gets to attack (for now)
                                % if (kickAble(agentIndex) == max(kickAble) && max(kickAble) > 0.5) %what should be this number??? probability of successful kick..
                                if (distToBall(agentIndex)==min)
                                    [teamAgentA(agentIndex).Simulation.Speed,teamAgentA(agentIndex).Target]=haromszog(agentIndex,originalState.robots,originalState.ball,DesiredPlace{agentIndex},MaxSpeed,File);
                                else
                                    teamAgentA(agentIndex).Target=Vector2(DesiredPlace{agentIndex}(3:4));
                                    Target = teamAgentA(agentIndex).Target;
                                    teamAgentA(agentIndex).Simulation.Speed = MoveTo(agentIndex, teamAgentA(agentIndex), teamAgentA(agentIndex).Target, File,'TeamA.m hidefense2');
                                end;
                            %end
                        end
            end
            %originalState.ball.Simulation.Speed
            controlledState = originalState;
            fprintf(File,'Time: %d \n',originalState.time);
            fprintf(File,'RobotPos: %d_%d \n',teamAgentA(1).Position.X, teamAgentA(1).Position.Y);
            fprintf(File,'Target: %d_%d \n',teamAgentA(1).Target.X, teamAgentA(1).Target.Y);
            fprintf(File,'RobotSpeed: %d_%d \n\n', teamAgentA(1).Simulation.Speed.X, teamAgentA(1).Simulation.Speed.Y);
        end
    end
end

