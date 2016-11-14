classdef TeamA
    %TEAMA Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods (Static)
        function controlledState = controlMyState(originalState)
            for i=1:length(originalState.robots)
                if(strcmp(originalState.robots(i).Owner,'TeamA'))
                    %targetSpeed = originalState.robots(i).Position-(originalState.ball.Position+Vector2([rand-0.5;rand-0.5]));
                    targetSpeed = originalState.robots(i).Position-(originalState.ball.Position);
                    targetSpeed = Vector2(targetSpeed.RowForm()/norm(targetSpeed.RowForm())* 15);
                    diffSpeed = originalState.robots(i).Simulation.Speed-targetSpeed;
                    diffSpeed = Vector2(diffSpeed.RowForm()/norm(diffSpeed.RowForm())* SimulationData.sampleTime* 10);
                    originalState.robots(i).Simulation.Speed = originalState.robots(i).Simulation.Speed + diffSpeed;
                    
                    if norm(originalState.robots(i).Simulation.Speed.RowForm()) >= 15
                        originalState.robots(i).Simulation.Speed = Vector2(originalState.robots(i).Simulation.Speed.RowForm()/ norm(originalState.robots(i).Simulation.Speed.RowForm())*15);
                    end
                    
                    %---------------------------------
                    %------FintA Differential EQ------
                    
                    [ SOunits, OrientationEnd ] = DifferentialEQ(originalState.robots(i),originalState.ball);
                    
                end
            end
            controlledState = originalState;
        end
    end
end

