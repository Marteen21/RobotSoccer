myball = Ball(5,5,3,1);
myState = SimState(0,myball,[]);
c = [myState];
plot (0,0,'o');
balli =  plot(0,0,'mo','MarkerFaceColor','m',...
                        'YDataSource','Y',...
                        'XDataSource','X'); 
X = 0;
Y = 0;
%plot (100,100,'o');
hold on
for i = 1:3000
    c(end+1) = c(end).NextState();
    %plot(c(end).ball.Position.X,c(end).ball.Position.Y,'o');
    
end

for i = 1:3000
    X = c(i).ball.Position.X;
    Y = c(i).ball.Position.Y;
    axis([0, Environment.xLim, 0, Environment.yLim]);
    refreshdata(balli,'caller')
    drawnow;
end