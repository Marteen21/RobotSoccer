function target = BestTarget( agentIndex, robotsA, robotsB )
%BestTarget function returns the coordinates of the best target for the
%current ball holder to pass (or shoot) to. Decision is made based on the
%coordinates of own and opposite team agents, goal coordinates and the
%result of the Shooting_Success calculation

    persistent counter;

if isempty(counter)
    counter = 0;
end

%global shot_success;
chances = zeros(4, 3); %column - probability, coordinate X, coordinate Y

%global Environment Team M FieldX FieldY qDamp

%agent coordinates
x = robotsA(agentIndex).Position.X;
y = robotsA(agentIndex).Position.Y;



%array of shooting success probabilities


for i = 1: 3 %for now do not pass to the goalie!!! 3 robots + goal
    switch i
        case 1   %pass to the first team mate
            if i ~= agentIndex   %do not pass to yourself

                % team mate coordinates
                x1 = robotsA(i).Position.X;
                y1 = robotsA(i).Position.Y;

                %working value for reach distance - 20, therefore sector angle
                %2 * arctan(a/b) (see the notebook)
                vtarget = [x1, y1] - [x, y];
                angle = atan(30/norm(vtarget));

                dist = Distance(robotsA(agentIndex).Position, robotsA(i).Position);  %distance to the i-th team mate

                number = 0;
                
                for j=1:length(robotsB)
                %for j = 1:3
                    if (strcmp(robotsB(j).Owner,'TeamB'))
                    vopp = [robotsB(j).Position.X robotsB(j).Position.Y] - [x,y];
                    
                    e = vtarget/norm(vtarget);
                    d = dot(vopp, e);
                    beta = acos(d/norm(vopp));
                        if beta <= angle
                            number = number + 1;
                        end
                    end

                end
                chances(1, 1) = ShootSucces(dist, angle, number) - 0.1;
                chances(1, 2) = x1;
                chances(1, 3) = y1;

            end
        case 2   %pass to the second team mate
            if i ~= agentIndex   %do not pass to yourself

                % team mate coordinates
                x1 = robotsA(i).Position.X;
                y1 = robotsA(i).Position.Y;

                %working value for reach distance - 20, therefore sector angle
                %2 * arctan(a/b) (see the notebook)
                vtarget = [x1, y1] - [x, y];
                angle = atan(30/norm(vtarget));

                dist = Distance(robotsA(agentIndex).Position, robotsA(i).Position);  %distance to the i-th team mate

                number = 0;
                for j=1:length(robotsB)
                %for j = 1:3
                    if (strcmp(robotsB(j).Owner,'TeamB'))
                        vopp = [robotsB(j).Position.X robotsB(j).Position.Y] - [x,y];
                        e = vtarget/norm(vtarget);
                        d = dot(vopp, e);
                        beta = acos(d/norm(vopp));
                            if beta <= angle
                                number = number + 1;
                            end
                    end
                end
                chances(2, 1) = ShootSucces(dist, angle, number);
                chances(2, 2) = x1;
                chances(2, 3) = y1;

            end
        case 3   %possibility to score (shoot to the goal)
            % goal coordinates 1 - left, 2 - right goalposts, Mid - middle.
            x1 = Environment.xLim;
            y1 = Environment.goalPos.Y+Environment.goalLength;
            x2 = Environment.xLim;
            y2 = Environment.goalPos.Y-Environment.goalLength;
            xMid = Environment.xLim;
            yMid = Environment.goalPos.Y;

            angle = acos(((x1 - x)*(x2 - x) + (y1 - y)*(y2 - y))/...          %shooting angle
                (sqrt((x1 - x)^2 + (y1 - y)^2)*sqrt((x2 - x)^2 + (y2 - y)^2)));

            dist = Distance(robotsA(agentIndex).Position, Vector2(xMid, yMid));  %distance to the middle of the goal

            number = 0;


            %  slope = (yMid - y)/(xMid - x);          %slope of the shooting line



            %number of opponents inside the shooting sector
            vtarget = [xMid,yMid] - [x,y];
            for j=1:length(robotsB)
                %for j = 1:3
                    if (strcmp(robotsB(j).Owner,'TeamB'))
                        vopp = [robotsB(j).Position.X robotsB(j).Position.Y] - [x,y];
                        e = vtarget/norm(vtarget);
                        d = dot(vopp, e);
                        beta = acos(d/norm(vopp));
                        if beta <= angle
                            number = number + 1;
                        end
                    end
            end
            chances(3, 1) = ShootSucces(dist, angle, number) + 0.1; %artificially increased for more attackness
            chances(3, 2) = xMid;
            chances(3, 3) = yMid;

    end
end
[i, j] = max(chances(:,1));
target = [chances(j,2), chances(j,3)];
    
    
    

end

