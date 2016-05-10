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

% Last Modified by GUIDE v2.5 10-May-2016 15:32:23

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

% %Animation plot
% h=findobj('Type','axes','Tag','axes1');
%               
% plot(1,0,'O')
% axes(h) 
% hold on
% set(handles.axes1,'XLim',[0 1])
% set(handles.axes1,'YLim',[0 1])
%                 
% ball =  plot(0,0,'mo','MarkerFaceColor','m',...
%                        'YDataSource','Y',...
%                        'XDataSource','X'); 
% ball2 = plot(0,1,'mo','MarkerFaceColor','y',...
%                        'YDataSource','Y2',...
%                        'XDataSource','X2');                    
%                    
% r = 0.05;
% Y = 0;
% X = 0;
% X2 = 0;
% Y2 = 1;
% 
% k = 1;
% l = 1;
% dist = linspace(0,1,100);
% ball_dist = 1;
% collision = 1;
% for i=0:0
%     for j=1:length(dist)
%         X = dist(j)
%         X2 = dist(j)
%         ball_dist = (X-X2)+(Y-Y2);
%         
% %         if ((2*r)>(d-1))
% %             collision = 0;
%         
%         if (X == dist(end))
%             for k=length(dist):-1:1
%                 X = dist(k)
%                 X2 = dist(k)
%                 refreshdata(ball,'caller');
% %                 set(handles.axes1,'XLim',[0 1])
% %                 set(handles.axes1,'YLim',[-1 1])
%                 drawnow;
%                 pause(.01);
%             end
%         end
%         if (round(Y2,1)== Y)
%             collision = 0;
%             k=3;
%         end
%         if (round(Y2,1)==1)
%             collision = 1
%             if (k==3)
%                 l=3
%             end
%         end
% %         if round(ball_dist,1) == 0
% %             msgbox('Ball collision')
% %         end
%         
%         if (collision == 1) 
%                 Y2 = 1*k - 4*X2
%         else
%                 Y2 = -1*l + 4*X2
%         end
%         refreshdata(ball,'caller');
%         refreshdata(ball2,'caller');
% %         set(handles.axes1,'XLim',[0 1])
% %         set(handles.axes1,'YLim',[-1 1])
%         drawnow;
%         pause(.01);     
%     end
% end



%Magic happens here
% handles.peaks = peaks(35);
% handles.membrane = membrane;
% [x, y] = meshgrid(-8:0.5:8);
% r = sqrt(x.^2+y.^2) + eps;
% sinc = sin(r)./r;
% handles.sinc = sinc;
% handles.current_data = handles.peaks;
% surf (handles.current_data);


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
% c = Collision(110,5);                                 %running the simulation
% balli =  plot(0,0,'mo','MarkerFaceColor','m',...    %define a ball 
%                             'YDataSource','Y',...
%                             'XDataSource','X'); 

%-------------New simulation with robots----------------
Steps = 1000;
myball = Ball(71.149857097948540,50.145860501244364,-13.950047634017205,-2.323174622935383);
myrobot = Robot(30,28,0,0,'TeamA');
myrobot2 = Robot(10,10,0,0,'TeamB');
myState = SimState(0,myball,[myrobot,myrobot2]);
c = Simulate(myState, Steps);


sample = 0;  

%Alapállás felvétele------
plot(Environment.goalPos.X,Environment.goalPos.Y - Environment.goalLength,'>','Color',[0,0,0]);
hold on
plot(Environment.goalPos.X,Environment.goalPos.Y + Environment.goalLength,'>','Color',[0,0,0]);

plot(Environment.goalPos.X+Environment.xLim,Environment.goalPos.Y - Environment.goalLength,'<','Color',[0,0,0]);
plot(Environment.goalPos.X+Environment.xLim,Environment.goalPos.Y + Environment.goalLength,'<','Color',[0,0,0]);

