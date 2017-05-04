disp('Setting global static valuables');
SimulationData.friction(0.15);
SimulationData.sampleTime(0.1); %DiffEQ DesiredSpeedTime ezt kell megadni
SimulationData.simSpeed(1);

Environment.xLim(115);
Environment.yLim(74);
Environment.goalPos(0,Environment.yLim/2);
Environment.goalLength(Environment.xLim/10);
