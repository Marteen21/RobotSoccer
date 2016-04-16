
robot1 = Robot(0,50,[1 0],1);
axis([0, Environment.xLim, 0, Environment.yLim]);
viscircles([robot1.Position.X robot1.Position.Y],robot1.Radius)
hold on
plot(Environment.goalPos.X,Environment.goalPos.Y + (Environment.goalLength/2),'X');
plot(Environment.goalPos.X,Environment.goalPos.Y - (Environment.goalLength/2),'X');

