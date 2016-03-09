classdef Vector2
    %VECTOR2 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        X;
        Y;
    end
    
    methods
        function this = Vector2(aX,aY)
            %class constructor
            this.X = aX;
            this.Y = aY;
        end
        function d = Distance(this,other)
            d = sqrt((other.X-this.X)^2+(other.Y-this.Y)^2)
        end
        
    end
end

