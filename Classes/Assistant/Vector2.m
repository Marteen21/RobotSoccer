classdef Vector2
    %VECTOR2 An X,Y Vector, 
    %   It is used to model the game in 2 dimension, used as a property in
    %   various classes.
    
    properties
        X;
        Y;
    end
    
    methods
        %Class constructor
        function this = Vector2(aX,aY)
            this.X = aX;
            this.Y = aY;
        end
        %Returns the distance between 2 vectors
        function d = Distance(this,other)   
            d = sqrt((other.X-this.X)^2+(other.Y-this.Y)^2);
        end
        
    end
end

