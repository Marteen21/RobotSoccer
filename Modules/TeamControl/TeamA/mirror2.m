function Pos = mirror2( Position )
%MIRROR2 Summary of this function goes here
%   Detailed explanation goes here

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                         X irányú korrekció                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Transzformáció a 3€3-as pályára 
if ( Position(1) <= 0 )
    while ( Position(1) <= 0 )
        Position(1)=Position(1)+2*Environment.xLim;
    end;
end;
if ( Position(1) >= Environment.xLim )
    while ( Position(1) >= Environment.xLim )
        Position(1)=Position(1)-2*Environment.xLim;
    end;
end;

%Transzformáció a játéktérre
if ( Position(1) <= 0 ) 
    Pos(1)=-Position(1);
elseif ( Position(1) >= Environment.xLim )
    Pos(1)=2*Environment.xLim-Position(1);
else
    Pos(1) = Position(1);
end;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                         Y irányú korrekció                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Transzformáció a 3€3-as pályára 
if ( Position(2) <= 0 )
    while ( Position(2) <= 0 )
        Position(2)=Position(2)+2*Environment.yLim;
    end;
end;
if ( Position(2) >= Environment.yLim )
    while ( Position(2) >= Environment.yLim )
        Position(2)=Position(2)-2*Environment.yLim;
    end;
end;

%Transzformáció a játéktérre
if ( Position(2) <= 0 ) 
    Pos(2)=-Position(2);
elseif ( Position(2) >= Environment.yLim )
    Pos(2)=2*Environment.yLim-Position(2);
else
    Pos(2)=Position(2);
end;


end

