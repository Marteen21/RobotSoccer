function [ ControlSignal, Target, Time] = haromszog( agentIndex, Robots, Ball, DesiredPlace, AgentVelocity, File )
%HAROMSZOG
%function produces a control signal for the specified agent to kick the
%ball to the desired place?

%Get parameters
AgentVelocityLim = 15;
Ax=Robots(agentIndex).Position.X;
Ay=Robots(agentIndex).Position.Y;
A=[Ax Ay];
Bx=Ball.Position.X;
By=Ball.Position.Y;
B=[Bx By];
Dx=DesiredPlace(1);
Dy=DesiredPlace(2);
D=[Dx Dy];
Destination=DesiredPlace(3:4);
Vx=Ball.Simulation.Speed.X;
Vy=Ball.Simulation.Speed.Y;
V=[Vx Vy];

q=SimulationData.friction;
m=Ball.Simulation.Mass;
M=Robots(agentIndex).Simulation.Mass;    
BallRadius=Ball.Radius;
AgentRadius=Robots(agentIndex).Radius;
Radius=(1+10^-13)*(BallRadius+AgentRadius);


%Allithato parameterek
DesiredSpeedTime=1;

PossibleTimes=[1:20 22:2:50 55:5:100 110:10:200 220:20:400]; %MI EZ???

PSR=[0.001:0.001:0.01 0.015:0.005:0.1 0.2:0.1:1];
Bounding=0.9*Radius;


kick=0;



%MIERT KELL 65x LEFUTNIA??????
for j=1:length(PossibleTimes)

    i=PossibleTimes(j);
    
    %The situation of a ball the utkozes pillanataban
    Cx=Bx+Vx*(1-(1-q)^i)/q;
    Cy=By+Vy*(1-(1-q)^i)/q;
    C=[Cx Cy];
    %C=mirror2(C);
    
    %Labda sebessege az utkozes pillanataban
    vx1=Vx*(1-q)^i;
    vy1=Vy*(1-q)^i;                           %It would be necessary to reflect this
    
    %The proportion of the velocities of a ball after a collision
    DVX=D(1)-C(1);
    DVY=D(2)-C(2);
    
    %The examination of possible kicks
    [AgentVelocity,wx1,wy1]=DefineVelocity(PSR,m,M,vx1,vy1,DVX,DVY,AgentVelocityLim);
    
    %An agent's collisional dot
    Kx=C(1)-Radius*wx1/AgentVelocity;
    Ky=C(2)-Radius*wy1/AgentVelocity;
    K=[Kx Ky];
    K=mirror2(K);
    K=[K wx1 wy1];
    
    
    %The definition of sectors
    [AgentSector,T]=DefineSector(C,[vx1,vy1],A,Radius);                          %Origin, directions, dot, width
    [KickSector,T]=DefineSector(C,[vx1,vy1],K,Radius);                           %Origin, directions, dot, width
       
    %The definition of the pivotal points of an approach
    ApproachSequence=DefineApproachSequence(AgentSector,KickSector);
    
    %Defining pivotal points
    [P,Q,R,S]=DefineCornerPoints(C,T,A,Bounding);          %Origin, transformation, agent, width
    
    
    
    %Let us abridge if we are on a good side
    NormalVector=K(1:2)-C(1:2);
    AgentVector=A(1:2)-K(1:2);
    side=NormalVector(1)*AgentVector(1)+NormalVector(2)*AgentVector(2);
    if (side>0)
        ApproachSequence='K0';
    end;
     
    
    
    %Approach
    [ControlSignal,Target,Time]=DefineApproach(Robots,agentIndex,ApproachSequence,P,Q,R,S,K,File);
    
    NeedTime=sum(Time);


    if (AgentVelocity>AgentVelocityLim)
        NeedTime=1000;
    end;

    %If available, we kick it then
    if ( NeedTime<i )
        %ControlSignal;
%         ControlSignal=[ControlSignal ; zeros(i-sum(Time),2)];
        TargetNew = Vector2(K(1)+wx1, K(2)+wy1);
        %[CS,TG,TM]=FUN.moveTo(agentIndex,TeamOwn,AgentVelocity);
        CS=[AgentVelocity 0];
        TG=TargetNew;
        TM=1;
        ControlSignal=[ControlSignal;CS];
        %Target=[TargetNew; TG];
        Target = TG;
%         Time
        Time = [Time,TM];
        Time = sum(Time);
        
        kick=1;
        return;
    end;
end;


%If he was not can be kicked, we send it then onto his place
if (kick==0)
    Target = Vector2(Destination(1), Destination(2));
    [ControlSignal, Target, Time] = MoveTo(agentIndex, Robots(agentIndex),Target, File,'haromszog.m');
end;


end

