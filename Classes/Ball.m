classdef Ball
    %BALL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Position;
        Friction;
    end
    
    methods
        function obj = Ball(aX,aY,fric)
            
        switch nargin
            
            case 2
                obj.Position = Vector2(aX,aY);
                
            case 3
                obj.Position = Vector2(aX,aY);
                obj.Friction = fric;
                ...
            otherwise
                error('Ball class: Number of input arguments must be 2 or 3');
            
        end
            
%         function obj = Ball(aX,aY)
%             obj.Position = Vector2(aX,aY)
%         end
%         
%         function obj = Ball(aX,aY,fric)
%             obj.Position = Vector2(aX,aY);
%             obj.Friction = fric;
%         end
        
        
    end
    
    end
end

