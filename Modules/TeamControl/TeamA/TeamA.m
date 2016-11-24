classdef TeamA
    %TEAMA Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods (Static)
        function controlledState = controlMyState(originalState,Cost)
            min = 5*10E6;
            MaxSpeed = 15;
            for i=1:length(originalState.robots)
%                 if(strcmp(originalState.robots(i).Owner,'TeamA'))
%                     if Cost(i)<min
%                         min = Cost(i);
%                     end
%                 end
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
            bestShot(3, 2) = 0;
            kickAble(3, 1) = 0;
            ballSpeed = abs(originalState.ball.Simulation.Speed);
            

            %probably the Kickability is not even needed....................
            fuz = readfis('kickAbility');
            for i = 1:length(originalState.robots)
                if (strcmp(originalState.robots(i).Owner,'TeamA'))
                    bestShot(i,:) = BestTarget(i, originalState.robots, originalState.robots);
                    kickAble(i, 1) = evalfis([distToBall(1, i) ballSpeed], fuz);
                end
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
            if originalState.ball.Simulation.Speed.X >= 0 && originalState.ball.Position.X > 45
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
                    for agentIndex = 1:length(originalState.robots)
%                         CS0=zeros(CycleBatch,2);

                        DesiredSpeedTime=1;

                        %closest to the ball gets to attack (for now)
                        % if (kickAble(agentIndex) == max(kickAble) && max(kickAble) > 0.5) %what should be this number??? probability of successful kick..
                        if (distToBall(agentIndex)==min(distToBall) && distToBall(agentIndex) < 10)
                            [CS,originalState.robots(agentIndex).Target,originalState.robots(agentIndex).TargetSpeedTime]= haromszog(agentIndex,originalState.robots,originalState.ball,DesiredPlace{agentIndex},MaxSpeed);
                        else
                            originalState.robots(agentIndex).Target=[DesiredPlace{agentIndex}(3:4) 0 0];
                            [CS,originalState.robots(agentIndex).Target,originalState.robots(agentIndex).TargetSpeedTime]= moveTo(agentIndex,originalState.robots,DesiredSpeedTime);
                        end;
%                         [s,o]=size(CS);
% 
%                         if s < 2000   % issue with s growing too large sometimes. RESOLVE!!!!
%                             for i=1:s
%                                 CS0(i,:)=CS(i,:);
%                             end;
%                             ControlSignal{agentIndex} = [GameMode(1)+(1:CycleBatch)', CS0(1:CycleBatch,:) ];
%                         end
                    end
            end

            
            
            
            controlledState = originalState;
        end
    end
end

