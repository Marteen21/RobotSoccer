function this = Collision(aX,aY)
    % Collision function
    % gives back the a Robor Postion Time vector nad get the 
    % start point of the robot
    myball = Ball(aX,aY,12,6);

    myState = SimState(0,myball,[]);
    c = [myState];
    hold on
    for i = 1:3000
        c(end+1) = c(end).NextState();
    end
    this = c;
end
