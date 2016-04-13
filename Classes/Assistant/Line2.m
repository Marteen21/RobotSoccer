classdef Line2
    %EQUATION Summary of this class goes here
    %   Detailed explanation goes here
    properties
        m;
        b;
    end
    
    methods
        function this = Line2(op1,op2,op3,op4,op5,op6)
            switch nargin
                
                case 2
                    m = op1;
                    b = op2;
                    
                    this.m = m;
                    this.b = b;
                case 4
                    distance0 = op1;
                    distanceT = op2;
                    time0 = op3;
                    timeT = op4;
                    
                    this.m = (distance0-distanceT)/(time0-timeT);
                    this.b = -1*this.m*time0+distance0;
                case 6
                    Ap0 = op1;
                    Bp0 = op2;
                    ApT = op3;
                    BpT = op4;
                    time0 = op5;
                    timeT = op6;
                    
                    distance0 = Ap0.Distance(Bp0);
                    temp1 = sign(Ap0.X-Bp0.X)*sign(ApT.X-BpT.X);
                    temp2 = sign(Ap0.Y-Bp0.Y)*sign(ApT.Y-BpT.Y);
                    if(temp1+temp2 < 0)
                        distanceT = -1*ApT.Distance(BpT);
                    else
                        distanceT = ApT.Distance(BpT);
                    end
                    
                    this.m = (distance0-distanceT)/(time0-timeT);
                    this.b = -1*this.m*time0+distance0;
                    ...
                otherwise
                error('Ball class: Number of input arguments must be 2 or 4 or 6');
                
            end
        end
        function f = equation(this)
            f = @(t) this.b+this.m*t;
        end
        function f = absequation(this)
            f = @(t) abs(this.b+this.m*t);
        end
        function result = minus(this,other)
            result = Line2(this.m-other.m,(this.b-other.b));
        end
        function results = TfromD(this,d)
            t1 = (d-this.b)/(this.m);
            t2 = (-d-this.b)/(this.m);
            results = [t1;t2];
        end
    end
    
end

