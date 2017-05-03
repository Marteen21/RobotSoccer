classdef TeamB
    %TEAMB Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods (Static)
        function [ControlSignal, Target] = controlMyState( originalState,Cost,teamAgentA,teamAgentB)
            %originalState.ball.Simulation.Speed
            min = 5*10E6;
            MaxSpeed = 15;
            for i=1:length(originalState.robots)
                if(strcmp(originalState.robots(i).Owner,'TeamB'))
                    if Cost(i)<min
                        min = Cost(i);
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
            for i = 1:length(teamAgentB)
                bestShot(i,:) = BestTarget(i, teamAgentB, teamAgentA);
                kickAble(i, 1) = evalfis([distToBall(1, i) ballSpeed], fuz);
            end
            %fuzzy system assigns a position for each team member depending on the role
            %(permanent assignment for now - defender, midfielder and attacker.
            %output is x, y position.
            fuz = readfis('FormationB');
            for i = 1:3
                formation(i, 1:2) = evalfis([(i/3 - 0.1) originalState.ball.Position.X originalState.ball.Position.Y], fuz);
            end
            %formation 1: Offense; 2: defense; 3: middle;
            DesiredPlace{1} = [ bestShot(1,:) formation(1,:)];
            DesiredPlace{2} = [ bestShot(2,:) formation(3,:)];
            DesiredPlace{3} = [ bestShot(3,:) formation(2,:)];
            %!!!!!crude situation estimation. use fuzzy logic rules or simply think about
            %better way of deciding. At least come up with buffer, so that the roles
            %are not changed all the time.
%             fuz = readfis('Situation'); %if the .fis file is empty MATAB freezes THX
%             SituationFuzz = evalfis([originalState.ball.Simulation.Speed.X originalState.ball.Position.X],fuz);
%             if SituationFuzz > 0
%                 Situation = 'defense';
%             else
%                 Situation = 'offense';
%             end
            if originalState.ball.Simulation.Speed.X <= 0 && originalState.ball.Position.X < 50
                Situation = 'offense';
            else
                Situation = 'defense';
            end;
            
            switch Situation
                case 'offense'
                    Target{1} = originalState.ball.Position;
                    Target{2} = Vector2(DesiredPlace{2}(3:4));
                    Target{3} = originalState.ball.Position;
                    ControlSignal{1,1} = DifferentialEQ(teamAgentB(1),Target{1});
                    ControlSignal{1,2} = DifferentialEQ(teamAgentB(2),Target{2});
                    ControlSignal{1,3} = DifferentialEQ(teamAgentB(3),Target{3});
                case 'defense'
                    Target{1} = originalState.ball.Position;
                    Target{2} = Vector2(DesiredPlace{2}(3:4));
                    Target{3} = Vector2(DesiredPlace{3}(3:4));
                    ControlSignal{1,1} = DifferentialEQ(teamAgentB(1),Target{1});
                    ControlSignal{1,2} = DifferentialEQ(teamAgentB(2),Target{2});
                    ControlSignal{1,3} = DifferentialEQ(teamAgentB(3),Target{3});
            end
            
            
            
            
            
            
            
            
            
            
            
%             for i=1:length(originalState.robots)
%                 if(strcmp(originalState.robots(i).Owner,'TeamB'))
%                     %targetSpeed = originalState.robots(i).Position-originalState.ball.Position+Vector2([rand-0.5;rand-0.5]);
%                     targetSpeed = originalState.robots(i).Position-originalState.ball.Position;
%                     targetSpeed = Vector2(targetSpeed.RowForm()/norm(targetSpeed.RowForm())* 15);
%                     diffSpeed = originalState.robots(i).Simulation.Speed-targetSpeed;
%                     diffSpeed = Vector2(diffSpeed.RowForm()/norm(diffSpeed.RowForm())* SimulationData.sampleTime* 10);
%                     originalState.robots(i).Simulation.Speed = originalState.robots(i).Simulation.Speed + diffSpeed;
%                     if norm(originalState.robots(i).Simulation.Speed.RowForm()) >= 15
%                         originalState.robots(i).Simulation.Speed = Vector2(originalState.robots(i).Simulation.Speed.RowForm()/ norm(originalState.robots(i).Simulation.Speed.RowForm())*15);
%                     end
%                     
%                     
%                     %Orientation pointing at the target all the time
%                     if (cross([originalState.robots(i).Simulation.Speed.X,originalState.robots(i).Simulation.Speed.Y,0],[originalState.robots(i).Orientation.X,originalState.robots(i).Orientation.Y,0])==0)
%                         if norm(originalState.robots(i).Simulation.Speed.RowForm()) >= 15
%                             originalState.robots(i).Simulation.Speed = Vector2(originalState.robots(i).Simulation.Speed.RowForm()/ norm(originalState.robots(i).Simulation.Speed.RowForm())*15);
%                         end
%                     else % Differential type robot have to rotate before moving
%                         originalState.robots(i).Orientation = Vector2(-1*(targetSpeed.RowForm())/norm(targetSpeed.RowForm()));
%                     end
%                 end
%             end
%             
% 
%             controlledState = originalState;
%         end
%     end
    
        end


        function [controlledState, ControlSignal] = calculateControls(originalState, ControlSignal, Target, File, teamAgentB)
            
            for i=1:length(teamAgentB)
%                 teamAgentA(i).Simulation.Speed = Vector2(0,0);
                teamAgentB(i).Target = Target(i);
                if ~(isempty(ControlSignal{i}))
                    switch ControlSignal{i}(1,1)
                        case 0
                            teamAgentB(i).Simulation.Speed = Vector2(0,0);
                            %teamAgentA(k).Simulation.Speed = Vector2(0,0);
                            %Orientation change, 
                            rotOri = atan2(teamAgentB(i).Orientation.Y,teamAgentB(i).Orientation.X)+ControlSignal{i}(1,2);
                            targetOri = Target{i}-teamAgentB(i).Position;
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
                            teamAgentB(i).Orientation.X = cos(rotOri);
                            teamAgentB(i).Orientation.Y = sin(rotOri);
                            
                            
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
                                    DiffOri = ControlSignal{i}(1,2) - atan2(teamAgentB(i).Orientation.Y,teamAgentB(i).Orientation.X);
                                    DiffOri = 0.0873 * sign(DiffOri);
                                    rotOri = atan2(teamAgentB(i).Orientation.Y,teamAgentB(i).Orientation.X) + DiffOri;
                                    teamAgentB(i).Orientation.X = cos(rotOri);
                                    teamAgentB(i).Orientation.Y = sin(rotOri);
                                    
                                    desiredSpeed = MoveTo(teamAgentB(i).Orientation,ControlSignal{i}(1,1));
                                    teamAgentB(i).Simulation.Speed = Vector2((-1)*sign(ControlSignal{i}(1,1))*desiredSpeed.RowForm());
                                
                            else
                                if any(teamAgentB(i).CollisionSpeed == Vector2(0,0))
                                    desiredSpeed = MoveTo(teamAgentB(i).Orientation,ControlSignal{i}(1,1));
                                    teamAgentB(i).Simulation.Speed = Vector2((-1)*sign(ControlSignal{i}(1,1))*desiredSpeed.RowForm());
                                else
                                    teamAgentB(i).Simulation.Speed = collisionDetect;
                                end
                            end
%                             fprintf(File,'Agens: %d\n',i);
%                             fprintf(File,'ControlSingalom: %d\n',size(ControlSignal{i}));
%                             fprintf(File,'Sebesseget adok:%d_%d\n\n',teamAgentA(i).Simulation.Speed.X,teamAgentA(i).Simulation.Speed.Y);
                    end
                ControlSignal{i}(1,:) = [];
                else
                    fprintf(File,'ControlSignal is empty...WTF\n\n');
                    teamAgentB(i).Simulation.Speed = Vector2(0,0);
                end
            end
            
            controlledState = originalState;
        end
    end
end

        
        
