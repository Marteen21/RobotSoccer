classdef Ball
    %BALL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Position;
        Friction;
    end
    
    methods
        function obj = Ball(aX,aY)
            obj.Position = Vector2(aX,aY)
        end
        
        function obj = Ball(aX,aY,fric)
            obj.Position = Vector2(aX,aY);
            obj.Friction = fric;
        end
        
        
    end
    
end

