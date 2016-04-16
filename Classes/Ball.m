classdef Ball
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
        function cTime = CollisionTimeWithXWall(this,xLim)
            nextPositionX = this.Position.X + this.Simulation.Speed.X*SimulationData.sampleTime;
            dist = Line2(abs(this.Position.X-xLim),abs(nextPositionX-xLim),0,SimulationData.sampleTime);
            cTime = CollisionData(min(dist.TfromD(this.Radius)),this,Vector2([0,1]));
        end
        function cTime = CollisionTimeWithYWall(this,yLim)
            nextPositionY = this.Position.Y + this.Simulation.Speed.Y*SimulationData.sampleTime;
            dist = Line2(abs(this.Position.Y-yLim),abs(nextPositionY-yLim),0,SimulationData.sampleTime);
            cTime = CollisionData(min(dist.TfromD(this.Radius)),this,Vector2([1,0]));
        end
        
        %         function nextBall = Stepwithoutcollision(this)
        %             cTimes = []
        %             cTimes(end+1) = CollisionTimeWithXWall(this,0);
        %             cTimes(end+1) = CollisionTimeWithYWall(this,0);
        %             cTimes(end+1) = CollisionTimeWithXWall(this,Enviroment.xLim);
        %             cTimes(end+1) = CollisionTimeWithYWall(this,Enviroment.yLim);
        %             if(~this.isColliding(cTimes))   %no collision
        %                 nextPositionX = this.Position.X + this.Simulation.Speed.X*SimulationData.sampleTime;
        %                 nextPositionY = this.Position.Y + this.Simulation.Speed.Y*SimulationData.sampleTime;
        %                 nextSpeedX = this.Simulation.Speed.X;
        %                 nextSpeedY = this.Simulation.Speed.Y;
        %                 nextMass = this.Simulation.Mass;
        %                 nextBall = Ball(nextPositionX,nextPositionY, nextSpeedX, nextSpeedY, nextMass);
        %             else    %collision
        %                 error('Not implemented yet');
        %             end
        %         end
        function nextBall = Stepwithoutcollision(this,time)
            switch nargin
                case 1
                    nextPositionX = this.Position.X + this.Simulation.Speed.X*SimulationData.sampleTime;
                    nextPositionY = this.Position.Y + this.Simulation.Speed.Y*SimulationData.sampleTime;
                case 2
                    nextPositionX = this.Position.X + this.Simulation.Speed.X*time;
                    nextPositionY = this.Position.Y + this.Simulation.Speed.Y*time;
            end
            nextSpeedX = this.Simulation.Speed.X;
            nextSpeedY = this.Simulation.Speed.Y;
            nextMass = this.Simulation.Mass;
            nextBall = Ball(nextPositionX,nextPositionY, nextSpeedX, nextSpeedY, nextMass);
            
        end
        function nextBall = CollideWith(this,cTime,e)
            nextPositionX = this.Position.X + this.Simulation.Speed.X*cTime;
            nextPositionY = this.Position.Y + this.Simulation.Speed.Y*cTime;
            nextSpeed = this.Simulation.Speed.TotalReflectionFrom(e);
            nextMass = this.Simulation.Mass;
            nextBall = Ball(nextPositionX,nextPositionY, nextSpeed.X, nextSpeed.Y, nextMass);
        end
        function nextBall = Collide(this, cData)
            nextPositionX = this.Position.X + this.Simulation.Speed.X*cData.collisionTime;
            nextPositionY = this.Position.Y + this.Simulation.Speed.Y*cData.collisionTime;
            nextMass = this.Simulation.Mass;
            if(cData.colliderA == this)
                nextSpeed = this.Simulation.Speed.TotalReflectionFrom(cData.colliderB);
            elseif(cData.colliderB == this)
                nextSpeed = this.Simulation.Speed.TotalReflectionFrom(cData.colliderA);
            else
                nextSpeed = Vector2(this.Simulation.Speed.X,this.Simulation.Speed.Y);
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

