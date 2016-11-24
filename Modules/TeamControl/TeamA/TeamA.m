classdef TeamA
    %TEAMA Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods (Static)
        function controlledState = controlMyState(originalState,Cost)
            min = 5*10E6;
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
            %robotsA and robotsB first element is the robotindex
            
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

            
            controlledState = originalState;
        end
    end
end

