function defSector( teamAgentA, teamAgentB, ball )
%Defines a sector to each robots
%
    xLim = Environment.xLim;
    yLim = Environment.yLim;
    radius = teamAgentA(1).Radius;
    
    xUnit = 0:xLim/2:xLim;
    yUnit = 0:yLim/3:yLim;
    
    agents = [teamAgentA teamAgentB];
    
    %sector = ones(length(yUnit),length(xUnit));
    %Sector numbers from 1 to 6
    %Sector numbers: e.g.:
    %[ 1  2  3  4  5;
    %  6  7  8  9 10;
    % 11 12 13 14 15]
    secNum = length(xUnit)*length(yUnit);
    xLen = length(xUnit);
    yLen = length(yUnit);
    
    allRob = length(teamAgentA)+length(teamAgentB);
    
    for i = 1:allRob
%         sectorTemp = agents(i).Position;
%         sectorTemp.X = round(sectorTemp.X/xLen);
%         sectorTemp.Y = round(sectorTemp.Y/yLen);
%         
%         agents(i).Sector = (sectorTemp.Y-1)*xLen+sectorTemp.X;
        robPosY = agents(i).Position.Y;
        if (robPosY>yUnit(1) && robPosY<yUnit(2))
            agents(i).Sector = 1;
        elseif (robPosY>yUnit(2) && robPosY<yUnit(3))
            agents(i).Sector = 2;
        else
            agents(i).Sector = 3;
        end
        %agents(i).Sector = [sectorTemp.X, nan, sectorTemp.Y];
    end
%     ball.Sector = (round(ball.Position.Y/yLen)-1)*xLen+round(ball.Position.X/xLen);

    ballPosY = ball.Position.Y;
    if (ballPosY>yUnit(1) && ballPosY<yUnit(2))
        ball.Sector = 1;
    elseif (ballPosY>yUnit(2) && ballPosY<yUnit(3))
        ball.Sector = 2;
    else
        ball.Sector = 3;
    end


end

