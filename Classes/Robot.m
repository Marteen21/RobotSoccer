classdef Robot < handle
    %ROBOT Summary of this class goes here
    %   Detailed explanation goes here
    properties
        Position;       %Vector2
        Orientation;    %Vector2
        Simulation;     %SimulationData
        Radius;         %Radius of the simulated robot
        Target;         %Target where the robot wants to go
        TargetSpeedTime;
        ControlSignal;
        CollisionSpeed
        Owner;
    end
    
    methods
        function obj = Robot(pX,pY,oX,oY,vX,vY,ownr,colV,mass)
            obj.Radius = 4;
            switch nargin
                case 2
                    obj.Position = Vector2(pX,pY);  %Set position
                case 3
                    obj.Position = Vector2(pX,pY);  %Set position
                    SimulationData.friction(fric);  %Set global friction
                case 5
                    obj.Position = Vector2(pX,pY);  %Set position
                    obj.Simulation = SimulationData (vX,vY,1);%Set speed with default 1 mass
                    obj.Owner = ownr;
                case 6
                    obj.Position = Vector2(pX,pY);  %Set position
                    obj.Simulation = SimulationData (vX,vY,mass);%Set speed
                    obj.Owner = ownr;
                case 7
                    obj.Position = Vector2(pX,pY);  %Set position
                    obj.Orientation = Vector2(oX,oY);
                    obj.Simulation = SimulationData (vX,vY,1);%Set speed with default 1 mass
                    obj.Owner = ownr;
                    obj.Target{1} = Vector2(pX, pY);
                    obj.CollisionSpeed = Vector2(0,0);
%                     obj.Target = [pX, pY];
                case 8
                    obj.Position = Vector2(pX,pY);  %Set position
                    obj.Orientation = Vector2(oX,oY);
                    obj.Simulation = SimulationData (vX,vY,1);%Set speed with default 1 mass
                    obj.Owner = ownr;
                    obj.Target{1} = Vector2(pX, pY);
                    obj.CollisionSpeed = colV;
%                     obj.Target = [pX, pY];
                case 9
                    obj.Position = Vector2(pX,pY);  %Set position
                    obj.Orientation = Vector2(oX,oY);
                    obj.Simulation = SimulationData (vX,vY,mass);%Set speed with default 1 mass
                    obj.CollisionSpeed = Vector2(0,0);
                    obj.Owner = ownr;
                    ...
                otherwise
                error('Robot class: Invalid number of arguments');
            end
        end
        function cTime = CollisionTimeWithXWall(this,xLim)
            nextPositionX = this.Position.X + this.Simulation.Speed.X*SimulationData.sampleTime;
            dist = Line2(Vector2(this.Position.X,0),Vector2(xLim,0),Vector2(nextPositionX,0),Vector2(xLim,0),0,SimulationData.sampleTime);
            cTime = min(dist.TfromD(this.Radius));
            if(cTime < this.Simulation.CollisionTime || isnan(this.Simulation.CollisionTime))
                this.Simulation.CollisionTime = double(cTime);
                this.Simulation.CollisionVector = Vector2([0,1]);
                this.Simulation.SpeedGain = SpeedGains(BodyType.Wall,Vector2([0;0]));
                
            end
        end
        function cTime = CollisionTimeWithYWall(this,yLim)
            nextPositionY = this.Position.Y + this.Simulation.Speed.Y*SimulationData.sampleTime;
            dist = Line2(Vector2(0,this.Position.Y),Vector2(0,yLim),Vector2(0,nextPositionY),Vector2(0,yLim),0,SimulationData.sampleTime);
            cTime = min(dist.TfromD(this.Radius));
            if(cTime < this.Simulation.CollisionTime || isnan(this.Simulation.CollisionTime))
                this.Simulation.CollisionTime = double(cTime);
                this.Simulation.CollisionVector = Vector2([1,0]);
                this.Simulation.SpeedGain = SpeedGains(BodyType.Wall,Vector2([0;0]));
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
                if(~isnan(cTime))
                    this.Simulation.SpeedGain = SpeedGains(BodyType.Robot,r.Simulation.Speed.*0.2);
                else
                    this.Simulation.SpeedGain = SpeedGains(BodyType.None,Vector2([0;0]));
                end
                this.Simulation.CollisionVector = CalculateCollVector(this,r,cTime);
            end
        end
        function cTime = CollisionTimeWithBall(this,r)
            Ap0 = this.Position;
            Bp0 = r.Position;
            ApT = this.Position + this.Simulation.Speed*SimulationData.sampleTime;
            BpT = r.Position + r.Simulation.Speed*SimulationData.sampleTime;
            time0 = 0;
            timeT = SimulationData.sampleTime;
            dist = Line2(Ap0,Bp0,ApT,BpT,time0,timeT);
            cTime = min(dist.TfromD(this.Radius+r.Radius));
            if(cTime < this.Simulation.CollisionTime || isnan(this.Simulation.CollisionTime))
                this.Simulation.CollisionTime = double(cTime);
                if(~isnan(cTime))
                    this.Simulation.SpeedGain = SpeedGains(BodyType.Ball,r.Simulation.Speed*0.2);
                else
                    this.Simulation.SpeedGain = SpeedGains(BodyType.None,Vector2([0;0]));
                end
                this.Simulation.CollisionVector = CalculateCollVector(this,r,cTime);
            end
        end
        function nextRobot = Step(this, cTime)
            colVector = Vector2(0,0);
            nextPositionX = this.Position.X + this.Simulation.Speed.X*cTime;
            nextPositionY = this.Position.Y + this.Simulation.Speed.Y*cTime;
            nextMass = this.Simulation.Mass;
            nextOwner = this.Owner;
            if (isa(this.Simulation.CollisionVector,'Vector2') && cTime == this.Simulation.CollisionTime)
                nextSpeed = this.Simulation.Speed.TotalReflectionFrom(this.Simulation.CollisionVector);
                colVector = nextSpeed;
                %Differencial hajtas oldalso iranyban erkezo utkozes utani
                %elmozdulas kinullazasa
%                 angle_nextSpeed = atan2(nextSpeed.Y,nextSpeed.X);
%                 angle_thisSpeed = atan2(this.Simulation.Speed.Y,this.Simulation.Speed.X);
%                 if (abs(angle_thisSpeed-angle_nextSpeed)>0.2618)
%                     nextSpeed = Vector2(0,0);
%                 end
                %------------
                if(this.Simulation.SpeedGain.collidedWith == BodyType.Wall || this.Simulation.SpeedGain.collidedWith == BodyType.Robot)
                    nextSpeed = nextSpeed.*0.5 + this.Simulation.SpeedGain.gain;
                end
            else
                nextSpeed = Vector2(this.Simulation.Speed.X,this.Simulation.Speed.Y);
            end
            nextRobot = Robot(nextPositionX,nextPositionY,this.Orientation.X, this.Orientation.Y, nextSpeed.X, nextSpeed.Y, nextOwner,colVector, nextMass);
        end
    end
end

