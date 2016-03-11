classdef Robot
    %ROBOT Summary of this class goes here
    %   Detailed explanation goes here
    properties
        Position;       %Vector2
        Orientation;    %Vector2
        Simulation;     %SimulationData
    end
    
    methods
        function this = Robot(aX, aY, aO)
            this.Position = Vector2(aX, aY);
            this.Orientation = aO;
        end        
    end
end

