function varargout = agv_montecarlo(varargin)
% AGV_MONTECARLO MATLAB code for agv_montecarlo.fig
%      AGV_MONTECARLO, by itself, creates a new AGV_MONTECARLO or raises the existing
%      singleton*.
%
%      H = AGV_MONTECARLO returns the handle to a new AGV_MONTECARLO or the handle to
%      the existing singleton*.
%
%      AGV_MONTECARLO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AGV_MONTECARLO.M with the given input arguments.
%
%      AGV_MONTECARLO('Property','Value',...) creates a new AGV_MONTECARLO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before agv_montecarlo_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to agv_montecarlo_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help agv_montecarlo

% Last Modified by GUIDE v2.5 05-Nov-2017 18:18:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @agv_montecarlo_OpeningFcn, ...
                   'gui_OutputFcn',  @agv_montecarlo_OutputFcn, ...
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

% --- Executes just before agv_montecarlo is made visible.
function agv_montecarlo_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to agv_montecarlo (see VARARGIN)

% Choose default command line output for agv_montecarlo
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
handles.timer = timer(...
    'ExecutionMode', 'fixedRate', ...       % Run timer repeatedly.
    'Period', 0.1, ...                        % Initial period is 1 sec.
    'TimerFcn', {@update_display, handles}); % Specify callback function.
start(handles.timer)    % start the timer
% This sets up the initial plot - only do when we are invisible
% so window can get raised using agv_montecarlo.
if strcmp(get(hObject,'Visible'),'off')
    plot(rand(5));
end

% UIWAIT makes agv_montecarlo wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = agv_montecarlo_OutputFcn(hObject, eventdata, handles)
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
axes(handles.axes1);
cla;

popup_sel_index = get(handles.popupmenu1, 'Value');
switch popup_sel_index
    case 1
        plot(rand(5));
    case 2
        plot(sin(1:0.01:25.99));
    case 3
        bar(1:.5:10);
    case 4
        plot(membrane);
    case 5
        surf(peaks);
end


% --------------------------------------------------------------------
function FileMenu_Callback(hObject, eventdata, handles)
% hObject    handle to FileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function OpenMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to OpenMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file = uigetfile('*.fig');
if ~isequal(file, 0)
    open(file);
end

% --------------------------------------------------------------------
function PrintMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to PrintMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
printdlg(handles.figure1)

% --------------------------------------------------------------------
function CloseMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to CloseMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = questdlg(['Close ' get(handles.figure1,'Name') '?'],...
                     ['Close ' get(handles.figure1,'Name') '...'],...
                     'Yes','No','Yes');
if strcmp(selection,'No')
    return;
end

delete(handles.figure1)


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu1 contents as cell array
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

set(hObject, 'String', {'plot(rand(5))', 'plot(sin(1:0.01:25))', 'bar(1:.5:10)', 'plot(membrane)', 'surf(peaks)'});


% --- Executes on button press in save_result.
function save_result_Callback(hObject, eventdata, handles)
% hObject    handle to save_result (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.save_result,'Enable','off');    % disable the button while action is being performed
pause(0.05);
A = xlsread('results_montecarlo.xlsx');
end_index = size(A,1);
write_index = end_index+2;  % 2 is added to account for the Headings row
data_tuple = get(handles.data_tuple_hidden,'value');
xlswrite('results_montecarlo.xlsx',data_tuple,['A',num2str(write_index),':T',num2str(write_index)]);
set(handles.saved_text,'string','Saved!'); % enable the button after action is performed

% --- Executes on button press in units_toggle.
function units_toggle_Callback(hObject, eventdata, handles)
% hObject    handle to units_toggle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of units_toggle
lead_time = str2double(get(handles.display_lead_time,'string'));
ste = str2double(get(handles.display_standard_error,'string'));
button_state = get(hObject,'Value');
if button_state == get(handles.units_toggle,'Max')
    set(hObject,'Value',button_state);
	set(handles.display_lead_time,'string',num2str(lead_time*60));
    set(handles.display_standard_error,'string',num2str(ste*60));
    set(handles.lead_time_text,'string','Mean System Lead Time (min)');
elseif button_state == get(handles.units_toggle,'Min')
    set(hObject,'Value',button_state);
	set(handles.display_lead_time,'string',num2str(lead_time/60));
    set(handles.display_standard_error,'string',num2str(ste/60));
    set(handles.lead_time_text,'string','Mean System Lead Time (hours)');
end

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


% --- Executes during object creation, after setting all properties.
function display_speed_CreateFcn(hObject, eventdata, handles)
% hObject    handle to display_speed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


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
agv_speed = round(get(handles.speed,'value'),1);
set(handles.display_speed,'string',agv_speed);

n_DS = round(get(handles.count_DS,'value'));
n_SM = round(get(handles.count_SM,'value'));
n_MB = round(get(handles.count_MB,'value'));
n_BP = round(get(handles.count_BP,'value'));

