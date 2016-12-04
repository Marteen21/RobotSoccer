function ApproachSequence = DefineApproachSequence( AgentSector,KickSector )
%DEFINEAPPROACHSEQUENCE Summary of this function goes here
%   Detailed explanation goes here

switch KickSector
    case 1
        Honnan='HAT';
    case 2
        Honnan='HAT';
    case 3
        Honnan='HET';
    case 4
        Honnan='HET';
    case 5
        Honnan='HAT';
    case 6
        Honnan='HAT';
    case 7
        Honnan='HET';
    case 8
        Honnan='HET';
    case 9
        Honnan='TIZ';
    case 10
        Honnan='TIZ';
    case 11
        Honnan='TEG';
    case 12
        Honnan='TEG';
    case 13
        Honnan='TIZ';
    case 14
        Honnan='TIZ';
    case 15
        Honnan='TEG';
    case 16
        Honnan='TEG';        
end;
        



switch Honnan
    
    case 'HAT'
        switch AgentSector
            case 1
                ApproachSequence=['K0'];
            case 2
                ApproachSequence=['P2';'K0'];                
            case 3
                ApproachSequence=['P2';'K0'];
            case 4
                ApproachSequence=['P2';'K0'];
            case 5
                ApproachSequence=['P4';'P2';'K0'];
            case 6
                ApproachSequence=['P3';'P2';'K0'];
            case 7
                ApproachSequence=['Q3';'P2';'K0'];
            case 8
                ApproachSequence=['Q2';'P2';'K0'];
            case 9
                ApproachSequence=['P4';'P2';'K0'];
            case 10
                ApproachSequence=['R1';'P2';'K0'];
            case 11
                ApproachSequence=['S1';'Q2';'P2';'K0'];
            case 12
                ApproachSequence=['Q2';'P2';'K0'];
            case 13
                ApproachSequence=['S2';'Q2';'P2';'K0'];                
            case 14
                ApproachSequence=['S2';'Q2';'P2';'K0'];
            case 15
                ApproachSequence=['S2';'Q2';'P2';'K0'];
            case 16
                ApproachSequence=['Q2';'P2';'K0'];                
        end;

    case 'HET'
        switch AgentSector
            case 1
                ApproachSequence=['Q2';'K0'];
            case 2
                ApproachSequence=['Q2';'K0'];                
            case 3
                ApproachSequence=['Q2';'K0'];
            case 4
                ApproachSequence=['K0'];
            case 5
                ApproachSequence=['P4';'Q2';'K0'];
            case 6
                ApproachSequence=['P3';'Q2';'K0'];
            case 7
                ApproachSequence=['Q2';'K0'];
            case 8
                ApproachSequence=['Q2';'K0'];
            case 9
                ApproachSequence=['R4';'S2';'Q2';'K0'];
            case 10
                ApproachSequence=['R3';'S2';'Q2';'K0'];
            case 11
                ApproachSequence=['S1';'Q2';'K0'];
            case 12
                ApproachSequence=['Q2';'K0'];
            case 13
                ApproachSequence=['S2';'Q2';'K0'];                
            case 14
                ApproachSequence=['S2';'Q2';'K0'];
            case 15
                ApproachSequence=['S2';'Q2';'K0'];
            case 16
                ApproachSequence=['Q2';'K0'];                
        end;
        
    case 'TIZ'
        switch AgentSector
            case 1
                ApproachSequence=['Q2';'S2';'R2';'K0'];
            case 2
                ApproachSequence=['Q2';'S2';'R2';'K0'];                
            case 3
                ApproachSequence=['Q2';'S2';'R2';'K0'];
            case 4
                ApproachSequence=['S2';'R2';'K0'];
            case 5
                ApproachSequence=['R4';'R2';'K0'];
            case 6
                ApproachSequence=['P3';'Q2';'S2';'R2';'K0'];
            case 7
                ApproachSequence=['Q1';'S2';'R2';'K0'];
            case 8
                ApproachSequence=['S2';'R2';'K0'];
            case 9
                ApproachSequence=['R4';'R2';'K0'];
            case 10
                ApproachSequence=['R2';'K0'];
            case 11
                ApproachSequence=['S3';'R2';'K0'];
            case 12
                ApproachSequence=['S3';'R2';'K0'];
            case 13
                ApproachSequence=['K0'];                
            case 14
                ApproachSequence=['R2';'K0'];
            case 15
                ApproachSequence=['R2';'K0'];
            case 16
                ApproachSequence=['R2';'K0'];                
        end;
        
    case 'TEG'
        switch AgentSector
            case 1
                ApproachSequence=['Q2';'S2';'K0'];
            case 2
                ApproachSequence=['Q2';'S2';'K0'];                
            case 3
                ApproachSequence=['Q2';'S2';'K0'];
            case 4
                ApproachSequence=['S2';'K0'];
            case 5
                ApproachSequence=['P4';'Q2';'S2';'K0'];
            case 6
                ApproachSequence=['P3';'Q2';'S2';'K0'];
            case 7
                ApproachSequence=['Q1';'S2';'K0'];
            case 8
                ApproachSequence=['S2';'K0'];
            case 9
                ApproachSequence=['R4';'S2';'K0'];
            case 10
                ApproachSequence=['R3';'S2';'K0'];
            case 11
                ApproachSequence=['S2';'K0'];
            case 12
                ApproachSequence=['S2';'K0'];
            case 13
                ApproachSequence=['S2';'K0'];                
            case 14
                ApproachSequence=['S2';'K0'];
            case 15
                ApproachSequence=['S2';'K0'];
            case 16
                ApproachSequence=['K0'];
        
       end;

end;


end

