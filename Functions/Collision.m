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
end
t_temp = zeros(1,300)
for i=1:300
    
    sampleTime = c(i+1).time-c(i).time
    
    t = timer('TimerFcn', 'stat=false; disp(''Timer!'')',... 
                 'StartDelay',sampleTime-0.011);
    start(t)
    tic
    X = c(i).ball.Position.X;     
    Y = c(i).ball.Position.Y;
    axis([0, Environment.xLim, 0, Environment.yLim]);
    refreshdata(balli,'caller')
    drawnow;

    waitfor(t)
    t_temp(i)=toc;
end
plot(t_temp)
delete(t);