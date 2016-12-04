function varargout = testfigure(varargin)
% TESTFIGURE MATLAB code for testfigure.fig
%      TESTFIGURE, by itself, creates a new TESTFIGURE or raises the existing
%      singleton*.
%
%      H = TESTFIGURE returns the handle to a new TESTFIGURE or the handle to
%      the existing singleton*.
%
%      TESTFIGURE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TESTFIGURE.M with the given input arguments.
%
%      TESTFIGURE('Property','Value',...) creates a new TESTFIGURE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before testfigure_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to testfigure_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help testfigure

% Last Modified by GUIDE v2.5 24-May-2016 10:52:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @testfigure_OpeningFcn, ...
                   'gui_OutputFcn',  @testfigure_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before testfigure is made visible.
function testfigure_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to testfigure (see VARARGIN)

% Choose default command line output for testfigure
handles.output = hObject;

set(handles.edit1,'string','0');


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes testfigure wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = testfigure_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%testfigure_2

Initializer                                         %set the global variables
set(handles.editTeamA,'String',0);
set(handles.editTeamB,'String',0);

cla


%-------------New simulation with robots----------------
Steps = 500;


% for i=1:length(myRobots)
%                 myRobots(i).Simulation.Speed = Vector2([0,-1]);
%                 if (strcmp(myRobots(i).Owner,'TeamA'))
%                     myRobots(i).Position.X = Environment.xLim/2 - 20*stepA;
%                     myRobots(i).Position.Y = Environment.yLim/2 + Environment.yLim/40;
%                     stepA = stepA+1;
%                 else
%                     myRobots(i).Position.X = Environment.xLim/2 + 20*stepB;
%                     myRobots(i).Position.Y = Environment.yLim/2 - Environment.yLim/40;
%                     stepB = stepB+1;
%                 end
%             end


myball = Ball(Environment.xLim/2,Environment.yLim/2,0,0);
myrobot = Robot(Environment.xLim/2 - 20,Environment.yLim/2 + Environment.yLim/40,1,0,0,0,'TeamA');
myrobot2 = Robot(Environment.xLim/2 + 20,Environment.yLim/2 - Environment.yLim/40,-1,0,0,0,'TeamB');
myrobot3 = Robot(Environment.xLim/2 - 40,Environment.yLim/2 - Environment.yLim/40,1,0,0,0,'TeamA');
myrobot4 = Robot(Environment.xLim/2 + 40,Environment.yLim/2 - Environment.yLim/40,-1,0,0,0,'TeamB');
myState = SimState(0,myball,[myrobot,myrobot3,myrobot2,myrobot4]);
c = Simulate(myState, Steps);


sample = 0;  

%-----Environment setup------
plot(Environment.goalPos.X,Environment.goalPos.Y - Environment.goalLength,'>','Color',[0,0,0]);
hold on
plot(Environment.goalPos.X,Environment.goalPos.Y + Environment.goalLength,'>','Color',[0,0,0]);

plot(Environment.goalPos.X+Environment.xLim,Environment.goalPos.Y - Environment.goalLength,'<','Color',[0,0,0]);
plot(Environment.goalPos.X+Environment.xLim,Environment.goalPos.Y + Environment.goalLength,'<','Color',[0,0,0]);


%---------Rectangles-------------
RobotDraw(1) = rectangle('Position',[c(1).robots(1).Position.X-c(1).robots(1).Radius,c(1).robots(1).Position.Y-c(1).robots(1).Radius, 2*c(1).robots(1).Radius, 2*c(1).robots(1).Radius],...
'Curvature',[1,1], 'FaceColor','g');
RobotDraw(2) = rectangle('Position',[c(1).robots(2).Position.X-c(1).robots(2).Radius,c(1).robots(2).Position.Y-c(1).robots(2).Radius, 2*c(1).robots(2).Radius, 2*c(1).robots(2).Radius],...
'Curvature',[1,1], 'FaceColor','r');
RobotDraw(3) = rectangle('Position',[c(1).robots(3).Position.X-c(1).robots(3).Radius,c(1).robots(3).Position.Y-c(1).robots(3).Radius, 2*c(1).robots(3).Radius, 2*c(1).robots(3).Radius],...
'Curvature',[1,1], 'FaceColor','g');
RobotDraw(4) = rectangle('Position',[c(1).robots(4).Position.X-c(1).robots(4).Radius,c(1).robots(4).Position.Y-c(1).robots(4).Radius, 2*c(1).robots(4).Radius, 2*c(1).robots(4).Radius],...
'Curvature',[1,1], 'FaceColor','r');
BallDraw = rectangle('Position',[c(1).ball.Position.X-c(1).ball.Radius,c(1).ball.Position.Y-c(1).ball.Radius, 2*c(1).ball.Radius, 2*c(1).ball.Radius],...
'Curvature',[1,1], 'FaceColor','y');

