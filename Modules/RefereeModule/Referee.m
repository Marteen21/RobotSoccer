function fixedState = Referee( originalState)
        for i=1:length(originalState.robots)
            realD = originalState.ball.Position.Distance(originalState.robots(i).Position);
            imD = originalState.ball.Radius+originalState.robots(i).Radius;
            if(realD<imD)
                originalState.ball.Position = originalState.robots(i).Position+(originalState.robots(i).Position-originalState.ball.Position).*-(imD/realD);               
            end
        end
        if(originalState.ball.Position.X < 0+originalState.ball.Radius)
            originalState.ball.Position.X = originalState.ball.Radius;
        elseif (originalState.ball.Position.X > Environment.xLim - originalState.ball.Radius)
            originalState.ball.Position.X = Environment.xLim-originalState.ball.Radius;
        elseif (originalState.ball.Position.Y < 0+originalState.ball.Radius)
            originalState.ball.Position.Y = originalState.ball.Radius;
        elseif (originalState.ball.Position.Y > Environment.yLim - originalState.ball.Radius)
            originalState.ball.Position.Y = Environment.yLim-originalState.ball.Radius;
        end
        fixedState = originalState;
end