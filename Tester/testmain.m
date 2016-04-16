
robot1 = Robot(0,50,[1 0],1);
axis([0, Environment.xLim, 0, Environment.yLim]);
viscircles([robot1.Position.X robot1.Position.Y],robot1.Radius)
hold on
plot(Environment.goalPos.X,Environment.goalPos.Y + (Environment.goalLength/2),'X');
plot(Environment.goalPos.X,Environment.goalPos.Y - (Environment.goalLength/2),'X');
goalPosT2 = ([Environment.goalPos.X Environment.goalPos.Y]*Environment.FieldTransform) + ([Environment.xLim Environment.yLim 0]);
goalPosT2 = Vector2(goalPosT2(1),goalPosT2(2))
plot(goalPosT2.X,goalPosT2.Y + (Environment.goalLength/2),'X');
plot(goalPosT2.X,goalPosT2.Y - (Environment.goalLength/2),'X');