for l=1:length(RobotDraw)
        Orientation(l) = line('XData',[0 0],'YData',[0 0]);
end

axis([0, Environment.xLim, 0, Environment.yLim]);
set(gca,'xtick',[],'ytick',[])
for i=1:Steps
    
    sampleTime = c(i+1).time-c(i).time;
    sample = sample + sampleTime;
    set(handles.edit1,'string',num2str(sample));
    t = timer('TimerFcn', 'stat=false;',... 
                 'StartDelay',(sampleTime)/(SimulationData.simSpeed)); %SimulationData.simSpeed - 1
    start(t);
%     %DEBUG------
    
    if (i == 1)
        
    end
%     %DEBUG------
    try
    for k=1:length(RobotDraw)
        RobotDraw(k).Position = [c(i).robots(k).Position.X-c(i).robots(k).Radius,c(i).robots(k).Position.Y-c(i).robots(k).Radius, 2*c(i).robots(k).Radius, 2*c(i).robots(k).Radius];
        Orientation(k).XData = [c(i).robots(k).Position.X c(i).robots(k).Position.X+c(i).robots(k).Radius*(c(i).robots(k).Orientation.X)];
        Orientation(k).YData = [c(i).robots(k).Position.Y c(i).robots(k).Position.Y+c(i).robots(k).Radius*(c(i).robots(k).Orientation.Y)];
%         Orientation(k).XData = [c(i).robots(k).Position.X c(i).robots(k).Position.X+c(i).robots(k).Radius*((c(i).robots(k).Simulation.Speed.X)/(norm(c(i).robots(k).Simulation.Speed.RowForm())))];
%         Orientation(k).YData = [c(i).robots(k).Positoin.Y c(i).robots(k).Position.Y+c(i).robots(k).Radius*((c(i).robots(k).Simulation.Speed.Y)/(norm(c(i).robots(k).Simulation.Speed.RowForm())))];
    end     
    BallDraw.Position = [c(i).ball.Position.X-c(i).ball.Radius,c(i).ball.Position.Y-c(i).ball.Radius, 2*c(i).ball.Radius, 2*c(i).ball.Radius];
    catch
        error('Rectangle position error');
    end
    axis([0, Environment.xLim, 0, Environment.yLim]);
    set(gca,'xtick',[],'ytick',[]);

    set(handles.editTeamA,'String',num2str(c(i).teamScore(1)))
    set(handles.editTeamB,'String',num2str(c(i).teamScore(2)))
    drawnow;
%     refreshdata;
    
    waitfor(t);
    
end
delete(t);



% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over pushbutton1.
function pushbutton1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

user_response = SimulationSettingsFigure('Title','Simulation Settings');
set(handles.pushbutton1,'Enable','on');



function editTeamA_Callback(hObject, eventdata, handles)
% hObject    handle to editTeamA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editTeamA as text
%        str2double(get(hObject,'String')) returns contents of editTeamA as a double


% --- Executes during object creation, after setting all properties.
function editTeamA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editTeamA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editTeamB_Callback(hObject, eventdata, handles)
% hObject    handle to editTeamB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editTeamB as text
%        str2double(get(hObject,'String')) returns contents of editTeamB as a double


% --- Executes during object creation, after setting all properties.
function editTeamB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editTeamB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
teamsetup