% Robot1 = viscircles([c(1).robots(1).Position.X c(1).robots(1).Position.Y],c(1).robots(1).Radius);
% Robot2 = viscircles([c(1).robots(2).Position.X c(1).robots(2).Position.Y],c(1).robots(2).Radius);
% BallDraw = viscircles([c(1).ball.Position.X c(1).ball.Position.Y],c(1).ball.Radius);

%---------Rectangles-------------
Robot1 = rectangle('Position',[c(1).robots(1).Position.X-c(1).robots(1).Radius,c(1).robots(1).Position.Y-c(1).robots(1).Radius, 2*c(1).robots(1).Radius, 2*c(1).robots(1).Radius],...
'Curvature',[1,1], 'FaceColor','r');
Robot2 = rectangle('Position',[c(1).robots(2).Position.X-c(1).robots(2).Radius,c(1).robots(2).Position.Y-c(1).robots(2).Radius, 2*c(1).robots(2).Radius, 2*c(1).robots(2).Radius],...
'Curvature',[1,1], 'FaceColor','r');
BallDraw = rectangle('Position',[c(1).ball.Position.X-c(1).ball.Radius,c(1).ball.Position.Y-c(1).ball.Radius, 2*c(1).ball.Radius, 2*c(1).ball.Radius],...
'Curvature',[1,1], 'FaceColor','r');


axis([0, Environment.xLim, 0, Environment.yLim]);
set(gca,'xtick',[],'ytick',[])
for i=1:Steps
    
    sampleTime = c(i+1).time-c(i).time;
    sample = sample + sampleTime;
    set(handles.edit1,'string',num2str(sample));
    t = timer('TimerFcn', 'stat=false;',... 
                 'StartDelay',(sampleTime)/(SimulationData.simSpeed-1));
    start(t);
    
%     Old Showoff--------    
%     X = c(i).ball.Position.X;     
%     Y = c(i).ball.Position.Y;
%     axis([0, Environment.xLim, 0, Environment.yLim]);
%     set(gca,'xtick',[],'ytick',[])
%     refreshdata(balli,'caller')
%     drawnow;
%     ---------------------------------
    
    
    Robot1.Position = [c(i).robots(1).Position.X-c(i).robots(1).Radius,c(i).robots(1).Position.Y-c(i).robots(1).Radius, 2*c(i).robots(1).Radius, 2*c(i).robots(1).Radius];
    Robot2.Position = [c(i).robots(2).Position.X-c(i).robots(2).Radius,c(i).robots(2).Position.Y-c(i).robots(2).Radius, 2*c(i).robots(2).Radius, 2*c(i).robots(2).Radius];
    BallDraw.Position = [c(i).ball.Position.X-c(i).ball.Radius,c(i).ball.Position.Y-c(i).ball.Radius, 2*c(i).ball.Radius, 2*c(i).ball.Radius];

    axis([0, Environment.xLim, 0, Environment.yLim]);
    set(gca,'xtick',[],'ytick',[]);
    
%     if (((c(i).ball.Position.X - c(i).ball.Radius) <= 0.1) && (Environment.goalPos.Y-Environment.goalLength/2 <= c(i).ball.Position.Y) && (c(i).ball.Position.Y <= Environment.goalPos.Y + Environment.goalLength/2))
%         Referee.ScoreB(Referee.ScoreB + 1);
%         set(handles.editTeamB,'String',num2str(Referee.ScoreB));
%     elseif (((c(i).ball.Position.X + c(i).ball.Radius) >= Environment.xLim-0.1) && (Environment.goalPos.Y-Environment.goalLength/2 <= c(i).ball.Position.Y) && (c(i).ball.Position.Y <= Environment.goalPos.Y + Environment.goalLength/2))
%         Referee.ScoreA(Referee.ScoreA + 1);
%         set(handles.editTeamA,'String',num2str(Referee.ScoreA));
%     end
    set(handles.editTeamA,'String',num2str(c(i).teamScore(1)))
    set(handles.editTeamB,'String',num2str(c(i).teamScore(2)))
    drawnow;
    
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
