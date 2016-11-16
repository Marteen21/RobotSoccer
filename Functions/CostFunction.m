function Cost = CostFunction( Robot, Target )
%COSTFUNCTION Get the cost of going to the target, the farer the target
%the more the cost
%
 distV = abs(Robot.Position-Target.Position);
 if (distV==(Robot.Radius+Target.Radius))
     Cost = 0;
 elseif ( distV > Robot.Radius+Target.Radius)
     Cost = distV;
 else
     Cost = -1;
 end

end

