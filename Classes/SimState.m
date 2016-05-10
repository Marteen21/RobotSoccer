classdef SimState < handle
    %SIMULATOR Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        time;   %float
        ball;   %ball
        robots; %[] robot with k elements
        disableCol;
    end
    
    methods
        function obj = SimState(op1, op2, op3, op4)
            switch nargin
                case 3
                    obj.time = op1;
                    obj.ball = op2;
                    obj.robots = op3;
                    obj.disableCol = false;
                case 4
                    obj.time = op1;
                    obj.ball = op2;
                    obj.robots = op3;
                    obj.disableCol = op4;
            end
                    
            end
            function nextState = NextState(this)
                bcTimes = [];
                bcTimes(1) = NaN;
                bcTimes(end+1) = this.ball.CollisionTimeWithXWall(0);
                bcTimes(end+1) = this.ball.CollisionTimeWithYWall(0);
                bcTimes(end+1) = this.ball.CollisionTimeWithXWall(Environment.xLim);
                bcTimes(end+1) = this.ball.CollisionTimeWithYWall(Environment.yLim);
                for i = 1 : length(this.robots)
                    bcTimes(end+1) = this.robots(i).CollisionTimeWithXWall(0);
                    bcTimes(end+1) = this.robots(i).CollisionTimeWithYWall(0);
                    bcTimes(end+1) = this.robots(i).CollisionTimeWithXWall(Environment.xLim);
                    bcTimes(end+1) = this.robots(i).CollisionTimeWithYWall(Environment.yLim);
                    bcTimes(end+1) = this.ball.CollisionTimeWithRobot(this.robots(i));
                    for j = 1: length(this.robots)
                        if (j ~= i)
                            bcTimes(end+1) = this.robots(i).CollisionTimeWithRobot(this.robots(j));
                        end
                    end
                end
                collisionHappened = false;
                nextCollisionTime = SimulationData.sampleTime*2;
                disp(this.disableCol);
                for j = 1 : length(bcTimes)
                    if(~isnan(bcTimes(j)) && nextCollisionTime > bcTimes(j) && bcTimes(j)>0.001)% &&) %~this.disableCol)
                        nextCollisionTime = bcTimes(j);
                        collisionHappened = true;
                    end
                end
                if(collisionHappened)
                    nextT = this.time+nextCollisionTime;
                    %Referee in progress
                    goal = Referee.isGoal(this);
                    if (goal)
                        [nextB, nextR] = Referee.Reset(this.ball,this.robots)
                    else
                        nextB = this.ball.Step(nextCollisionTime);
                        nextR = Robot.empty;
                        
                        for i = 1 : length(this.robots)
                        nextR(i) = this.robots(i).Step(nextCollisionTime);
                        end
                    end
                    
                else
                    nextT = this.time+SimulationData.sampleTime;
                    goal = Referee.isGoal(this);
                    if (goal)
                        [nextB, nextR] = Referee.Reset(this.ball,this.robots);
                    else
                        nextB = this.ball.Step(SimulationData.sampleTime);
                        nextR = Robot.empty;
                     for i = 1 : length(this.robots)
                         nextR(i) = this.robots(i).Step(SimulationData.sampleTime);
                     end
                    end
                end
                nextState = SimState(nextT, nextB, nextR, collisionHappened);
            end
        end
    end
    
