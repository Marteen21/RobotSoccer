classdef SimulationData
    %SIMULATIONDATA Class to assist Simulations
    %   This class is used to store the speed on each simulated robot and
    %   the ball, furthermore it stores the environment values such as
    %   friction, drag etc as a static property (implemented as static
    %   method, due to matlab restrictions)
    properties
        goalPos;    %Vector2 property to store the position of the goal
        goalLength; %Length of the goal
        xLim;       %the "length" of the field
        yLim;       %the "width" of the field
        Speed;      %Vector2 property to store Speed X and Speed Y values
        Mass;       %Scalar propery to store Mass value
    end
    
    methods (Static)
        function out = friction(data)   %Static Friction property
            persistent Var;
            if nargin
                Var = data;
            end
            out = Var;
        end
        function out = sampleTime(data)   %Static Friction property
            persistent Var;
            if nargin
                Var = data;
            end
            out = Var;
        end
    end
    methods
        %Class constructor
<<<<<<< Updated upstream
        function this = SimulationData(xLim,yLim,goalPos_x,goalPos_y,goalLength)   
            switch nargin
                
%                 case 2 
%                     this.Speed = Vector2(aX,aY);
                case 5
                    this.goalPos = Vector2(goalPos_x,goalPos_y);
                    this.xLim = xLim;
                    this.yLim = yLim;
                    this.goalLength = goalLength;
                    ...
                otherwise
                    error('Parameter list not good ');
            end
        end
        %Creating the environment
        function CreatField(this)
           axis([0,this.xLim,0,this.yLim]);
           plot(this.goalPos.X, this.goalPos.Y - (this.goalLength/2), 'O');
           hold on
           plot(this.goalPos.X, this.goalPos.Y + (this.goalLength/2), 'O');
           axis([0,this.xLim,0,this.yLim]);
        end
        
        
=======
        function this = SimulationData(aX,aY,aMass)   
            this.Speed = Vector2(aX,aY);
            this.Mass = aMass;
        end
>>>>>>> Stashed changes
    end
    
end

