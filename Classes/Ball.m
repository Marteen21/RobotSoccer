classdef Ball
    %BALL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Position;       %Vector2
        Simulation;     %SimulationData
    end
    
    methods
        function obj = Ball(aX,aY,fric)
            switch nargin
                
                case 2
                    obj.Position = Vector2(aX,aY);  %Set position
                    
                case 3
                    obj.Position = Vector2(aX,aY);  %Set position
                    SimulationData.friction(fric);  %Set global friction
                    ...
                otherwise
                error('Ball class: Number of input arguments must be 2 or 3');
                
            end
        end
    end
end

