classdef TeamA
    %TEAMA Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods (Static)
        function controlledState = controlMyState( originalState)
            for i=1:length(originalState.robots)
                if(strcmp(originalState.robots(i).Owner,'TeamA'))
                    %targetSpeed = originalState.robots(i).Position-(originalState.ball.Position+Vector2([rand-0.5;rand-0.5]));
                    targetSpeed = originalState.robots(i).Position-(originalState.ball.Position);
                    targetSpeed = Vector2(targetSpeed.RowForm()/norm(targetSpeed.RowForm())* 15);
                    diffSpeed = originalState.robots(i).Simulation.Speed-targetSpeed;
                    diffSpeed = Vector2(diffSpeed.RowForm()/norm(diffSpeed.RowForm())* SimulationData.sampleTime* 10);
                    originalState.robots(i).Simulation.Speed = originalState.robots(i).Simulation.Speed + diffSpeed;
                    
                    if norm(originalState.robots(i).Simulation.Speed.RowForm()) >= 15
                        originalState.robots(i).Simulation.Speed = Vector2(originalState.robots(i).Simulation.Speed.RowForm()/ norm(originalState.robots(i).Simulation.Speed.RowForm())*15);
                    end
                    
                    %---------------------------------
                    %------FintA Differential EQ------
                    
                    MaxSpeed    = 15;                                           % a robot maximális sebessége
                    R           = originalState.robots(i).Radius;               % tengelyhossz fele (=fordulási rádiusz)
                    ControlNum  = 2;                                            % beav.jel szabadsági fok
                    Epsilon     = 10E-6;                                        % numerikus pontossági küszöb az adott robot(típus)hoz ->
                    EpsilonTh   = 10E-6;                                        % ezen belül =nek veszünk 2 számot
                    %Pontos megválasztása kérdéses a mi esetünkben
                    DesiredSpeedTime = 0;%1;

                    DeltaX = sqrt((originalState.robots(i).Position.X-originalState.ball.Position.X)^2+(originalState.robots(i).Position.Y-originalState.ball.Position.Y)^2); % a két pont távolsága
                    % A jelenlegi orientáció-hiba: eltérés a következõ pontba mutató iránytól:
                    OrientCurrent = atan2(originalState.ball.Simulation.Speed.Y,originalState.ball.Simulation.Speed.X);
                    OrientMoveFWD = atan2(originalState.robots(i).Position.Y-originalState.ball.Position.Y,originalState.robots(i).Position.X-originalState.ball.Position.X); % ez az az orientáció, amikor a célpont irányába állunk az adott helyen
                    OrientMoveBWD = atan2(originalState.ball.Position.Y-originalState.robots(i).Position.Y,originalState.ball.Position.X-originalState.robots(i).Position.X); % ez az az orientáció, amikor a célpontnak háttal állunk az adott helyen
                    OrientTarget  = atan2(originalState.robots(i).Simulation.Speed.Y,originalState.robots(i).Simulation.Speed.X);
                    if (DeltaX>Epsilon)                             % nem értük még el a pontot
                        % itt nem unitokra számolja a forgásokat, így összekumulálódhat egy pici hiba, hogy végül mégsem arra jobb fordulni - de ez pici...
                        DeltaThetaFWD = OrientMoveFWD - OrientCurrent;
                        DeltaThetaBWD = OrientMoveBWD - OrientCurrent;
                        if (abs(DeltaThetaFWD)>pi), DeltaThetaFWD=DeltaThetaFWD-sign(DeltaThetaFWD)*2*pi; end
                        if (abs(DeltaThetaBWD)>pi), DeltaThetaBWD=DeltaThetaBWD-sign(DeltaThetaBWD)*2*pi; end
                        % Egy rendes orientáció (cos,sin), tehát sum=[1..sqrt2] között van.
                        % Ha mégis ==0, az azt jelenti, hogy a célorientáció nem érdekes, vagyis ne foglalkozzon vele, maradjon úgy, ahogy érkezett:
                        if ~originalState.robots(i).Simulation.Speed.X && ~originalState.robots(i).Simulation.Speed.Y
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
                        if ~originalState.robots(i).Simulation.Speed.X && ~originalState.robots(i).Simulation.Speed.Y                          % forgás a célpontban
                            DeltaTheta2 = 0;
                        else  
                            DeltaTheta2 = OrientTarget - OrientCurrent;
                            if (abs(DeltaTheta2)>pi), DeltaTheta2=DeltaTheta2-sign(DeltaTheta2)*2*pi; end
                        end
                        backward_multiplier = 1;
                    end
                    
                    if (abs(DeltaTheta1)<=EpsilonTh), DeltaTheta1=0; end
                    if (abs(DeltaTheta2)<=EpsilonTh), DeltaTheta2=0; end
                    
                    % milyen orientációval fogja befejezni a manõvert:
                    % [azért kell visszadni, hogy ha a TP több pontos szekvenciát számol, tudja a következõ pontra, hogy mi volt az utolsó szegmens végén az orientáció]
                    if originalState.robots(i).Simulation.Speed.X || originalState.robots(i).Simulation.Speed.Y                       % ha van megadva célorientáció, akkor azzal
                        Ori2 = [originalState.robots(i).Simulation.Speed.X originalState.robots(i).Simulation.Speed.Y];  %Xf(3:4);
                    else                                    % ha nincs megadva, akkor úgy áll meg, ahogy érkezett a célpontba
                        Ori2 = OrientCurrent + DeltaTheta1;
                        Ori2 = [cos(Ori2) sin(Ori2)];
                    end
            



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
        
                    TimeToGo           = DeltaX/Speed;                  % ennyi idõ (csak) egyenesen odamenni a kívánt/telített sebességgel [/ idõ alatt]
                    TimeUnitsToGo      = ceil(TimeToGo);                % max sebességgel ennyi idõegységbe telne egyenesen a célba jutni
                    TimeUnitsToPerform = TimeUnitsToTurn + TimeUnitsToGo;% max sebesség + fordulási idõ
                
                    % Default: teljes sebességgel fordul, de az utsó fordulási lépésben csak annyit, amennyit még épp kell:
                    LastStepTheta1 = DeltaTheta1 - sign(DeltaTheta1)*(TimeUnitsToTurn1-1)*MaxSpeed/R;
                    LastStepTheta2 = DeltaTheta2 - sign(DeltaTheta2)*(TimeUnitsToTurn2-1)*MaxSpeed/R;

                    U=zeros(TimeUnitsToPerform,ControlNum);
                    % A TP gondoskodik a megfelelõ számú [default = CycleBatch, aktuálisan] jel [akár zérusok] visszaadásáról,
                    % itt nincs kontroll, mert TimeStamp sincs.
                    % Mert ha pl. ennél messzebbi célponttal hívták meg, annak biztosan oka volt.
                    % pl. LÖVÉSNÉL A LABDÁIG TARTÓ ÚT HOSSZA is így mûködik, direkt hívással...
  
                    %--------------------------------------------------------------------------
                    % Ui beavatkozó jelek specifikálása:
                    %--------------------------------------------------------------------------
                    %
                    % 1. oszlop: relatív sebesség:
                    %   -1 hátra
                    %   +1 elõre
                    % 2. oszlop: szögsebesség [-> 1 Ts-re épp a deltaThetát adja...] Ez nam relatív, mert így nem kell feleslegesen osztani, majd visszaszorozni.
                    %   - clockwise (jobbra)
                    %   + counter-cw (balra)


                    Phase2Start = TimeUnitsToTurn1+1;
                    Phase2End   = TimeUnitsToTurn1+TimeUnitsToGo;
                    Phase3Start = Phase2End+1;
                    Phase3End   = Phase2End+TimeUnitsToTurn2;
                    
                    %--------------------------------------------------------------------------
                    % 1. fázis: irányba fordulás:
                    %--------------------------------------------------------------------------
                    if TimeUnitsToTurn1 == 1
                        U(1,2)                 = LastStepTheta1;
                    elseif TimeUnitsToTurn1 > 1
                        % LastStepTheta elõjele megegyezik az eredeti szögeltérésével,
                        % mert az atan2() +- pi tartománybn adja meg a szögeltérést:
                        U(1:TimeUnitsToTurn1,2) = (DeltaTheta1-LastStepTheta1)/(TimeUnitsToTurn1-1); % telítésben fordul
                        if abs(LastStepTheta1)   % csak akkor írjuk felül az utsót, ha kell
                            U(TimeUnitsToTurn1,2) = LastStepTheta1;        % de az utolsóban csak annyit, hogy beálljon
                        end
                    end
                    
                    %--------------------------------------------------------------------------
                    % 2. fázis: egyenesen a célra megy állandó sebességgel:
                    %--------------------------------------------------------------------------
                    if TimeUnitsToGo>0                  % Csak akkor nézzük az egyenes szakaszt, ha egyáltalán van:
                        U(Phase2Start : Phase2End,1) = Speed;
                        U(Phase2End,1) = (DeltaX-(Speed*(TimeUnitsToGo-1)))/MaxSpeed; % utsó lépéssel pont beáll, nem lõ túl
                    end
                    if backward_multiplier==-1, U(Phase2Start : Phase2End,1) = -U(Phase2Start : Phase2End,1); end % ha háttal megy -> -1xes sebesség
                    
                    %--------------------------------------------------------------------------
                    % 3. fázis: irányba fordulás a célpontban:
                    %--------------------------------------------------------------------------
                    if TimeUnitsToTurn2 == 1
                        U(Phase3Start,1:2)                 = [0 LastStepTheta2];
                    elseif TimeUnitsToTurn2 > 1
                        % LastStepTheta elõjele megegyezik az eredeti szögeltérésével,
                        % mert az atan2() +- pi tartománybn adja meg a szögeltérést:
                        U(Phase3Start:Phase3End,2) = (DeltaTheta2-LastStepTheta2)/(TimeUnitsToTurn2-1); % telítésben fordul
                        if abs(LastStepTheta2)   % csak akkor írjuk felül az utsót, ha kell
                            U(Phase3End,2) = LastStepTheta2;        % de az utolsóban csak annyit, hogy beálljon
                        end
                        U(Phase3Start:Phase3End,1) = 0;
                    end
                    
                    
                    
                end
            end
            controlledState = originalState;
        end
    end
end

