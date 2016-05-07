function varargout = SimulationSettingsFigure(varargin)
% SIMULATIONSETTINGSFIGURE MATLAB code for SimulationSettingsFigure.fig
%      SIMULATIONSETTINGSFIGURE, by itself, creates a new SIMULATIONSETTINGSFIGURE or raises the existing
%      singleton*.
%
%      H = SIMULATIONSETTINGSFIGURE returns the handle to a new SIMULATIONSETTINGSFIGURE or the handle to
%      the existing singleton*.
%
%      SIMULATIONSETTINGSFIGURE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SIMULATIONSETTINGSFIGURE.M with the given input arguments.
%
%      SIMULATIONSETTINGSFIGURE('Property','Value',...) creates a new SIMULATIONSETTINGSFIGURE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SimulationSettingsFigure_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SimulationSettingsFigure_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SimulationSettingsFigure

% Last Modified by GUIDE v2.5 07-May-2016 11:13:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SimulationSettingsFigure_OpeningFcn, ...
                   'gui_OutputFcn',  @SimulationSettingsFigure_OutputFcn, ...
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

% --- Executes just before SimulationSettingsFigure is made visible.
function SimulationSettingsFigure_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SimulationSettingsFigure (see VARARGIN)

% Choose default command line output for SimulationSettingsFigure
handles.output = 'Cancel';

% Update handles structure
guidata(hObject, handles);
set(handles.figure2,'WindowStyle','modal')
% UIWAIT makes SimulationSettingsFigure wait for user response (see UIRESUME)
uiwait(handles.figure2);


% --- Outputs from this function are returned to the command line.
function varargout = SimulationSettingsFigure_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
% The figure can be deleted now
delete(handles.figure2);


function editTxt_Friction_Callback(hObject, eventdata, handles)
% hObject    handle to editTxt_Friction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editTxt_Friction as text
%        str2double(get(hObject,'String')) returns contents of editTxt_Friction as a double
str=get(hObject,'String');
if isempty(str2num(str)) || str2num(str)>1 || str2num(str)<0
    set(hObject,'String','0');
    warndlg('Input must be numerical between 0 and 1');
end
set(handles.sldr_friction,'Value',str2num(get(hObject,'String')))


% --- Executes during object creation, after setting all properties.
function editTxt_Friction_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editTxt_Friction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_save.
function btn_save_Callback(hObject, eventdata, handles)
% hObject    handle to btn_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output = get(hObject,'String');

%Save simulation speed
contents = get(handles.popupmenu2,'String')
popupmenu2value = contents{get(handles.popupmenu2,'Value')}
ValueHandle = get(handles.popupmenu2,'Value')
switch popupmenu2value
    case '1x'
        SimulationData.simSpeed(get(handles.popupmenu2,'Value'));
        disp('Set this shit 1x')
    case '2x'
        SimulationData.simSpeed(get(handles.popupmenu2,'Value'));
        disp('Set this shit 2x')
    case '3x'
        SimulationData.simSpeed(get(handles.popupmenu2,'Value'));
        disp('Set this shit 3x')
    case '4x'
        SimulationData.simSpeed(get(handles.popupmenu2,'Value'));
        disp('Set this shit 4x')
    otherwise
end



%Global SampleTime setup
SimulationData.sampleTime(str2double(get(handles.editTxt_SampleTime,'string')));

%Global Friction setup
SimulationData.friction(str2double(get(handles.editTxt_Friction,'string')));

% Update handles structure
guidata(hObject, handles);

% Use UIRESUME instead of delete because the OutputFcn needs
% to get the updated handles structure.
if (get(handles.popupmenu2,'Value')==1)    
    msgbox('Select a simulation speed!');
    error('Select a simulation speed!');
else uiresume(handles.figure2);
end
% uiresume(handles.figure2);

% --- Executes on button press in btn_cancel.
function btn_cancel_Callback(hObject, eventdata, handles)
% hObject    handle to btn_cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output = get(hObject,'String');

% Update handles structure
guidata(hObject, handles);

% Use UIRESUME instead of delete because the OutputFcn needs
% to get the updated handles structure.
uiresume(handles.figure2);

% --- Executes on slider movement.
function sldr_friction_Callback(hObject, eventdata, handles)
% hObject    handle to sldr_friction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.editTxt_Friction,'String',get(hObject,'Value'))

% --- Executes during object creation, after setting all properties.
function sldr_friction_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sldr_friction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
    set(hObject,'Min',0.0);
    set(hObject,'Max',1.0);
end

function figure2_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% if isequal(get(hObject, 'waitstatus'), 'waiting')
%     % The GUI is still in UIWAIT, us UIRESUME
%     uiresume(hObject);
% else
%     % The GUI is no longer waiting, just close it
%     delete(hObject);
% end
handles.output = 'Cancel';

% Update handles structure
guidata(hObject, handles);

% Use UIRESUME instead of delete because the OutputFcn needs
% to get the updated handles structure.
uiresume(handles.figure2);



function editTxt_SampleTime_Callback(hObject, eventdata, handles)
% hObject    handle to editTxt_SampleTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editTxt_SampleTime as text
%        str2double(get(hObject,'String')) returns contents of editTxt_SampleTime as a double


% --- Executes during object creation, after setting all properties.
function editTxt_SampleTime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editTxt_SampleTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
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
