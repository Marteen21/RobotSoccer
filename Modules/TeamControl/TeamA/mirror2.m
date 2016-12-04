function Pos = mirror2( Position )
%MIRROR2 Summary of this function goes here
%   Detailed explanation goes here

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                         X irányú korrekció                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Transzformáció a 3€3-as pályára 
if ( Position(1) <= 0 )
    while ( Position(1) <= 0 )
        Pos(1)=Position(1)+2*FieldX;
    end;
end;
if ( Position(1) >= FieldX )
    while ( Position(1) >= FieldX )
        Pos(1)=Position(1)-2*FieldX;
    end;
end;

%Transzformáció a játéktérre
if ( Position(1) <= 0 ) 
    Pos(1)=-Position(1);
elseif ( Position(1) >= FieldX )
    Pos(1)=2*FieldX-Position(1);
end;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                         Y irányú korrekció                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Transzformáció a 3€3-as pályára 
if ( Position(2) <= 0 )
    while ( Position(2) <= 0 )
        Pos(2)=Position(2)+2*FieldY;
    end;
end;
if ( Position(2) >= FieldY )
    while ( Position(2) >= FieldY )
        Pos(2)=Position(2)-2*FieldY;
    end;
end;

%Transzformáció a játéktérre
if ( Position(2) <= 0 ) 
    Pos(2)=-Position(2);
elseif ( Position(2) >= FieldY )
    Pos(2)=2*FieldY-Position(2);
end;


end

