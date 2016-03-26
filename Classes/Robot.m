classdef Robot
    %ROBOT Summary of this class goes here
    %   Detailed explanation goes here
    properties
        Position;       %Vector2
        Orientation;    %Vector2
        Simulation;     %SimulationData
        Radius;         %Radius of the simulated robot
    end
    
    methods
        function this = Robot(aX, aY, aO, r)
            this.Position = Vector2(aX, aY);
            this.Orientation = aO;
            this.Radius = r;
        end        
    end
end

