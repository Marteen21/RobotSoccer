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
        function out = set_xLim(data)
            persistent Var
            if nargin
                Var = data;
            end
            out = Var;
        end
        
        function out = set_yLim(data)
            persistent Var
            if nargin
                Var = data;
            end
            out = Var;
        end
        
        function out = set_goalPos(data)
            persistent Var
            if nargin
                Var = data;
            end
            out = Var;
        end
        
        function out = set_goalLength(data)
            persistent Var
            if nargin
                Var = data;
            end
            out = Var;
        end
    end
    methods
    end
    
end

