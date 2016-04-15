classdef Environment
    %ENVIRONMENT Summary of this class goes here
    %   This class stores the data of the environment
    %   length and width of the play field, center postion of the goal
    %   and the width of the goal
    
    properties
    end
    methods (Static)
        function out = xLim(data)   %Static xLim property
            persistent Var
            if nargin
                Var = data;
            end
            out = Var;
        end
        
        function out = yLim(data)   %Static yLim property
            persistent Var
            if nargin
                Var = data;
            end
            out = Var;
        end
        
        function out = goalPos(data)    %Static goalPos property
            persistent Var
            if nargin
                Var = data;
            end
            out = Var;
        end
        
        function out = goalLength(data) %Static goalLength property
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

