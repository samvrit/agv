function varargout = agv_analytical(varargin)
% AGV_ANALYTICAL MATLAB code for agv_analytical.fig
%      AGV_ANALYTICAL, by itself, creates a new AGV_ANALYTICAL or raises the existing
%      singleton*.
%
%      H = AGV_ANALYTICAL returns the handle to a new AGV_ANALYTICAL or the handle to
%      the existing singleton*.
%
%      AGV_ANALYTICAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AGV_ANALYTICAL.M with the given input arguments.
%
%      AGV_ANALYTICAL('Property','Value',...) creates a new AGV_ANALYTICAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before agv_analytical_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to agv_analytical_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help agv_analytical

% Last Modified by GUIDE v2.5 19-Oct-2017 10:09:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @agv_analytical_OpeningFcn, ...
                   'gui_OutputFcn',  @agv_analytical_OutputFcn, ...
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


% --- Executes just before agv_analytical is made visible.
function agv_analytical_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to agv_analytical (see VARARGIN)

% Choose default command line output for agv_analytical
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
handles.timer = timer(...
    'ExecutionMode', 'fixedRate', ...       % Run timer repeatedly.
    'Period', 0.01, ...                        % Initial period is 1 sec.
    'TimerFcn', {@update_display, handles}); % Specify callback function.
start(handles.timer)
% UIWAIT makes agv_analytical wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = agv_analytical_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function speed_Callback(hObject, eventdata, handles)
% hObject    handle to speed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function speed_CreateFcn(hObject, eventdata, handles)
% hObject    handle to speed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function count_SM_Callback(hObject, eventdata, handles)
% hObject    handle to count_SM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function count_SM_CreateFcn(hObject, eventdata, handles)
% hObject    handle to count_SM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function count_MB_Callback(hObject, eventdata, handles)
% hObject    handle to count_MB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function count_MB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to count_MB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function count_BP_Callback(hObject, eventdata, handles)
% hObject    handle to count_BP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function count_BP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to count_BP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function count_DS_Callback(hObject, eventdata, handles)
% hObject    handle to count_DS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function count_DS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to count_DS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
T = timerfind;
if ~isempty(T)
    stop(T)
    delete(T)
end
delete(hObject);

function update_display(hObject, eventdata, handles)
agv_speed = get(handles.speed,'value');
set(handles.display_speed,'string',agv_speed);

n_DS = get(handles.count_DS,'value');
n_SM = get(handles.count_SM,'value');
n_MB = get(handles.count_MB,'value');
n_BP = get(handles.count_BP,'value');

set(handles.display_count_DS,'string',n_DS);
set(handles.display_count_SM,'string',n_SM);
set(handles.display_count_MB,'string',n_MB);
set(handles.display_count_BP,'string',n_BP);

agv_count(1) = n_DS;
agv_count(2) = n_SM;
agv_count(3) = n_MB;
agv_count(4) = n_BP;

agv_mean_load(1) = str2double(get(handles.load_DS,'string'));
agv_mean_load(2) = str2double(get(handles.load_SM,'string'));
agv_mean_load(3) = str2double(get(handles.load_MB,'string'));
agv_mean_load(4) = str2double(get(handles.load_BP,'string'));

node_distances(1) = str2double(get(handles.distance_DS,'string'));
node_distances(2) = str2double(get(handles.distance_SM,'string'));
node_distances(3) = str2double(get(handles.distance_MB,'string'));
node_distances(4) = str2double(get(handles.distance_BP,'string'));

arrival_rate = str2double(get(handles.arrival,'string'));
mfg_rate = str2double(get(handles.manufacturing,'string'));
pkg_rate = str2double(get(handles.packaging,'string'));

[data_table, lead_time, idle_time] = agv_plant(agv_speed,agv_mean_load, agv_count, arrival_rate, node_distances, mfg_rate, pkg_rate);

set(handles.display_data_table,'data',data_table);
set(handles.display_lead_time,'string',num2str(lead_time));
set(handles.display_idle_time,'string',num2str(idle_time));

function load_DS_Callback(hObject, eventdata, handles)
% hObject    handle to load_DS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of load_DS as text
%        str2double(get(hObject,'String')) returns contents of load_DS as a double


% --- Executes during object creation, after setting all properties.
function load_DS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to load_DS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function load_SM_Callback(hObject, eventdata, handles)
% hObject    handle to load_SM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of load_SM as text
%        str2double(get(hObject,'String')) returns contents of load_SM as a double


% --- Executes during object creation, after setting all properties.
function load_SM_CreateFcn(hObject, eventdata, handles)
% hObject    handle to load_SM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function load_MB_Callback(hObject, eventdata, handles)
% hObject    handle to load_MB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of load_MB as text
%        str2double(get(hObject,'String')) returns contents of load_MB as a double


% --- Executes during object creation, after setting all properties.
function load_MB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to load_MB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function load_BP_Callback(hObject, eventdata, handles)
% hObject    handle to load_BP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of load_BP as text
%        str2double(get(hObject,'String')) returns contents of load_BP as a double


% --- Executes during object creation, after setting all properties.
function load_BP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to load_BP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function arrival_Callback(hObject, eventdata, handles)
% hObject    handle to arrival (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of arrival as text
%        str2double(get(hObject,'String')) returns contents of arrival as a double


% --- Executes during object creation, after setting all properties.
function arrival_CreateFcn(hObject, eventdata, handles)
% hObject    handle to arrival (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function manufacturing_Callback(hObject, eventdata, handles)
% hObject    handle to manufacturing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of manufacturing as text
%        str2double(get(hObject,'String')) returns contents of manufacturing as a double


% --- Executes during object creation, after setting all properties.
function manufacturing_CreateFcn(hObject, eventdata, handles)
% hObject    handle to manufacturing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function packaging_Callback(hObject, eventdata, handles)
% hObject    handle to packaging (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of packaging as text
%        str2double(get(hObject,'String')) returns contents of packaging as a double


% --- Executes during object creation, after setting all properties.
function packaging_CreateFcn(hObject, eventdata, handles)
% hObject    handle to packaging (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function distance_DS_Callback(hObject, eventdata, handles)
% hObject    handle to distance_DS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of distance_DS as text
%        str2double(get(hObject,'String')) returns contents of distance_DS as a double


% --- Executes during object creation, after setting all properties.
function distance_DS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to distance_DS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function distance_SM_Callback(hObject, eventdata, handles)
% hObject    handle to distance_SM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of distance_SM as text
%        str2double(get(hObject,'String')) returns contents of distance_SM as a double


% --- Executes during object creation, after setting all properties.
function distance_SM_CreateFcn(hObject, eventdata, handles)
% hObject    handle to distance_SM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function distance_MB_Callback(hObject, eventdata, handles)
% hObject    handle to distance_MB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of distance_MB as text
%        str2double(get(hObject,'String')) returns contents of distance_MB as a double


% --- Executes during object creation, after setting all properties.
function distance_MB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to distance_MB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function distance_BP_Callback(hObject, eventdata, handles)
% hObject    handle to distance_BP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of distance_BP as text
%        str2double(get(hObject,'String')) returns contents of distance_BP as a double


% --- Executes during object creation, after setting all properties.
function distance_BP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to distance_BP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in save_result.
function save_result_Callback(hObject, eventdata, handles)
% hObject    handle to save_result (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
