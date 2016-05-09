function CollisionVector = CalculateCollVector( op1,op2,cTime )
    pos1 = op1.Position+op1.Simulation.Speed.*cTime;
    pos2 = op2.Position+op2.Simulation.Speed.*cTime;
    diff = pos1-pos2;
    CollisionVector = diff.D2NVector();
    if(~isnan(cTime))
        
    end
end