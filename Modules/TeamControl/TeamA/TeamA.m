classdef TeamA
    %TEAMA Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods (Static)
        function controlledState = controlMyState(originalState,Cost)
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
%             for i=1:length(originalState.robots)
%                 if(strcmp(originalState.robots(i).Owner,'TeamA'))
%                     if (Cost(i)==min)
%                         %targetSpeed = originalState.robots(i).Position-(originalState.ball.Position+Vector2([rand-0.5;rand-0.5]));
%                         targetSpeed = originalState.robots(i).Position-(originalState.ball.Position);
%                         targetSpeed = Vector2(targetSpeed.RowForm()/norm(targetSpeed.RowForm())* 15);
%                         diffSpeed = originalState.robots(i).Simulation.Speed-targetSpeed;
%                         diffSpeed = Vector2(diffSpeed.RowForm()/norm(diffSpeed.RowForm())* SimulationData.sampleTime* 10);
%                         originalState.robots(i).Simulation.Speed = originalState.robots(i).Simulation.Speed + diffSpeed;
%                         if norm(originalState.robots(i).Simulation.Speed.RowForm()) >= 15
%                             originalState.robots(i).Simulation.Speed = Vector2(originalState.robots(i).Simulation.Speed.RowForm()/ norm(originalState.robots(i).Simulation.Speed.RowForm())*15);
%                         end
% 
% 
%                         %Orientation pointing at the target all the time
%                         if (cross([originalState.robots(i).Simulation.Speed.X,originalState.robots(i).Simulation.Speed.Y,0],[originalState.robots(i).Orientation.X,originalState.robots(i).Orientation.Y,0])==0)
%                             if norm(originalState.robots(i).Simulation.Speed.RowForm()) >= 15
%                                 originalState.robots(i).Simulation.Speed = Vector2(originalState.robots(i).Simulation.Speed.RowForm()/ norm(originalState.robots(i).Simulation.Speed.RowForm())*15);
%                             end
%                         else 
%                             originalState.robots(i).Orientation = Vector2(-1*(targetSpeed.RowForm())/norm(targetSpeed.RowForm()));
%                         end              
%                     else
%                         target = Vector2(Environment.xLim/2 - 40,Environment.yLim/2 - Environment.yLim/40);
%                         targetSpeed = originalState.robots(i).Position-target;
%                         if (norm(targetSpeed.RowForm()) > 0)
%                             targetSpeed = Vector2(targetSpeed.RowForm()/norm(targetSpeed.RowForm())* 15);
%                         else
%                             %targetSpeed = norm(targetSpeed.RowForm());
%                         end
%                         
%                         %Going to the starting point
%                         diffSpeed = originalState.robots(i).Simulation.Speed-targetSpeed;
%                         if (norm(diffSpeed.RowForm()) > 0)
%                             diffSpeed = Vector2(diffSpeed.RowForm()/norm(diffSpeed.RowForm())* SimulationData.sampleTime* 10);
%                         end
%                         originalState.robots(i).Simulation.Speed = originalState.robots(i).Simulation.Speed + diffSpeed;
%                         if norm(originalState.robots(i).Simulation.Speed.RowForm()) >= 15
%                             originalState.robots(i).Simulation.Speed = Vector2(originalState.robots(i).Simulation.Speed.RowForm()/ norm(originalState.robots(i).Simulation.Speed.RowForm())*15);
%                         end
%                         %Orientation pointing at the target all the time
%                         if (cross([originalState.robots(i).Simulation.Speed.X,originalState.robots(i).Simulation.Speed.Y,0],[originalState.robots(i).Orientation.X,originalState.robots(i).Orientation.Y,0])==0)
%                             if norm(originalState.robots(i).Simulation.Speed.RowForm()) >= 15
%                                 originalState.robots(i).Simulation.Speed = Vector2(originalState.robots(i).Simulation.Speed.RowForm()/ norm(originalState.robots(i).Simulation.Speed.RowForm())*15);
%                             end
%                         else
%                             originalState.robots(i).Orientation = Vector2(-1*(targetSpeed.RowForm())/norm(targetSpeed.RowForm()));
%                         end
%                     end
%                 end
%             end
            %originalState.robots and robotsB first element is the robotindex
            
            %--------HLS implementation with fuzzy--------
            bestShot(2, 2) = 0;
            kickAble(3, 1) = 0;
            if (originalState.ball.Simulation.Speed.RowForm() ~= [0 0])
                ballSpeed = abs(Vector2(originalState.ball.Simulation.Speed.RowForm()));
            else
                ballSpeed = abs(originalState.ball.Simulation.Speed);
            end
            
            %Choosing the member of TeamA with the agentIndex
            %CIKLUSBA ÁTÍRNI!!!
            teamAgentA = [originalState.robots(1) originalState.robots(3)];
            %agentAindex = [1 3];
            teamAgentB = [originalState.robots(2) originalState.robots(4)];
            %
            
            %probably the Kickability is not even needed....................
            fuz = readfis('kickAbility');
            for i = 1:length(teamAgentA)
                bestShot(i,:) = BestTarget(i, teamAgentA, teamAgentB);
                %asd = [distToBall(1, i) ballSpeed]
                kickAble(i, 1) = evalfis([distToBall(1, i) ballSpeed], fuz);
            end
            %fuzzy system assigns a position for each team member depending on the role
            %(permanent assignment for now - defender, midfielder and attacker.
            %output is x, y position.
            fuz = readfis('Formation');
            for i = 1:2
                formation(i, 1:2) = evalfis([(i/2 - 0.1) originalState.ball.Position.X originalState.ball.Position.Y], fuz);
            end

            DesiredPlace{1} = [ bestShot(1,:) formation(2,:)];
            DesiredPlace{2} = [ bestShot(2,:) formation(1,:)];
            
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
                            [teamAgentA(agentIndex).Simulation.Speed,teamAgentA(agentIndex).Target]= haromszog(agentIndex,originalState.robots,originalState.ball,DesiredPlace{agentIndex},MaxSpeed);
                        else
                            teamAgentA(agentIndex).Target=[DesiredPlace{agentIndex}(3:4) 0 0];
                            %[CS,teamAgentA(agentIndex).Target,teamAgentA(agentIndex).TargetSpeedTime]= MoveTo(agentIndex,originalState.robots,DesiredSpeedTime);
                            Target = Vector2(teamAgentA(agentIndex).Target(1), teamAgentA(agentIndex).Target(2));
                            
                            %Moving to the target
                            teamAgentA(agentIndex).Simulation.Speed = MoveTo(teamAgentA(agentIndex), Target);
                            %End of moving
                            
                        end;
                    end
                  case 'hidefense'
                        %red - defence
                        agentIndex = 1;
                        DesiredSpeedTime = 1;
                        target = Goalie(originalState.ball);
                        if target > 0
                            teamAgentA(agentIndex).Target=[target 0 0];
                        else
                            teamAgentA(agentIndex).Target=[0 0];
                        end
                        Target = Vector2(teamAgentA(agentIndex).Target(1), teamAgentA(agentIndex).Target(2));
                        
                        %Moving to the target
                        teamAgentA(agentIndex).Simulation.Speed = MoveTo(teamAgentA(agentIndex),Target);

                        for agentIndex = 2:(length(originalState.robots))/2
                            %CS0=zeros(CycleBatch,2);
                            
                            DesiredSpeedTime=1;
                            
                            %closest to the ball gets to attack (for now)
                            % if (kickAble(agentIndex) == max(kickAble) && max(kickAble) > 0.5) %what should be this number??? probability of successful kick..
                            if (distToBall(agentIndex)==min)
                                [teamAgentA(agentIndex).Simulation.Speed,teamAgentA(agentIndex).Target]=haromszog(agentIndex,originalState.robots,originalState.ball,DesiredPlace{agentIndex},MaxSpeed);
                            else
                                teamAgentA(agentIndex).Target=[DesiredPlace{agentIndex}(3:4) 0 0];
                                Target = Vector2(teamAgentA(agentIndex).Target(1), teamAgentA(agentIndex).Target(2));
                                teamAgentA(agentIndex).Simulation.Speed = MoveTo(teamAgentA(agentIndex), Target);
                            end;
                        end
            end
            %originalState.ball.Simulation.Speed
            controlledState = originalState;
        end
    end
end

