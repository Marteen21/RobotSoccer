classdef CollisionData
    %COLLISIONDATA Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        collisionTime;
        colliderA;
        colliderB;
    end
    
    methods
        function obj = CollisionData(cT,cA,cB)
            switch nargin
                case 1
                    obj.collisionTime = NaN;
                case 3
                    obj.collisionTime = cT;
                    obj.colliderA = cA;
                    obj.colliderB = cB;
            end
        end
    end
    
end

