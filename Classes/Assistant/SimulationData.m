classdef SimulationData
    %SIMULATIONDATA Class to assist Simulations
    %   This class is used to store the speed on each simulated robot and
    %   the ball, furthermore it stores the environment values such as
    %   friction, drag etc as a static property (implemented as static
    %   method, due to matlab restrictions)
    properties
        Speed;      %Vector2 property to store Speed X and Speed Y values
        Mass;       %Scalar propery to store Mass value
    end
    
    methods (Static)
        function out = friction(data)   %Static Friction property
            persistent Var;
            if nargin
                Var = data;
            end
            out = Var;
        end
        function out = sampleTime(data)   %Static Friction property
            persistent Var;
            if nargin
                Var = data;
            end
            out = Var;
        end
    end
    methods
        %Class constructor
%<<<<<<< Updated upstream
        function this = SimulationData(aX,aY,aMass)  
            switch nargin
                case 2
                    this.Speed = Vector2(aX,aY);
                case 3
                this.Speed = Vector2(aX,aY);
                this.Mass = aMass;
                otherwise 
                    error('SimulationData input arguments error!')
            end
        end
        function result = eq(this,other)
            if(this.Speed == other.Speed && this.Mass== other.Mass)
                result = true;
            else
                result=false;
            end
        end
    end
    
end

