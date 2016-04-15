classdef Ball
    %BALL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Position;       %Vector2
        Simulation;     %SimulationData
    end
    
    methods
        %% Class constructor
        function obj = Ball(pX,pY,vX,vY,mass)
            switch nargin
                case 2
                    obj.Position = Vector2(pX,pY);  %Set position
                case 3
                    obj.Position = Vector2(pX,pY);  %Set position
                    SimulationData.friction(fric);  %Set global friction
                case 4
                    obj.Position = Vector2(pX,pY);  %Set position
                    obj.Simulation = SimulationData (vX,vY,1);%Set speed with default 1 mass
                case 5
                    obj.Position = Vector2(pX,pY);  %Set position
                    obj.Simulation = SimulationData (vX,vY,mass);%Set speed
                    ...
                otherwise
                error('Ball class: Invalid number of arguments');
                
            end
        end
        %% Functions
        function isCollided = isColliding(this)
            isCollided = false;
        end
        function nextBall = Step(this)
            if(~this.isColliding)   %no collision
                nextPositionX = this.Position.X + this.Simulation.Speed.X*SimulationData.sampleTime;
                nextPositionY = this.Position.Y + this.Simulation.Speed.Y*SimulationData.sampleTime;
                nextSpeedX = this.Simulation.Speed.X;   
                nextSpeedY = this.Simulation.Speed.Y;
                nextMass = this.Simulation.Mass;
                nextBall = Ball(nextPositionX,nextPositionY, nextSpeedX, nextSpeedY, nextMass);
            else    %collision
                error('Not implemented yet');
            end
        end
    end
end

