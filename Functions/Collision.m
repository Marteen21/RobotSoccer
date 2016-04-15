%% Outdated methods to calculate the new speed vector after collision, see Vector2.TotalReflectionFrom(this,wall) to see the newer function
% function [ new_orientation ] = Collision( Pos1, Ori1, Pos2, Ori2 )
% %COLLISION Summary of this function goes here
% %   Calculate new orientation from the current orientatoin and position
% P = Rodriguez(0.5*pi)*(Pos1 - Pos2);
% angP = asin((Pos1(1)-Pos2(1))/(sqrt((-(Pos1(2)-Pos2(2)))^2 + (Pos1(1)-Pos2(1))^2)))
% if (Pos1(2) < Pos2(2))
%     theta_new = 2*angP - pi
% else
%     if (Pos1(2) > Pos2(2))
%         theta_new = -1*(2*angP - pi)
%     else
%         theta_new = -pi
%     end
% end
% 
% new_orientation(1) = Rodriguez(theta_new)*Ori1;
% new_orientation(2) = Rodriguez(theta_new)*Ori2;
% 
% end

