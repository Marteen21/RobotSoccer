myball = Ball(5,5,3,1);
myState = SimState(0,myball,[]);
c = [myState];
plot (0,0,'o');
plot (100,100,'o');
hold on
for i = 1:3000
    c(end+1) = c(end).NextState();
    plot(c(end).ball.Position.X,c(end).ball.Position.Y,'o');
end
