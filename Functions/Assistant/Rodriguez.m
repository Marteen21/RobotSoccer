function [ Rotate ] = Rodriguez( theta )
%RODRIGUEZ Summary of this function goes here
%   Rotate a vector with a given theta
Rotate = [cos(theta) -sin(theta);
          sin(theta) cos(theta)];

end

