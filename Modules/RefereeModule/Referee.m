classdef Referee
    
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
                originalState.ball.Position.X = originalState.ball.Radius;
            elseif (originalState.ball.Position.X > Environment.xLim - originalState.ball.Radius)
                originalState.ball.Position.X = Environment.xLim-originalState.ball.Radius;
            elseif (originalState.ball.Position.Y < 0+originalState.ball.Radius)
                originalState.ball.Position.Y = originalState.ball.Radius;
            elseif (originalState.ball.Position.Y > Environment.yLim - originalState.ball.Radius)
                originalState.ball.Position.Y = Environment.yLim-originalState.ball.Radius;
            end
            fixedState = originalState;
        end
        function [BallReset, RobotReset] = Reset(myBall,myRobots)
            myBall.Position.X = Environment.xLim/2;
            myBall.Position.Y = Environment.yLim/2;
            for i=1:length(myRobots)
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
                Referee.ScoreB(mySimState.time);
%                 disp('<------------------GOAL---------------GO TEAM B------------>');
            elseif (((mySimState.ball.Position.X + mySimState.ball.Radius) >= Environment.xLim-0.1) && (Environment.goalPos.Y-Environment.goalLength/2 <= mySimState.ball.Position.Y) && (mySimState.ball.Position.Y <= Environment.goalPos.Y + Environment.goalLength/2))
                goalState = true;
                Referee.ScoreA(mySimState.time);
%                 disp('<------------------GOAL---------------GO TEAM A------------>');
            else
                goalState = false;
            end
            
        end
    end
    
    methods
        
    end
end