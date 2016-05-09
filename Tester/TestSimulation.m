Initializer;
SimulationData.sampleTime(0.1);
myball = Ball(20,20,10,10);
myrobot = Robot(30,28,0,0,'TeamA');
myrobot2 = Robot(10,10,0,0,'TeamB');
myState = SimState(0,myball,[myrobot,myrobot2]);
data = Simulate(myState, 300);
disp('LUL');