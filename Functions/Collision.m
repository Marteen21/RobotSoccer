myball = Ball(5,5,3,1);
myState = SimState(0,myball,[]);
c = [myState];
plot (0,0,'o');
plot (100,100,'o');
hold on
for i = 1:6000
    c(end+1) = c(end).NextState();
    plot(c(end).ball.Position.X,c(end).ball.Position.Y,'o');
    if(mod(i,100)==0)
        disp(c(end).ball.Position.X);
    end
end
