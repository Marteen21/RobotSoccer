function varargout = teamsetup(varargin)
% TEAMSETUP MATLAB code for teamsetup.fig
%      TEAMSETUP, by itself, creates a new TEAMSETUP or raises the existing
%      singleton*.
%
%      H = TEAMSETUP returns the handle to a new TEAMSETUP or the handle to
%      the existing singleton*.
%
%      TEAMSETUP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TEAMSETUP.M with the given input arguments.
%
%      TEAMSETUP('Property','Value',...) creates a new TEAMSETUP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before teamsetup_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to teamsetup_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help teamsetup

% Last Modified by GUIDE v2.5 18-May-2016 13:07:52

% Begin initialization code - DO NOT EDIT
teamAn=0;
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @teamsetup_OpeningFcn, ...
                   'gui_OutputFcn',  @teamsetup_OutputFcn, ...
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


% --- Executes just before teamsetup is made visible.
function teamsetup_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to teamsetup (see VARARGIN)

% Choose default command line output for teamsetup
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes teamsetup wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = teamsetup_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
output = strsplit(AddRobot,',');
if(strcmp(output(1),'OK'))
    f= handles.uipanel2;
    child_handles = ceil(length(allchild(f))/2);
    pb = uicontrol(f,'Style','pushbutton','String','Remove','Tag',strcat('btnrmv2',num2str(child_handles)),'Callback',@btnrmv2_Callback,...
        'Position',[100 280-30*child_handles 70 15]);
    
    pc = uicontrol(f,'Style','text','String',strcat('Omni,',output(2),',',output(3)),'Tag',strcat('static2',num2str(child_handles)),...
        'Position',[20 280-30*child_handles 70 15]);
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
output = strsplit(AddRobot,',');
if(strcmp(output(1),'OK'))
    f= handles.uipanel1;
    child_handles = ceil(length(allchild(f))/2);
    pb = uicontrol(f,'Style','pushbutton','String','Remove','Tag',strcat('btnrmv',num2str(child_handles)),'Callback',@btnrmv_Callback,...
        'Position',[100 280-30*child_handles 70 15]);
    
    pc = uicontrol(f,'Style','text','String',strcat('Omni,',output(2),',',output(3)),'Tag',strcat('static',num2str(child_handles)),...
        'Position',[20 280-30*child_handles 70 15]);
end
function btnrmv_Callback(hObject, eventdata, handles)
    mytag = hObject.Tag;
    myno = mytag(7);
    mystatictag = strcat('static',myno);
    delete(findobj('Tag',mytag));
    delete(findobj('Tag',mystatictag));
    
    function btnrmv2_Callback(hObject, eventdata, handles)
    mytag = hObject.Tag;
    myno = mytag(8);
    mystatictag = strcat('static2',myno);
    delete(findobj('Tag',mytag));
    delete(findobj('Tag',mystatictag));
    
