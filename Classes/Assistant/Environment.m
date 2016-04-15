classdef Environment
    %ENVIRONMENT Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        xLim;
        yLim;
        goalPos;
        goalLength;
    end
    methods (Static)
        function [xLim yLim goalPos goalLength] = CreatField(in_xLim, in_yLim, in_goalPos, in_goalLength)
            persistent t_xlim t_ylim t_gP t_gL
            if (nargin == 4)
                t_xlim = in_xLim;
                t_ylim = in_yLim;
                t_gP = in_goalPos;
                t_gL = in_goalLength;
            end
            xLim = t_xlim;
            yLim = t_ylim;
            goalPos = t_gP;
            goalLength = t_gL;
        end
    end
    methods
    end
    
end

