function varargout = MainFigure(varargin)
% MAINFIGURE MATLAB code for MainFigure.fig
%      MAINFIGURE, by itself, creates a new MAINFIGURE or raises the existing
%      singleton*.
%
%      H = MAINFIGURE returns the handle to a new MAINFIGURE or the handle to
%      the existing singleton*.
%
%      MAINFIGURE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAINFIGURE.M with the given input arguments.
%
%      MAINFIGURE('Property','Value',...) creates a new MAINFIGURE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MainFigure_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MainFigure_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MainFigure

% Last Modified by GUIDE v2.5 15-Mar-2016 18:49:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MainFigure_OpeningFcn, ...
                   'gui_OutputFcn',  @MainFigure_OutputFcn, ...
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


% --- Executes just before MainFigure is made visible.
function MainFigure_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MainFigure (see VARARGIN)

% Choose default command line output for MainFigure
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MainFigure wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MainFigure_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes when selected object is changed in uibuttongroup1.
function uibuttongroup1_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uibuttongroup1 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(get(handles.rb_simulation,'Value') == get(handles.rb_simulation,'Max'))
    set(handles.btn_simsettings,'Enable','on');
else
    set(handles.btn_simsettings,'Enable','off');
end


% --- Executes on button press in btn_simsettings.
function btn_simsettings_Callback(hObject, eventdata, handles)
% hObject    handle to btn_simsettings (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
user_response = SimulationSettingsFigure('Title','Simulation Settings');
switch user_response
case 'Cancel'
	% take no action
case 'Save'
	% Prepare to close application window
	% TODO Save Settings
end


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
