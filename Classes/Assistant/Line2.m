classdef Line2
    %EQUATION Summary of this class goes here
    %   Detailed explanation goes here
    properties
        m;
        b;
    end
    
    methods
        function this = Line2(op1,op2,op3,op4)
            switch nargin
                
                case 2
                    this.m = op1;
                    this.b = op2;
                case 4
                    this.m = (op1-op2)/(op3-op4);
                    this.b = -1*this.m*op3+op1;   
                 ...
                otherwise
                error('Ball class: Number of input arguments must be 2 or 3');

            end
        end
        function f = Lequ(this)
            f = @(t) this.b+this.m*t;
        end
        function result = minus(this,other)
            result = Line2(this.m-other.m,(this.b-other.b));
        end
    end
    
end

