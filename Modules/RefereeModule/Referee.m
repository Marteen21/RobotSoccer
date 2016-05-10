classdef Referee < handle
    
    properties
        
    end
    methods (Static)
        function [out] = ScoreA(data)
            persistent Var
            if nargin
                Var(end+1) = data;
            end
            out = Var;
        end
        function [out] = ScoreB(data)
            persistent Var
            if nargin
                Var(end+1) = data;
            end
            out = Var;
        end
        function fixedState = fixMyState( originalState)
            for i=1:length(originalState.robots)
                realD = originalState.ball.Position.Distance(originalState.robots(i).Position);
                imD = originalState.ball.Radius+originalState.robots(i).Radius;
                if(realD<imD)
                    originalState.ball.Position = originalState.robots(i).Position+(originalState.robots(i).Position-originalState.ball.Position).*-(imD/realD);
                end
            end
            if(originalState.ball.Position.X < 0+originalState.ball.Radius)
                originalState.ball.Position.X = originalState.ball.Radius*1.1;
            elseif (originalState.ball.Position.X > Environment.xLim - originalState.ball.Radius)
                originalState.ball.Position.X = Environment.xLim-originalState.ball.Radius*1.1;
            elseif (originalState.ball.Position.Y < 0+originalState.ball.Radius)
                originalState.ball.Position.Y = originalState.ball.Radius*1.1;
            elseif (originalState.ball.Position.Y > Environment.yLim - originalState.ball.Radius)
                originalState.ball.Position.Y = Environment.yLim-originalState.ball.Radius*1.1;
            end
            for j=1:length(originalState.robots)
                for i=1:length(originalState.robots)
                    if(i~=j)
                        realD = originalState.robots(j).Position.Distance(originalState.robots(i).Position);
                        imD = originalState.robots(j).Radius+originalState.robots(i).Radius;
                        if(realD<imD)
                            originalState.robots(j).Position = originalState.robots(i).Position+(originalState.robots(i).Position-originalState.robots(j).Position).*-(imD/realD);
                        end
                    end
                end
                if(originalState.robots(j).Position.X < 0+originalState.robots(j).Radius)
                    originalState.robots(j).Position.X = originalState.robots(j).Radius*1.1;
                elseif (originalState.robots(j).Position.X > Environment.xLim - originalState.robots(j).Radius)
                    originalState.robots(j).Position.X = Environment.xLim-originalState.robots(j).Radius*1.1;
                elseif (originalState.robots(j).Position.Y < 0+originalState.robots(j).Radius)
                    originalState.robots(j).Position.Y = originalState.robots(j).Radius*1.1;
                elseif (originalState.robots(j).Position.Y > Environment.yLim - originalState.robots(j).Radius)
                    originalState.robots(j).Position.Y = Environment.yLim-originalState.robots(j).Radius*1.1;
                end
            end
            fixedState = originalState;
        end
        function [BallReset, RobotReset] = Reset(myBall,myRobots)
            myBall.Position.X = Environment.xLim/2;
            myBall.Position.Y = Environment.yLim/2;
            myBall.Simulation.Speed = Vector2([0,0]);
            for i=1:length(myRobots)
                myRobots(i).Simulation.Speed = Vector2([0,0]);
                if (strcmp(myRobots(i).Owner,'TeamA'))
                    myRobots(i).Position.X = Environment.xLim/2 - 2*myRobots(i).Radius;
                    myRobots(i).Position.Y = Environment.yLim/2;
                else
                    myRobots(i).Position.X = Environment.xLim/2 + 2*myRobots(i).Radius;
                    myRobots(i).Position.Y = Environment.yLim/2;
                end
            end
            BallReset = myBall;
            RobotReset = myRobots;
        end
        
        function goalState = isGoal(mySimState)
            if (((mySimState.ball.Position.X - mySimState.ball.Radius) <= 0.1) && (Environment.goalPos.Y-Environment.goalLength/2 <= mySimState.ball.Position.Y) && (mySimState.ball.Position.Y <= Environment.goalPos.Y + Environment.goalLength/2))
                goalState = true;
                mySimState.teamScore(2)=mySimState.teamScore(2)+1;
                Referee.ScoreB(mySimState.time);
                %                 disp('<------------------GOAL---------------GO TEAM B------------>');
            elseif (((mySimState.ball.Position.X + mySimState.ball.Radius) >= Environment.xLim-0.1) && (Environment.goalPos.Y-Environment.goalLength/2 <= mySimState.ball.Position.Y) && (mySimState.ball.Position.Y <= Environment.goalPos.Y + Environment.goalLength/2))
                goalState = true;
                Referee.ScoreA(mySimState.time);
                mySimState.teamScore(1)=mySimState.teamScore(1)+1;
                %                 disp('<------------------GOAL---------------GO TEAM A------------>');
            else
                goalState = false;
            end
        end
    end
    
    methods
        
    end
end