set(handles.display_count_DS,'string',n_DS);
set(handles.display_count_SM,'string',n_SM);
set(handles.display_count_MB,'string',n_MB);
set(handles.display_count_BP,'string',n_BP);


function sim_iterations_Callback(hObject, eventdata, handles)
% hObject    handle to sim_iterations (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sim_iterations as text
%        str2double(get(hObject,'String')) returns contents of sim_iterations as a double


% --- Executes during object creation, after setting all properties.
function sim_iterations_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sim_iterations (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in run_sim.
function run_sim_Callback(hObject, eventdata, handles)
% hObject    handle to run_sim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.sim_running_text,'string','Running Simulation');
set(handles.speed,'Enable','off');
set(handles.count_DS,'Enable','off');
set(handles.count_SM,'Enable','off');
set(handles.count_MB,'Enable','off');
set(handles.count_BP,'Enable','off');
set(handles.load_DS,'Enable','off');
set(handles.load_SM,'Enable','off');
set(handles.load_MB,'Enable','off');
set(handles.load_BP,'Enable','off');
set(handles.distance_DS,'Enable','off');
set(handles.distance_SM,'Enable','off');
set(handles.distance_MB,'Enable','off');
set(handles.distance_BP,'Enable','off');
set(handles.arrival,'Enable','off');
set(handles.manufacturing,'Enable','off');
set(handles.packaging,'Enable','off');
set(handles.sim_iterations,'Enable','off');
set(handles.run_sim,'Enable','off');
pause(0.05);
agv_speed = round(get(handles.speed,'value'),1);
set(handles.display_speed,'string',agv_speed);

n_DS = round(get(handles.count_DS,'value'));
n_SM = round(get(handles.count_SM,'value'));
n_MB = round(get(handles.count_MB,'value'));
n_BP = round(get(handles.count_BP,'value'));

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

t = str2double(get(handles.sim_iterations,'string'));
arrival_rate = str2double(get(handles.arrival,'string'));
mfg_rate = str2double(get(handles.manufacturing,'string'));
pkg_rate = str2double(get(handles.packaging,'string'));

[lead_time, ste, idle_time, total_wait_time] = mc_samvrit(agv_speed,agv_mean_load, agv_count, arrival_rate, node_distances, mfg_rate, pkg_rate, t);
data_tuple = [agv_speed,agv_count,agv_mean_load,node_distances,arrival_rate,mfg_rate,pkg_rate,lead_time,ste,idle_time,t];
set(handles.data_tuple_hidden,'value',data_tuple);

set(handles.sim_running_text,'string','');
button_state = get(handles.units_toggle,'Value');
if button_state == get(handles.units_toggle,'Max')
	set(handles.display_lead_time,'string',num2str(lead_time*60));
    set(handles.display_standard_error,'string',num2str(ste*60));
    set(handles.lead_time_text,'string','Mean System Lead Time (min)');
elseif button_state == get(handles.units_toggle,'Min')
	set(handles.display_lead_time,'string',num2str(lead_time));
    set(handles.display_standard_error,'string',num2str(ste));
    set(handles.lead_time_text,'string','Mean System Lead Time (hours)');
end
set(handles.display_idle_time,'string',num2str(idle_time));
set(handles.reset,'Enable','on');
set(handles.save_result,'Enable','on');
y = hist(total_wait_time,50);
y = y/sum(y);
x = linspace(0,max(total_wait_time),length(y));
plot(x,y);

% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.speed,'Enable','on');
set(handles.count_DS,'Enable','on');
set(handles.count_SM,'Enable','on');
set(handles.count_MB,'Enable','on');
set(handles.count_BP,'Enable','on');
set(handles.load_DS,'Enable','on');
set(handles.load_SM,'Enable','on');
set(handles.load_MB,'Enable','on');
set(handles.load_BP,'Enable','on');
set(handles.distance_DS,'Enable','on');
set(handles.distance_SM,'Enable','on');
set(handles.distance_MB,'Enable','on');
set(handles.distance_BP,'Enable','on');
set(handles.arrival,'Enable','on');
set(handles.manufacturing,'Enable','on');
set(handles.packaging,'Enable','on');
set(handles.sim_iterations,'Enable','on');
set(handles.run_sim,'Enable','on');
set(handles.reset,'Enable','off');
set(handles.save_result,'Enable','off');

set(handles.display_lead_time,'string','');
set(handles.display_standard_error,'string','');
set(handles.display_idle_time,'string','');
set(handles.saved_text,'string','');

cla

% --- Executes on button press in units_toggle.
function units_toggle1_Callback(hObject, eventdata, handles)
% hObject    handle to units_toggle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of units_toggle


% --- Executes on button press in menu.
function menu_Callback(hObject, eventdata, handles)
% hObject    handle to menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
guidata(hObject, handles);
agv_simulation
close(handles.figure1);
