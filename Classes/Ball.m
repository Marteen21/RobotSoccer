classdef Ball < handle
    %BALL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Position;       %Vector2
        Simulation;     %SimulationData
        Radius;
    end
    
    methods
        %% Class constructor
        function obj = Ball(pX,pY,vX,vY,mass)
            obj.Radius = 2;
            switch nargin
                case 2
                    obj.Position = Vector2(pX,pY);  %Set position
                case 3
                    obj.Position = Vector2(pX,pY);  %Set position
                    SimulationData.friction(fric);  %Set global friction
                case 4
                    obj.Position = Vector2(pX,pY);  %Set position
                    obj.Simulation = SimulationData (vX,vY,0.01);%Set speed with default 1 mass
                case 5
                    obj.Position = Vector2(pX,pY);  %Set position
                    obj.Simulation = SimulationData (vX,vY,mass);%Set speed
                    ...
                otherwise
                error('Ball class: Invalid number of arguments');
            end
        end
        %% Functions

        function cTime = CollisionTimeWithXWall(this,xLim)
            nextPositionX = this.Position.X + this.Simulation.Speed.X*SimulationData.sampleTime;
%             dist = Line2(abs(this.Position.X-xLim),abs(nextPositionX-xLim),0,SimulationData.sampleTime);
            dist = Line2(Vector2(this.Position.X,0),Vector2(xLim,0),Vector2(nextPositionX,0),Vector2(xLim,0),0,SimulationData.sampleTime);
            cTime = min(dist.TfromD(this.Radius));
            if(cTime < this.Simulation.CollisionTime || isnan(this.Simulation.CollisionTime))
                this.Simulation.CollisionTime = double(cTime);
                this.Simulation.CollisionVector = Vector2([0,1]);
            end
        end
        function cTime = CollisionTimeWithYWall(this,yLim)
            nextPositionY = this.Position.Y + this.Simulation.Speed.Y*SimulationData.sampleTime;
%           dist = Line2(abs(this.Position.Y-yLim),abs(nextPositionY-yLim),0,SimulationData.sampleTime);
            dist = Line2(Vector2(0,this.Position.Y),Vector2(0,yLim),Vector2(0,nextPositionY),Vector2(0,yLim),0,SimulationData.sampleTime);
            cTime = min(dist.TfromD(this.Radius));
            if(cTime < this.Simulation.CollisionTime || isnan(this.Simulation.CollisionTime))
                this.Simulation.CollisionTime = double(cTime);
                this.Simulation.CollisionVector = Vector2([1,0]);
            end
        end
        function cTime = CollisionTimeWithRobot(this,r)
            Ap0 = this.Position;
            Bp0 = r.Position;
            ApT = this.Position + this.Simulation.Speed.*SimulationData.sampleTime;
            BpT = r.Position + r.Simulation.Speed.*SimulationData.sampleTime;
            time0 = 0;
            timeT = SimulationData.sampleTime;
            dist = Line2(Ap0,Bp0,ApT,BpT,time0,timeT);
            cTime = min(dist.TfromD(this.Radius+r.Radius));
            if(cTime < this.Simulation.CollisionTime || isnan(this.Simulation.CollisionTime))
                this.Simulation.CollisionTime = double(cTime);
                this.Simulation.CollisionVector = CalculateCollVector(this,r,cTime);
            end
        end
        function nextBall = Step(this, cTime)
            mySpeed = this.Simulation.Speed.*cTime;
            nextPositionX = this.Position.X + mySpeed.X;
            nextPositionY = this.Position.Y + mySpeed.Y;
            nextMass = this.Simulation.Mass;
            if (isa(this.Simulation.CollisionVector,'Vector2') && cTime == this.Simulation.CollisionTime)
                nextSpeed = this.Simulation.Speed.TotalReflectionFrom(this.Simulation.CollisionVector);
            else
                nextSpeed = Vector2(this.Simulation.Speed.X,this.Simulation.Speed.Y);
            end
            if(norm(nextSpeed.RowForm())<SimulationData.friction)
                nextSpeed = Vector2(0,0);
            else
                nextSpeed = Vector2(nextSpeed.RowForm() / norm(nextSpeed.RowForm())*(norm(nextSpeed.RowForm())-SimulationData.friction*0.05*(0.9+rand/10)));
            end
            nextBall = Ball(nextPositionX,nextPositionY, nextSpeed.X, nextSpeed.Y, nextMass);
        end
        %% Operators
        function result = eq(this,other)
            if (this.Position == other.Position && this.Simulation == other.Simulation && this.Radius == other.Radius)
                result = true;
            else
                result = false;
            end
        end
    end
end

