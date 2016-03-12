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

% Last Modified by GUIDE v2.5 12-Mar-2016 14:17:46

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

%Animation plot
h=findobj('Type','axes','Tag','axes1');
axes(h)               
plot(1,0,'O')
hold on

ball =  plot(0,0,'mo','MarkerFaceColor','m',...
                       'YDataSource','Y',...
                       'XDataSource','X'); 
                   
Y=0;

for i=0:0
    dist = linspace(0,1,100);
    for j=1:length(dist)
        X = dist(j)
        refreshdata(h,'caller');
        drawnow;
        pause(.01);     
        if (X == dist(end))
            for k=length(dist):-1:1
                X = dist(k)
                refreshdata(h,'caller');
                drawnow;
                pause(.01);
            end
        end
    end
end


%Animation example2            

% for p=0:40
% 	p
% 	for x=-20:50
% 		y(x+21)=(x-2)^2-3;
% 		y2(x+21)=2*x^3-4*x^2+3*x+15;
% 		y3(x+21)=3*x^2+5*x+130*sin(x+p);
% 	end
% 	y4=-y3
% 	plot(y,'bo-','linewidth',3,'markersize',5)
% 	hold on
% 	plot(y2,'rp-','linewidth',3,'markersize',5)
% 	plot(y3,'kd-','linewidth',3,'markersize',5)
% 	plot(y4,'kd-','linewidth',3,'markersize',5)
% 	grid on
% % 	if p==0
% % 		% Enlarge figure to full screen.
% % 		set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
% % 	end
% 	ylim([-1000,1400])
% 	caption=sprintf('%d',p);
% 	title(caption,'fontsize',25);
% 	legend('y1','y2','y3','y4')
% 	drawnow
% 	pause(0.1)
% 	hold off
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
testfigure_2


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
