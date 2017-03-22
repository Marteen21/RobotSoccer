function ControlSignal = OmniEQ( robot, Target )
%The beta function of omnidirectional robots
%    Gets the speed vectors and the continous orientation rotation changing
%    until the target reached, bumper in the front
%    (celpont elereseig folyamat fordul menet közben)
%    Column 1 : agent Speed
%    Column 2 : Orient
%    Defining a parabolic route if there is an obstacle on the way to the
%    target 
    
    MaxSpeed    = 15;                                           % a robot maximális sebessége
    R           = robot.Radius;                                 % tengelyhossz fele (=fordulási rádiusz)
    ControlNum  = 2;                                            % beav.jel szabadsági fok
    Epsilon     = 10E-4;                                        % numerikus pontossági küszöb az adott robot(típus)hoz ->
    EpsilonTh   = 10E-4;                                        % ezen belül =nek veszünk 2 számot
    
    DeltaX = sqrt((robot.Position.X-Target.X)^2+(robot.Position.Y-Target.Y)^2); % a két pont távolsága
    %Simulation step unit = DesiredSpeedTime
    DesiredSpeedTime = SimulationData.sampleTime; %SimulationData.sampleTime -al kell megegyeznie ennek az idonek, hogy a mi egységünkhöz számolja a távot.
    OrientCurrent = atan2(robot.Orientation.Y,robot.Orientation.X);
    OrientMoveFWD = atan2(robot.Position.Y-Target.Y,robot.Position.X-Target.X); % ez az az orientáció, amikor a célpont irányába állunk az adott helyen
    OrientMoveBWD = atan2(Target.Y-robot.Position.Y,Target.X-robot.Position.X); % ez az az orientáció, amikor a célpontnak háttal állunk az adott helyen
    OrientTarget  = atan2(0,0);%atan2(robot.Orientation.Y,robot.Orientation.X);
    
    if (DeltaX>Epsilon)                             % nem értük még el a pontot
        % itt nem unitokra számolja a forgásokat, így összekumulálódhat egy pici hiba, hogy végül mégsem arra jobb fordulni - de ez pici...
        DeltaThetaFWD = OrientMoveFWD - OrientCurrent;
        DeltaThetaBWD = OrientMoveBWD - OrientCurrent;
        if (abs(DeltaThetaFWD)>pi), DeltaThetaFWD=DeltaThetaFWD-sign(DeltaThetaFWD)*2*pi; end
        if (abs(DeltaThetaBWD)>pi), DeltaThetaBWD=DeltaThetaBWD-sign(DeltaThetaBWD)*2*pi; end
        % Egy rendes orientáció (cos,sin), tehát sum=[1..sqrt2] között van.
        % Ha mégis ==0, az azt jelenti, hogy a célorientáció nem érdekes, vagyis ne foglalkozzon vele, maradjon úgy, ahogy érkezett:
        if ~robot.Simulation.Speed.X && ~robot.Simulation.Speed.Y
            DeltaThetaFWD2=0;
            DeltaThetaBWD2=0;
        else  
            DeltaThetaFWD2 = OrientTarget-OrientMoveFWD;
            DeltaThetaBWD2 = OrientTarget-OrientMoveBWD;
            if (abs(DeltaThetaFWD2)>pi), DeltaThetaFWD2=DeltaThetaFWD2-sign(DeltaThetaFWD2)*2*pi; end
            if (abs(DeltaThetaBWD2)>pi), DeltaThetaBWD2=DeltaThetaBWD2-sign(DeltaThetaBWD2)*2*pi; end
        end
        TotalTurnFWD = abs(DeltaThetaFWD) + abs(DeltaThetaFWD2);
        TotalTurnBWD = abs(DeltaThetaBWD) + abs(DeltaThetaBWD2);
        if TotalTurnFWD > TotalTurnBWD              % ha jobb háttal megközelíteni a célt
            DeltaTheta1 = DeltaThetaBWD;
            DeltaTheta2 = DeltaThetaBWD2;
            backward_multiplier = -1;
        else                                      % ha gazdaságosabb elõre menni
            DeltaTheta1 = DeltaThetaFWD;
            DeltaTheta2 = DeltaThetaFWD2;
            backward_multiplier = 1;
        end

    else                                            % ha elértük a célpontot, de még esetleg fordulni kell
        DeltaX=0;                                   % ha nagyon közel van a ponthoz [~num.hiba], 0-nak tekintjük a távolságot, nem kell odamennie
        DeltaTheta1 = 0;                            % kezdeti forgás nincs
        if ~robot.Simulation.Speed.X && ~robot.Simulation.Speed.Y                          % forgás a célpontban
            DeltaTheta2 = 0;
        else  
            DeltaTheta2 = OrientTarget - OrientCurrent;
            if (abs(DeltaTheta2)>pi), DeltaTheta2=DeltaTheta2-sign(DeltaTheta2)*2*pi; end
        end
        backward_multiplier = 1;
    end

    if (abs(DeltaTheta1)<=EpsilonTh), DeltaTheta1=0; end
    if (abs(DeltaTheta2)<=EpsilonTh), DeltaTheta2=0; end
    
    TimeToTurn1 = R*abs(DeltaTheta1)/MaxSpeed;  % ennyi idöbe telik befordulni a jó irányba [mindig Max sebességgel fordulunk!]
    TimeToTurn2 = R*abs(DeltaTheta2)/MaxSpeed;
    TimeUnitsToTurn1 = ceil(TimeToTurn1);       % kvantálva
    TimeUnitsToTurn2 = ceil(TimeToTurn2);
    TimeUnitsToTurn = TimeUnitsToTurn1 + TimeUnitsToTurn2;
    
    if DesiredSpeedTime<=0                              % ha kívánt idõ volt kódolva
        TimeToGo = -DesiredSpeedTime -TimeUnitsToTurn;  % a fordulás után ennyi idõ marad egyenesen menni
        if TimeToGo<=0                                  % ha a maradék idõ negatív, akkor telítésben van
            Speed = MaxSpeed;
        else                                          % ha a maradék idõ pozitív, valódi -> kikalkuláljuk az ehhez tartozó sebességet
            Speed = DeltaX / TimeToGo;
            if Speed>MaxSpeed, Speed = MaxSpeed; end     % de így is lehet túl rövid az elõírt idõ -> ismét telítés
        end
    else                                              % ha relatív sebesség volt kódolva, alkalmazzuk
        Speed = MaxSpeed * DesiredSpeedTime;
    end
    
    %----------------------------------------------
    %-------Feltetel kell ide hogy egyenes palyarol vagy kerulesrol van-e
    %szo
    %----------------------------------------------

    TimeToGo           = DeltaX/Speed;                  % ennyi idõ (csak) egyenesen odamenni a kívánt/telített sebességgel [/ idõ alatt]
    TimeUnitsToGo      = ceil(TimeToGo);                % max sebességgel ennyi idõegységbe telne egyenesen a célba jutni
    TimeUnitsToPerform = TimeUnitsToTurn + TimeUnitsToGo;% max sebesség + fordulási idõ

    % Default: teljes sebességgel fordul, de az utsó fordulási lépésben csak annyit, amennyit még épp kell:
    LastStepTheta1 = DeltaTheta1 - sign(DeltaTheta1)*(TimeUnitsToTurn1-1)*MaxSpeed/R;
    LastStepTheta2 = DeltaTheta2 - sign(DeltaTheta2)*(TimeUnitsToTurn2-1)*MaxSpeed/R;

    ControlSignal=zeros(TimeUnitsToPerform,ControlNum);
    
    PhaseEnd = TimeUnitsToTurn1 + TimeUnitsToGo;
    %--------------------------------------------------------------------------
    % Egyenesen a célra megy állandó sebességgel és közben fordul
    %--------------------------------------------------------------------------
    if TimeUnitsToGo>0                  % Csak akkor nézzük az egyenes szakaszt, ha egyáltalán van:
        % *(1/DesiredSpeedTime) azert kell mert mashogy
        % ertelmezi az elozo keszito a DesiredSpeedTime
        % erteket, mint ahogy nekem kell.
        ControlSignal(1 : PhaseEnd,1) = Speed*(1/DesiredSpeedTime);
        ControlSignal(1 : PhaseEnd,2) = ceil(LastSzepTheta1/PhaseEnd);
        ControlSignal(PhaseEnd,1) = (DeltaX-(Speed*(TimeUnitsToGo-1)))*(1/DesiredSpeedTime)/MaxSpeed; % utsó lépéssel pont beáll, nem lõ túl
        ControlSignal(PhaseEnd,2) = ceil(LastSzepTheta1/PhaseEnd)-(LastSzepTheta1/PhaseEnd);
    end
    if backward_multiplier==-1, ControlSignal(Phase2Start : Phase2End,1) = -ControlSignal(Phase2Start : Phase2End,1); end % ha háttal megy -> -1xes sebesség
    
end
    