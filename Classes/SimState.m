classdef SimState < handle
    %SIMULATOR Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        time;   %float
        ball;   %ball
        robots; %[] robot with k elements
    end
    
    methods
        function obj = SimState(op1, op2, op3)
            obj.time = op1;
            obj.ball = op2;
            obj.robots = op3;
        end
        function nextState = NextState(this)
            bcTimes = [];
            bcTimes(1) = NaN;
            bcTimes(end+1) = this.ball.CollisionTimeWithXWall(0);
            bcTimes(end+1) = this.ball.CollisionTimeWithYWall(0);
            bcTimes(end+1) = this.ball.CollisionTimeWithXWall(Environment.xLim);
            bcTimes(end+1) = this.ball.CollisionTimeWithYWall(Environment.yLim);
            for i = 1 : length(this.robots)
                error('Not yet implemented');
                %tempLine = Line2(this.ball.Position,this.ball.Position+this.ball.Simulation.Speed.*SimulationData.sampleTime,this.robots(i).Position,this.robots(i).Position+this.robots(i).Simulation.Speed.*SimulationData.sampleTime,0,SimulationData.sampleTime);
                %bcTimes(end+1) = tempLine.TfromD(this.ball.Radius+this.robots(i).Radius);
            end
            collisionHappened = false;
            nextCollisionTime = SimulationData.sampleTime*2;
            for j = 1 : length(bcTimes)
                if(~isnan(bcTimes(j)) && nextCollisionTime > bcTimes(j) && bcTimes(j)>0)
                    nextCollisionTime = bcTimes(j);
                    collisionHappened = true;
                end
            end
            if(collisionHappened)
                nextT = this.time+nextCollisionTime;
                nextB = this.ball.Step(nextCollisionTime);
                nextR = [];
                for i = 1 : length(this.robots)
                    error('Not yet implemented');
                end
            else
                nextT = this.time+SimulationData.sampleTime;
                nextB = this.ball.Step(SimulationData.sampleTime);
                nextR = [];
                for i = 1 : length(this.robots)
                    error('Not yet implemented');
                end
            end
            nextState = SimState(nextT, nextB, nextR);
        end
    end
end

