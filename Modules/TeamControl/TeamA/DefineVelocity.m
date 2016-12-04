function [AgentVelocity, wx1, wy1] = DefineVelocity(PSR,m,M,vx1,vy1,DVX,DVY,AgentVelocityLim)
%DEFINEVELOCITY Summary of this function goes here
%   Detailed explanation goes here

AgentVelocity=AgentVelocityLim+1;
wx1=AgentVelocityLim+1;
wy1=AgentVelocityLim+1;


for a=1:length(PSR)
    
    
    vx2=PSR(a)*DVX;
    vy2=PSR(a)*DVY;

    
    wx1_a=-1/2*(vx1^2*M*vx2-m*vx2^3+m*vx1*vy1^2+m*vx1*vy2^2-m*vx2*vy1^2-m*vx2*vy2^2-vy1^2*M*vx1+vy1^2*M*vx2-3*m*vx1^2*vx2+3*m*vx1*vx2^2+vx2^2*M*vx1+vy2^2*M*vx1-vy2^2*M*vx2-vx1^3*M+m*vx1^3-2*m*vx1*vy1*vy2+2*m*vx2*vy1*vy2-vx2^3*M)/M/(vx1^2-2*vx1*vx2+vy2^2+vy1^2+vx2^2-2*vy1*vy2);
    wy1_a=-1/2*(m*vx1^2-vx1^2*M-2*m*vx1*vx2+m*vy1^2-vy1^2*M+m*vy2^2+vx2^2*M+vy2^2*M+m*vx2^2-2*m*vy1*vy2)*(vy1-vy2)/M/(vx1^2-2*vx1*vx2+vy2^2+vy1^2+vx2^2-2*vy1*vy2);
        
    AgentVelocity_a=sqrt(wx1_a^2+wy1_a^2);
     
    if ( ( AgentVelocity_a <= AgentVelocityLim ) )
        AgentVelocity=AgentVelocity_a;
        wx1=wx1_a;
        wy1=wy1_a;
    end;
end;


end

