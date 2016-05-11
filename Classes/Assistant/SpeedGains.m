classdef SpeedGains
    %SPEEDGAINS Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        collidedWith;
        gain;
    end
    
    methods
        function this = SpeedGains(cw,g)
            this.collidedWith = cw;
            this.gain = g;
        end
    end
    
end

