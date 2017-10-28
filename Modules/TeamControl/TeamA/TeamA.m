classdef TeamA
    %TEAMA Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods (Static)
        function [ControlSignal, Target] = controlMyState(originalState,Cost,File,teamAgentA,teamAgentB)
            %originalState.ball.Simulation.Speed
            eMinDist = 99;
            eMinRob = [];
            dist = [];
            goalShot = GoalShot;
            MIN = 5*10E6;
            MaxSpeed = 15;
            for i=1:length(originalState.robots)
                if(strcmp(originalState.robots(i).Owner,'TeamA'))
                    if Cost(i)<MIN
                        MIN = Cost(i);
                    end
                else
                    dist = [dist round(abs(originalState.robots(i).Position))];
                    temp = min(dist);
                    if (temp<eMinDist)
                        eMinDist = temp;
                        eMinRob = originalState.robots(i);
                    end
                end
            end
            distToBall = Cost;
            %originalState.robots and robotsB first element is the robotindex
            
            %--------HLS implementation with fuzzy--------
            bestShot(3, 2) = 0;
            kickAble(3, 1) = 0;
            if (originalState.ball.Simulation.Speed.RowForm() ~= [0 0])
                ballSpeed = abs(Vector2(originalState.ball.Simulation.Speed.RowForm()));
            else
                ballSpeed = abs(originalState.ball.Simulation.Speed);
            end
            
            %probably the Kickability is not even needed....................
            fuz = readfis('kickAbility');
            for i = 1:length(teamAgentA)
                bestShot(i,:) = BestTarget(i, teamAgentA, teamAgentB);
                kickAble(i, 1) = evalfis([distToBall(1, i) ballSpeed], fuz);
            end
            %fuzzy system assigns a position for each team member depending on the role
            %(permanent assignment for now - defender, midfielder and attacker.
            %output is x, y position.
            fuz = readfis('Formation');
            for i = 1:3
                formation(i, 1:2) = evalfis([(i/3 - 0.1) originalState.ball.Position.X originalState.ball.Position.Y], fuz);
            end
            %formation 1: Offense; 2: defense; 3: middle;
            DesiredPlace{1} = [ bestShot(1,:) formation(1,:)];
            DesiredPlace{2} = [ bestShot(2,:) formation(3,:)];
            limit = 2*teamAgentA(3).Radius;
            if formation(2,1)>limit
                if formation(2,2)>Environment.goalPos.Y+Environment.goalLength/2+2*limit
                    DesiredPlace{3} = [ bestShot(3,:), limit,Environment.goalPos.Y+Environment.goalLength/2+2*limit];
                    if formation(2,2)<Environment.goalPos.Y-Environment.goalLength/2-2*limit
                        DesiredPlace{3} = [ bestShot(3,:), limit,Environment.goalPos.Y-Environment.goalLength/2-2*limit];
                    end
                else
                    DesiredPlace{3} = [ bestShot(3,:), limit,formation(2,2)];
                end
            else
                DesiredPlace{3} = [ bestShot(3,:) formation(2,:)];
            end
            %Situation with fuzzy logic
            fuz = readfis('Situation'); %if the .fis file is empty MATAB freezes THX
            SituationFuzz = evalfis([originalState.ball.Simulation.Speed.X originalState.ball.Position.X],fuz);
            if SituationFuzz > 0
                Situation = 'offense';
            else
                Situation = 'hidefense';
            end
            %if offensive - use fuzzy logic for role assignment and BestTarget for
            %pass/shoot decision
            %if defensive - use Reacheable, try to intercept the ball and prevent
            %opponent from scoring
            
            %Defining the appropiate sector for each robot
            defSector(teamAgentA,teamAgentB,originalState.ball);
            %Fuzzy:
            %fuzzy gets 3 inputs (MiddlePlayer's sector number, AttackPlayer's sector number
            %Enemy's BaseSector) Two outputs are the roles of the middle
            %and the attack player.
            OffDef = 0;
            switch Situation
                case 'offense'
                    OffDef = 0;
%                     DesiredPlace{1}(3:4) = ;
%                     DesiredPlace{2}(3:4) = ;
                    for agentIndex = 1:(length(teamAgentA)-1)
                                
%                         CS0=zeros(CycleBatch,2);

                        DesiredSpeedTime=1;
                        
                        if (distToBall(agentIndex)==MIN)
                            fuz = readfis('Strategy'); %if the .fis file is empty MATAB freezes THX
                            StrategyFuzz = evalfis([OffDef,originalState.ball.Sector,eMinRob.Sector,teamAgentA(agentIndex).Sector],fuz);
                            switch StrategyFuzz
                                case 1
                                    %Shoot
                                    Target{agentIndex} = GoalShot.shotToGoal(teamAgentA(agentIndex),originalState.ball);
                                case 2
                                    %pass
                                    Target{agentIndex}=Pass(teamAgentA(agentIndex),teamAgentA(agentIndex+1),originalState.ball);
                                case 3
                                    %Dribbling
                                    Target{agentIndex}=Dribbling(teamAgentA(agentIndex),originalState.ball,originalState.robots);
                                otherwise
                                    Target{agentIndex}=originalState.ball.Position;
                            end
                        else
                            
                            switch agentIndex
                                case 1
                                    Target{agentIndex} = Vector2(86.25, 55.5);
                                case 2
                                    Target{agentIndex} = Vector2(86.25, 18.5);
                            end
                                    
                        end
                        
                        %closest to the ball gets to attack (for now)
                        % if (kickAble(agentIndex) == max(kickAble) && max(kickAble) > 0.5) %what should be this number??? probability of successful kick..
%                         if (distToBall(agentIndex)==MIN)&&(distToBall(agentIndex)<15)% && distToBall(agentIndex) < 10)
%                             %[ControlSignal{agentIndex} ,Target{agentIndex}]= haromszog(agentIndex,originalState.robots,originalState.ball,DesiredPlace{agentIndex},MaxSpeed,File);
%                             if (inTheWay(teamAgentA(agentIndex),originalState.ball))
%                                 %Target{agentIndex} = GoalShot(teamAgentA(agentIndex),originalState.ball);
%                                 Target{agentIndex}=Vector2(DesiredPlace{agentIndex}(3:4));
% %                                 if agentIndex==1
% %                                     tempTarget2 = Pass(teamAgentA(agentIndex),teamAgentA(agentIndex+1), originalState.ball);
% %                                     if tempTarget2.X==-1
% %                                         Target{agentIndex}=Vector2(DesiredPlace{agentIndex}(3:4));
% %                                     else
% %                                         Target{agentIndex} = tempTarget2;
% %                                     end
% %                                 else
% %                                     tempTarget3 = Pass(teamAgentA(agentIndex),teamAgentA(agentIndex-1), originalState.ball);
% %                                     if tempTarget3.X==-1
% %                                         Target{agentIndex}=Vector2(DesiredPlace{agentIndex}(3:4));
% %                                     else
% %                                         Target{agentIndex} = tempTarget3;
% %                                     end
% %                                 end
%                             else
%                                 %Target{agentIndex}=Pass(teamAgentA(agentIndex),teamAgentA(agentIndex+1),originalState.ball);
%                                 tempTarget = goalShot.shotToGoal(teamAgentA(agentIndex),originalState.ball);
%                                 if tempTarget.X==-1
%                                     Target{agentIndex}=Vector2(DesiredPlace{agentIndex}(3:4));
%                                 else
%                                     Target{agentIndex} = tempTarget;
%                                 end
%                             end
%                         else
%                             if (inTheWay(teamAgentA(agentIndex),originalState.ball))
%                                 %The ball is towards our goal
%                                 Target{agentIndex}=Vector2(DesiredPlace{agentIndex}(3:4));
%                                 %Target{agentIndex}=Pass(teamAgentA(agentIndex),teamAgentA(agentIndex+1),originalState.ball);
%                             else
%                                 if inTheWay(teamAgentA(agentIndex),originalState.ball,originalState.robots)
%                                     %Target{agentIndex} = ball.Position;
%                                     %Target{agentIndex} = Vector2(DesiredPlace{agentIndex}(3:4)+[0 15]);
%                                     if (originalState.ball.Speed < 5 )
%                                         Target{agentIndex}=originalState.ball.Position;
%                                     else
%                                         tempTarget=Pass(teamAgentA(agentIndex),teamAgentA(agentIndex+1),originalState.ball);
%                                         if tempTarget.X==-1
%                                             Target{agentIndex}=Vector2(DesiredPlace{agentIndex}(3:4));
%                                         else
%                                             Target{agentIndex} = tempTarget;
%                                         end
%                                     end
%                                 else
%                                     %Noone is in the way so make a goalshot
%                                     %Target{agentIndex} = GoalShot(teamAgentA(agentIndex),originalState.ball);
%                                     Target{agentIndex} = Vector2(DesiredPlace{agentIndex}(3:4)+[0 15]);
%                                 end
%                             end
                             
                            %[CS,teamAgentA(agentIndex).Target{agentIndex},teamAgentA(agentIndex).TargetSpeedTime]= getControls(agentIndex,originalState.robots,DesiredSpeedTime);
                            %Moving to the target, added agentIndex for the
                            %logFile, 
                            %[ControlSignal{agentIndex}, Target{agentIndex}, TargetSpeedTime]  = getControls(teamAgentA(agentIndex), Target{agentIndex});
                            %End of moving
                            
%                         end
                        [ControlSignal{agentIndex}, Target{agentIndex}, TargetSpeedTime]  = getControls(teamAgentA(agentIndex), Target{agentIndex});
                    end
                    agentIndex = 3;
                    DesiredSpeedTime = 1;
                    Target{agentIndex}=Vector2(teamAgentA(agentIndex).Radius+2,Environment.yLim/2);
                    [ControlSignal{agentIndex}, Target{agentIndex}, TargetSpeedTime]  = getControls(teamAgentA(agentIndex), Target{agentIndex});
                  case 'hidefense'
                        %agent 3 - defence
%                       DesiredPlace{1}(3:4) = ;
%                       DesiredPlace{2}(3:4) = ;
                        agentIndex = 3;
                        DesiredSpeedTime = 1;
                        target = Goalie(originalState.ball,teamAgentA(agentIndex).Radius);
                        if target > 0
                            if distToBall(agentIndex) <= 5
                                Target{agentIndex}=originalState.ball.Position;
                            else
                                Target{agentIndex}=Vector2(target);
                            end
                        else
                            Target{agentIndex}=Vector2(teamAgentA(agentIndex).Radius,Environment.yLim/2);
                        end
                        OffDef = 1;
                        %Moving to the target
                        %teamAgentA(agentIndex).Simulation.Speed = getControls(agentIndex, teamAgentA(agentIndex),teamAgentA(agentIndex).Target{agentIndex}, File,'TeamA.m hidefense');
                        [ControlSignal{agentIndex}, Target{agentIndex}, TargetSpeedTime] = getControls(teamAgentA(agentIndex),Target{agentIndex});
                        

                        for agentIndex = 1:(length(teamAgentA)-1)
                            %closest to the ball gets to attack (for now)
                            % if (kickAble(agentIndex) == max(kickAble) && max(kickAble) > 0.5) %what should be this number??? probability of successful kick..
                            
                            if (distToBall(agentIndex)==MIN)
                                fuz = readfis('Strategy'); %if the .fis file is empty MATAB freezes THX
                                StrategyFuzz = evalfis([OffDef,originalState.ball.Sector,eMinRob.Sector,teamAgentA(agentIndex).Sector],fuz);
                                switch StrategyFuzz
                                    case 1
                                        %Shoot
                                        Target{agentIndex} = GoalShot.shotToGoal(teamAgentA(agentIndex),originalState.ball);
                                    case 2
                                        %pass
                                        Target{agentIndex}=Pass(teamAgentA(agentIndex),teamAgentA(agentIndex+1),originalState.ball);
                                    case 3
                                        %Dribbling
                                        Target{agentIndex}=Dribbling(teamAgentA(agentIndex),originalState.ball,originalState.robots);
                                    otherwise
                                        Target{agentIndex}=originalState.ball.Position;
                                end
                            else
                                switch agentIndex
                                    case 1
                                        Target{agentIndex} = Vector2(28.75, 55.5);
                                    case 2
                                        Target{agentIndex} = Vector2(28.75, 18.5);
                                end

                            end
                        [ControlSignal{agentIndex}, Target{agentIndex}, TargetSpeedTime]  = getControls(teamAgentA(agentIndex), Target{agentIndex});
                            
                            
%                             if (distToBall(agentIndex)==MIN)
%                                 %try to shoot to the enemy goal
%                                 %Target{agentIndex} = GoalShot(teamAgentA(agentIndex), originalState.ball);
%                                 Target{agentIndex}=Vector2(DesiredPlace{agentIndex}(1:2));
%                                 [ControlSignal{agentIndex}, Target{agentIndex}, TargetSpeedTime]  = getControls(teamAgentA(agentIndex), Target{agentIndex});
%                                 %[ControlSignal{agentIndex},Target{agentIndex}, TargetSpeedTime]=haromszog(agentIndex,originalState.robots,originalState.ball,DesiredPlace{agentIndex},MaxSpeed,File);
%                             else
%                                 Target{agentIndex}=Vector2(DesiredPlace{agentIndex}(3:4));
%                                 [ControlSignal{agentIndex}, Target{agentIndex}, TargetSpeedTime]  = getControls(teamAgentA(agentIndex), Target{agentIndex});
%                             end
                        end
            end
            %originalState.ball.Simulation.Speed
            %controlledState = originalState;
%             fprintf(File,'Time: %d \n',originalState.time);
%             fprintf(File,'RobotPos: %d_%d \n',teamAgentA(1).Position.X, teamAgentA(1).Position.Y);
%             fprintf(File,'Target{agentIndex}: %d_%d \n',Target{agentIndex}.X, Target{agentIndex}.Y);
%             fprintf(File,'RobotSpeed: %d_%d \n\n', teamAgentA(1).Simulation.Speed.X, teamAgentA(1).Simulation.Speed.Y);
        end
        
        function [controlledState, ControlSignal] = calculateControls(originalState, ControlSignal, Target, File, teamAgentA)
            
            for i=1:length(teamAgentA)
%                 teamAgentA(i).Simulation.Speed = Vector2(0,0);
                teamAgentA(i).Target = Target(i);
                if ~(isempty(ControlSignal{i}))
                    switch ControlSignal{i}(1,1)
                        case 0
                            teamAgentA(i).Simulation.Speed = Vector2(0,0);
                            %teamAgentA(k).Simulation.Speed = Vector2(0,0);
                            %Orientation change, 
                            rotOri = atan2(teamAgentA(i).Orientation.Y,teamAgentA(i).Orientation.X)+ControlSignal{i}(1,2);
                            targetOri = Target{i}-teamAgentA(i).Position;
                            targetOri = Vector2(targetOri.RowForm()/norm(targetOri.RowForm()));
                            
%                             fprintf(File,'Agens: %d\n',i);
%                             [temp_s temp_o] = size(ControlSignal{i});
%                             fprintf(File,'ControlSignal size in rotation: %d\n\n',temp_s);
%                             fprintf(File,'DiffEQ rot value: %d\n',ControlSignal{i}(1,2));
%                             fprintf(File,'Rotation Orientation: %d\n',rotOri);
%                             fprintf(File,'Old Orientation: %d__%d\n',teamAgentA(i).Orientation.X,teamAgentA(i).Orientation.Y);
%                             if (abs(rotOri)>pi)
%                                rotOri=rotOri-sign(rotOri)*2*pi; 
%                             end
                            teamAgentA(i).Orientation.X = cos(rotOri);
                            teamAgentA(i).Orientation.Y = sin(rotOri);
                            
                            
%                             fprintf(File,'New Orientatoin: %d__%d\n',teamAgentA(i).Orientation.X,teamAgentA(i).Orientation.Y);
%                             fprintf(File,'Real Orientatoin: %d__%d\n\n',targetOri.X,targetOri.Y);
                        otherwise
                            %Speed change
%                             desiredSpeed = MoveTo(teamAgentA(i).Orientation,ControlSignal{i}(1,1));
                            fprintf(File,'Agens: %d\n',i);
                            [temp_s temp_o] = size(ControlSignal{i});
                            fprintf(File,'ControlSignal size in speed: %d\n',temp_s);
%                             fprintf(File,'CollisionDetect X:%d   Y:%d\n\n',teamAgentA(k).CollisionSpeed.X,teamAgentA(k).CollisionSpeed.Y);
                            
                            if ControlSignal{i}(1,2) ~= 0
%                                 DiffOri = ControlSignal{i}(1,2) - atan2(teamAgentA(i).Orientation.Y,teamAgentA(i).Orientation.X);
                                    DiffOri = ControlSignal{i}(1,2) - atan2(teamAgentA(i).Orientation.Y,teamAgentA(i).Orientation.X);
                                    DiffOri = 0.0873 * sign(DiffOri);
                                    rotOri = atan2(teamAgentA(i).Orientation.Y,teamAgentA(i).Orientation.X) + DiffOri;
                                    teamAgentA(i).Orientation.X = cos(rotOri);
                                    teamAgentA(i).Orientation.Y = sin(rotOri);
                                    
                                    desiredSpeed = MoveTo(teamAgentA(i).Orientation,ControlSignal{i}(1,1));
                                    teamAgentA(i).Simulation.Speed = Vector2((-1)*sign(ControlSignal{i}(1,1))*desiredSpeed.RowForm());
                                
                            else
                                if any(teamAgentA(i).CollisionSpeed == Vector2(0,0))
                                    desiredSpeed = MoveTo(teamAgentA(i).Orientation,ControlSignal{i}(1,1));
                                    teamAgentA(i).Simulation.Speed = Vector2((-1)*sign(ControlSignal{i}(1,1))*desiredSpeed.RowForm());
                                else
                                    teamAgentA(i).Simulation.Speed = collisionDetect;
                                end
                            end
%                             fprintf(File,'Agens: %d\n',i);
%                             fprintf(File,'ControlSingalom: %d\n',size(ControlSignal{i}));
%                             fprintf(File,'Sebesseget adok:%d_%d\n\n',teamAgentA(i).Simulation.Speed.X,teamAgentA(i).Simulation.Speed.Y);
                    end
                ControlSignal{i}(1,:) = [];
                else
                    fprintf(File,'ControlSignal is empty...WTF\n\n');
                    teamAgentA(i).Simulation.Speed = Vector2(0,0);
                end
            end
            
            controlledState = originalState;
        end
    end
end

