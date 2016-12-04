function [OutSpeed,Target] = DefineApproach( Robots,agentIndex,ApproachSequence,P,Q,R,S,K )

    DesiredSpeedTime=1;



OutSpeed=[0 0];
Target=[0 0 0 0];
Time=0;
[sor,oszlop]=size(ApproachSequence);
for s=1:sor
    switch ApproachSequence(s,1)
            
        case 'P'
            switch ApproachSequence(s,2)
                case '1'
                    Robots(agentIndex).Target=P(1,:);
                case '2'
                    Robots(agentIndex).Target=P(2,:);
                case '3'
                    Robots(agentIndex).Target=P(3,:);
                case '4'
                    Robots(agentIndex).Target=P(4,:);
            end;
        case 'Q'
            switch ApproachSequence(s,2)
                case '1'
                    Robots(agentIndex).Target=Q(1,:);
                case '2'
                    Robots(agentIndex).Target=Q(2,:);
                case '3'
                    Robots(agentIndex).Target=Q(3,:);
                case '4'
                    Robots(agentIndex).Target=Q(4,:);
            end;
        case 'R'
            switch ApproachSequence(s,2)
                case '1'
                    Robots(agentIndex).Target=R(1,:);
                case '2'
                    Robots(agentIndex).Target=R(2,:);
                case '3'
                    Robots(agentIndex).Target=R(3,:);
                case '4'
                    Robots(agentIndex).Target=R(4,:);
            end;
        case 'S'
            switch ApproachSequence(s,2)
                case '1'
                    Robots(agentIndex).Target=S(1,:);
                case '2'
                    Robots(agentIndex).Target=S(2,:);
                case '3'
                    Robots(agentIndex).Target=S(3,:);
                case '4'
                    Robots(agentIndex).Target=S(4,:);
            end;
        case 'K'
            Robots(agentIndex).Target=K;
       
    end;
    tempTarget = Vector2(Robots(agentIndex).Target(1), Robots(agentIndex).Target(1));
    Speed = MoveTo(Robots(agentIndex),tempTarget);
    TG = Robots(agentIndex).Target;
    OutSpeed = Speed.RowForm();
    Target = TG;
end;
%Target(1,:)=[];


end

