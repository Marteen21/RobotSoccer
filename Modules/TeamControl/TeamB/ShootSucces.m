function success = ShootSucces( dist, alfa, zeta  )
% ShootSuccess returns a probabilistic estimation of a successful shot. 
%   input arguments are:    dist -     distance to the goal (or agent)
%                           alfa -  vision angle (or reach distance of a team mate)
%                           zeta -  number of opponents within the reacheable
%                                   distance on the ball's path
    
    success = ( (1/(1+dist)^2) * alfa/pi + alfa/((1 + dist)*pi) * (1 - alfa/(pi * (1 + dist)^2))) * 1/(1 + zeta);

end

