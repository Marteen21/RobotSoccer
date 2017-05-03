 function [Sector,T] = DefineSector( Origin,Orientation,Position,Width )
%DEFINESECTOR Summary of this function goes here
%   Detailed explanation goes here



x=Orientation(1);
y=Orientation(2);
if ((x==0) && (y==0))
    x=1;
    y=0;
end


x=x/sqrt(x^2+y^2);
y=y/sqrt(x^2+y^2);

    
    
%Transzfonrmációs matrix (from a world into this co-ordinate system)
T=inv([x -y; y x]);


%The situation of a dot in the co-ordinate system
Point=T*(Position(1:2)-Origin(1:2))';


if (Point(2)>=Width)
    if (Point(1)<-Width)
        Sector=1;
    elseif ( (Point(1)>=-Width) && (Point(1)<0) )
        Sector=2;
    elseif ( (Point(1)>=0) && (Point(1)<Width) )
        Sector=3;
    else 
        Sector=4;
    end;

elseif ( (Point(2)<Width) && (Point(2)>=0) )
    if (Point(1)<-Width)
        Sector=5;
    elseif ( (Point(1)>=-Width) && (Point(1)<0) )
        Sector=6;
    elseif ( (Point(1)>=0) && (Point(1)<Width) )
        Sector=7;
    else 
        Sector=8;
    end;

elseif ( (Point(2)<0) && (Point(2)>=-Width) )
    if (Point(1)<-Width)
        Sector=9;
    elseif ( (Point(1)>=-Width) && (Point(1)<0) )
        Sector=10;
    elseif ( (Point(1)>=0) && (Point(1)<Width) )
        Sector=11;
    else 
        Sector=12;
    end;
   
elseif (Point(2)<-Width)
    if (Point(1)<-Width)
        Sector=13;
    elseif ( (Point(1)>=-Width) && (Point(1)<0) )
        Sector=14;
    elseif ( (Point(1)>=0) && (Point(1)<Width) )
        Sector=15;
    else 
        Sector=16;
    end;
end;

end

