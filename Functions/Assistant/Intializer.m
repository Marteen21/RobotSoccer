disp('Setting global static valuables');
SimulationData.friction(0);
SimulationData.sampleTime(0.1);
Environment.set_xLim(100);
Environment.set_yLim(100);
Environment.set_goalPos([0 50]);
Environment.set_goalLength(20);