classdef Environment
    %ENVIRONMENT Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    methods (Static)
        function out = xLim(data)
            persistent Var
            if nargin
                Var = data;
            end
            out = Var;
        end
        
        function out = yLim(data)
            persistent Var
            if nargin
                Var = data;
            end
            out = Var;
        end
        
        function out = goalPos(data)
            persistent Var
            if nargin
                Var = data;
            end
            out = Var;
        end
        
        function out = goalLength(data)
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

