function [ControlSignal,Target,Time] = DefineApproach( Robots,agentIndex,ApproachSequence,P,Q,R,S,K, File )

    DesiredSpeedTime=1;



ControlSignal=[0 0];
Target=Vector2(0,0);
Time=0;
[sor,oszlop]=size(ApproachSequence);
for s=1:sor
    switch ApproachSequence(s,1)
            
        case 'P'
            switch ApproachSequence(s,2)
                case '1'
                    Robots(agentIndex).Target=Vector2(P(1,1),P(1,2));
                case '2'
                    Robots(agentIndex).Target=Vector2(P(2,1),P(2,2));
                case '3'
                    Robots(agentIndex).Target=Vector2(P(3,1),P(3,2));
                case '4'
                    Robots(agentIndex).Target=Vector2(P(4,1),P(4,2));
            end;
        case 'Q'
            switch ApproachSequence(s,2)
                case '1'
                    Robots(agentIndex).Target=Vector2(Q(1,1),Q(1,2));
                case '2'
                    Robots(agentIndex).Target=Vector2(Q(2,1),Q(2,2));
                case '3'
                    Robots(agentIndex).Target=Vector2(Q(3,1),Q(3,2));
                case '4'
                    Robots(agentIndex).Target=Vector2(Q(4,1),Q(4,2));
            end;
        case 'R'
            switch ApproachSequence(s,2)
                case '1'
                    Robots(agentIndex).Target=Vector2(R(1,1),R(1,2));
                case '2'
                    Robots(agentIndex).Target=Vector2(R(2,1),R(2,2));
                case '3'
                    Robots(agentIndex).Target=Vector2(R(3,1),R(3,2));
                case '4'
                    Robots(agentIndex).Target=Vector2(R(4,1),R(4,2));
            end;
        case 'S'
            switch ApproachSequence(s,2)
                case '1'
                    Robots(agentIndex).Target=Vector2(S(1,1),S(1,2));
                case '2'
                    Robots(agentIndex).Target=Vector2(S(2,1),S(2,2));
                case '3'
                    Robots(agentIndex).Target=Vector2(S(3,1),S(3,2));
                case '4'
                    Robots(agentIndex).Target=Vector2(S(4,1),S(4,2));
            end;
        case 'K'
            Robots(agentIndex).Target=Vector2(K);
       
    end;
    [CS, TG, TM] = MoveTo(agentIndex, Robots(agentIndex),Robots(agentIndex).Target, File,'DefineApproach.m');
    ControlSignal = [ControlSignal; CS];
    Target = [Target;TG];
    Time = [Time, TM];
end;
ControlSignal(1,:)=[];
Target(1,:)=[];
Time(1)=[];
end

