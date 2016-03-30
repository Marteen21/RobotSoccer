classdef SimulationData
    %SIMULATIONDATA Class to assist Simulations
    %   This class is used to store the speed on each simulated robot and
    %   the ball, furthermore it stores the environment values such as
    %   friction, drag etc as a static property (implemented as static
    %   method, due to matlab restrictions)
    properties
        Speed;  %Vector2 property to store Speed X and Speed Y values
        Mass;   %Scalar propery to store Mass value
    end
    
    methods (Static)
        function out = friction(data)   %Static Friction property
            persistent Var;
            if nargin
                Var = data;
            end
            out = Var;
        end
    end
    methods
        %Class constructor
        function this = SimulationData(aX,aY)   
            this.Speed = Vector2(aX,aY);
        end
        
    end
    
end

