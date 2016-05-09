Initializer;
SimulationData.sampleTime(0.1);
myball = Ball(20,20,12,6);
myrobot = Robot(50,50,5,-5);
myrobot2 = Robot(10,10,2,-2);
myState = SimState(0,myball,[myrobot,myrobot2]);
data = Simulate(myState, 100);
disp('LUL');