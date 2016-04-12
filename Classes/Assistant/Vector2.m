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
        %Return the class as a Matlab 1x2 Matrix
        function v = RowForm(this)
            v = [this.X,this.Y];
        end
        %Returns the class as a Matlab 2x1 Matrix
        function v = ColumnForm(this)
            v = [this.X;this.Y];
        end
        %return the incident angle
        function alpha = CIncidentAngle(this,other)
            alpha = (acos(dot(this.ColumnForm,other.ColumnForm)/(norm(this.ColumnForm)*norm(other.ColumnForm))));
        end
        
        function alpha = SIncidentAngle(this,other)
            alpha = (asin(cross([this.ColumnForm;0],[other.ColumnForm;0])/(norm(this.ColumnForm)*norm(other.ColumnForm))));
        end
        
        function theta = RodriguezRot(this,other)
            alpha = SIncidentAngle(this,other);
            theta = sign(alpha(3))*(pi-2*abs(alpha(3)));
        end
        function nvector = D2NVector(this)
            nvector = Vector2(this.Y,-this.X);
        end
        function result = minus (this, other)
            result = Vector2(this.X-other.X, this.Y-other.Y);
        end
        function result = plus (this, other)
            result = Vector2(this.X+other.X, this.Y+other.Y);
        end
        function result = times(this, c)    %Times a constant
           result.X = this.X*c;
           result.Y = this.Y*c;
        end
    end
end

