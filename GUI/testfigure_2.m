function varargout = testfigure_2(varargin)
% TESTFIGURE_2 MATLAB code for testfigure_2.fig
%      TESTFIGURE_2, by itself, creates a new TESTFIGURE_2 or raises the existing
%      singleton*.
%
%      H = TESTFIGURE_2 returns the handle to a new TESTFIGURE_2 or the handle to
%      the existing singleton*.
%
%      TESTFIGURE_2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TESTFIGURE_2.M with the given input arguments.
%
%      TESTFIGURE_2('Property','Value',...) creates a new TESTFIGURE_2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before testfigure_2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to testfigure_2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help testfigure_2

% Last Modified by GUIDE v2.5 11-Mar-2016 17:50:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @testfigure_2_OpeningFcn, ...
                   'gui_OutputFcn',  @testfigure_2_OutputFcn, ...
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


% --- Executes just before testfigure_2 is made visible.
function testfigure_2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to testfigure_2 (see VARARGIN)

% Choose default command line output for testfigure_2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes testfigure_2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = testfigure_2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


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


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
  pos = get(handles.popupmenu1,'Position')
  
  
  contents = get(handles.popupmenu1,'String'); 
  popupmenu2value = contents{get(handles.popupmenu1,'Value')};
  switch popupmenu2value
      case '1'
        %msgbox('Number: 1')
        pushbutton(1) = uicontrol(testfigure_2,'Style','pushbutton',...
                'String','Indent nested functions.',...
                'Value',1,'Position',[pos(1) pos(2)-25 pos(3) pos(4)]);
        set(handles.pushbutton2,'Enable','inactive');
        
      case '2'
        %msgbox('Number: 2')
        set(handles.uipanel1,'Position',[pos(1) pos(2)-25 pos(3) str2double(popupmenu2value)*pos(4)])
        get(handles.uipanel1,'Position')
        str2double(popupmenu2value)
        for i = 1:str2double(popupmenu2value)   
             
             pushbutton(i) = uicontrol(testfigure_2,'Style','pushbutton',...
                           'Parent',uipanel1,...
                           'String','Robots',...
                           'Tag',strcat('pushbutton0',num2str(i)),...
                           'Callback',@temp_pushbutton_callback,...
                           'Value',1,'Position',[pos(1) pos(2)-i*50 pos(3) pos(4)]);
        end
        
      case '3'
        %msgbox('Number: 3')
        str2double(popupmenu2value)
        for i = 1:str2double(popupmenu2value)    
             pushbutton(i) = uicontrol(testfigure_2,'Style','pushbutton',...
                           'String','Robots',...
                           'Tag',strcat('pushbutton0',num2str(i)),...
                           'Value',1,'Position',[pos(1) pos(2)-i*25 pos(3) pos(4)]);
        end
        
      otherwise
          warndlg('Invalid select')
  end


function temp_pushbutton_callback(hObject, eventdata )
        hObject.String
        

% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over pushbutton2.
function pushbutton2_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% popup_status = get(handles.popupmenu1,'String')
% switch popup_status
%     case 1
%         disp('Number: 1')
%     case 2
%         disp('Number: 2')
%     case 3
%         disp('Number: 3')
%     otherwise
%         warndlg('Invalid select')
% end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over pushbutton3.
function pushbutton3_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
