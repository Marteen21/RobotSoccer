classdef Vector2
    %VECTOR2 An X,Y Vector,
    %   It is used to model the game in 2 dimension, used as a property in
    %   various classes.
    
    properties
        X;
        Y;
    end
    
    methods
        %% Class constructor
        function this = Vector2(aX,aY)
            if nargin == 1
                this.X = aX(1);
                this.Y = aX(2);
            elseif nargin == 2
                this.X = aX;
                this.Y = aY;
            else
                error('arg error');
            end
        end
        %Returns the distance between 2 vectors
        function d = Distance(this,other)
            d = sqrt((other.X-this.X)^2+(other.Y-this.Y)^2);
        end
        %% Return as matlab vectors
        %Return the class as a Matlab 1x2 Matrix
        function v = RowForm(this)
            v = [this.X,this.Y];
        end
        %Returns the class as a Matlab 2x1 Matrix
        function v = ColumnForm(this)
            v = [this.X;this.Y];
        end
        %% Rodriguez shit
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
        %% Functions
        function nvector = D2NVector(this)
            nvector = Vector2(this.Y,-1*this.X);
        end
        %Gives back the reflected vector from wall
        function result = TotalReflectionFrom(this, wall)
            e = wall.RowForm()/norm(wall.RowForm());
            n1 = this.RowForm()/norm(this.RowForm());
            n2 = 2*(dot(n1,e))*e-n1;
            result = Vector2(n2*norm(this.RowForm()));
            if isnan(result.X) || isnan(result.Y)
                result = Vector2([0;0]);
            end
        end
        %% Operators -,+,.*
        function result = minus (this, other)
            if isa(other,'Vector2')
                result = Vector2(this.X-other.X, this.Y-other.Y);
            else
                error('The - operator is not defined for this two classes.');
            end
        end
        function result = plus (this, other)
            if isa(other,'Vector2')
                result = Vector2(this.X+other.X, this.Y+other.Y);
            else
                error('This operator is not defined for this two classes.');
            end
        end
        function result = times(this, c)    %Times a constant
            if (isnumeric(c))
                result = Vector2(this.X*c,this.Y*c);
                %elseif isa(c,'Vector2')
                %
            else
                error('This operator is not defined for this two classes.');
            end
            
        end
        function result = eq(this,other)
            if(this.X == other.X && this.Y == other.Y)
                result = true;
            else
                result = false;
            end
        end
    end
end

