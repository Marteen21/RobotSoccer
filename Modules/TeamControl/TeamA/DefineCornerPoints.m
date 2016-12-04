function [P,Q,R,S] = DefineCornerPoints(C,T,A,Bounding)

%T transformation: from a world into this co-ordinate system

%Agent in the co-ordinate system of the ball
AgentInBall=T*(A-C)';


%Pivotal points in the co-ordinate system of the ball
P1InBall=[-Bounding      AgentInBall(2)];
P2InBall=[-Bounding      +Bounding];
P3InBall=[AgentInBall(1) +Bounding];
P4InBall=[AgentInBall(1) +Bounding];

Q1InBall=[+Bounding      AgentInBall(2)];
Q2InBall=[+Bounding      +Bounding];
Q3InBall=[AgentInBall(1) +Bounding];
Q4InBall=[AgentInBall(1) +Bounding];

R1InBall=[-Bounding      AgentInBall(2)];
R2InBall=[-Bounding      +Bounding];
R3InBall=[AgentInBall(1) -Bounding];
R4InBall=[AgentInBall(1) -Bounding];

S1InBall=[+Bounding      AgentInBall(2)];
S2InBall=[+Bounding      -Bounding];
S3InBall=[AgentInBall(1) -Bounding];
S4InBall=[AgentInBall(1) -Bounding];


%Pivotal points in the world
P1=(inv(T)*P1InBall'+C')';
P2=(inv(T)*P2InBall'+C')';
P3=(inv(T)*P3InBall'+C')';
P4=(inv(T)*P4InBall'+C')';

Q1=(inv(T)*Q1InBall'+C')';
Q2=(inv(T)*Q2InBall'+C')';
Q3=(inv(T)*Q3InBall'+C')';
Q4=(inv(T)*Q4InBall'+C')';

R1=(inv(T)*R1InBall'+C')';
R2=(inv(T)*R2InBall'+C')';
R3=(inv(T)*R3InBall'+C')';
R4=(inv(T)*R4InBall'+C')';

S1=(inv(T)*S1InBall'+C')';
S2=(inv(T)*S2InBall'+C')';
S3=(inv(T)*S3InBall'+C')';
S4=(inv(T)*S4InBall'+C')';


%Correct format
P=[P1 0 0;P2 0 0;P3 0 0;P4 0 0];
Q=[Q1 0 0;Q2 0 0;Q3 0 0;Q4 0 0];
R=[R1 0 0;R2 0 0;R3 0 0;R4 0 0];
S=[S1 0 0;S2 0 0;S3 0 0;S4 0 0];


end

