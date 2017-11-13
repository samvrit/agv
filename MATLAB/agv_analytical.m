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

% Last Modified by GUIDE v2.5 11-Nov-2017 23:37:22

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
% The following line adds a timer to the GUI, which calls the function
% 'update_display()' every 0.01 seconds and supplies the 'handles' as an
% argument to the function
handles.timer = timer(...
    'ExecutionMode', 'fixedRate', ...       % Run timer repeatedly.
    'Period', 0.1, ...                        % Initial period is 1 sec.
    'TimerFcn', {@update_display, handles}); % Specify callback function.
start(handles.timer)    % start the timer
% UIWAIT makes agv_analytical wait for user response (see UIRESUME)
% uiwait(handles.figure1);
if nargin == 4
    data_tuple = varargin{1};
    agv_speed = data_tuple(1,1);
    agv_count = data_tuple(1,2:5);
    agv_mean_load = data_tuple(1,6:9);
    agv_node_distances = data_tuple(1,10:13);
    arrival_rate = data_tuple(1,14);
    mfg_rate = data_tuple(1,15);
    pkg_rate = data_tuple(1,16);
    lead_time_requirement = data_tuple(1,23);
    idle_time_requirement = data_tuple(1,24);
        
    set(handles.speed,'Value',agv_speed);
    set(handles.count_DS,'Value',agv_count(1));
    set(handles.count_SM,'Value',agv_count(2));
    set(handles.count_MB,'Value',agv_count(3));
    set(handles.count_BP,'Value',agv_count(4));
    
    set(handles.load_DS,'String',num2str(agv_mean_load(1)));
    set(handles.load_SM,'String',num2str(agv_mean_load(2)));
    set(handles.load_MB,'String',num2str(agv_mean_load(3)));
    set(handles.load_BP,'String',num2str(agv_mean_load(4)));
    
    set(handles.distance_DS,'String',num2str(agv_node_distances(1)));
    set(handles.distance_SM,'String',num2str(agv_node_distances(2)));
    set(handles.distance_MB,'String',num2str(agv_node_distances(3)));
    set(handles.distance_BP,'String',num2str(agv_node_distances(4)));
    
    set(handles.arrival,'String',num2str(arrival_rate));
    set(handles.manufacturing,'String',num2str(mfg_rate));
    set(handles.packaging,'String',num2str(pkg_rate));
    
    set(handles.lead_time_req,'String',num2str(lead_time_requirement));
    set(handles.idle_time_req,'String',num2str(idle_time_requirement));
end
handles.timer = timer(...
    'ExecutionMode', 'fixedRate', ...       % Run timer repeatedly.
    'Period', 0.1, ...                        % Initial period is 1 sec.
    'TimerFcn', {@update_display, handles}); % Specify callback function.
start(handles.timer)

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
update_display(hObject,eventdata,handles);

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
update_display(hObject,eventdata,handles);

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
update_display(hObject,eventdata,handles);

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
update_display(hObject,eventdata,handles);

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
update_display(hObject,eventdata,handles);

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
% While closing the GUI, the timer has to be stopped and deleted. The
% following commands do that
T = timerfind;
if ~isempty(T)
    stop(T)
    delete(T)
end
delete(hObject);

% This function is called by the timer every 0.01 seconds
% This function gets all the inputs from the GUI, calls the agv_plant
% function with appropriate arguments, gets the outputs of the function and
% updates the displays
function update_display(hObject, eventdata, handles)
% Some GUI objects are sliders and others are text inputs. The information
% for sliders is in 'value', and for text inputs, they are in 'string'. The
% name of the GUI object (handles.<name>) corresponds to the 'Tag' in the
% GUI design. The data is stacked in accordance with the inputs to the
% agv_plant function.

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

arrival_rate = str2double(get(handles.arrival,'string'));
mfg_rate = str2double(get(handles.manufacturing,'string'));
pkg_rate = str2double(get(handles.packaging,'string'));

lead_time_requirement = str2double(get(handles.lead_time_req,'String'));
idle_time_requirement = str2double(get(handles.idle_time_req,'String'));

[data_table, lead_time, idle_time] = agv_plant(agv_speed,agv_mean_load, agv_count, arrival_rate, node_distances, mfg_rate, pkg_rate);
data_tuple = [agv_speed,agv_count,agv_mean_load,node_distances,arrival_rate,mfg_rate,pkg_rate,lead_time,idle_time,lead_time_requirement,idle_time_requirement];

set(handles.data_tuple_hidden,'value',data_tuple);  % store the data tuple in a hidden field so that it can be used to write into Excel
set(handles.display_data_table,'data',data_table);

% Read the toggle button status to switch between output units for System Lead Time
button_state = get(handles.units_toggle,'Value');
if button_state == get(handles.units_toggle,'Max')
	set(handles.display_lead_time,'string',num2str(lead_time*60));
    set(handles.lead_time_text,'string','System Lead Time (min)');
elseif button_state == get(handles.units_toggle,'Min')
	set(handles.display_lead_time,'string',num2str(lead_time));
    set(handles.lead_time_text,'string','System Lead Time (hours)');
end
set(handles.display_idle_time,'string',num2str(idle_time*100));

% Display a green box when system is stable, and a red box when system is
% unstable
rho_index = data_table(data_table(:,3)>=1);
if(size(rho_index,1)>0)
    set(handles.nogo,'BackgroundColor',[1 0 0]);
    set(handles.go,'BackgroundColor',[0.94 0.94 0.94]);
    set(handles.nogo,'String','System Unstable!');
    set(handles.go,'String','');
else
    set(handles.go,'BackgroundColor',[0 1 0]);
    set(handles.nogo,'BackgroundColor',[0.94 0.94 0.94]);
    set(handles.go,'String','System Stable!');
    set(handles.nogo,'String','');
end

if (lead_time <= lead_time_requirement) && (idle_time <= idle_time_requirement/100)
    set(handles.req_status,'BackgroundColor',[0 1 0]);
    set(handles.req_status,'ForegroundColor',[0 0 0]);
    set(handles.req_status,'String','Requirements met!');
else
    set(handles.req_status,'BackgroundColor',[1 0 0]);
    set(handles.req_status,'ForegroundColor',[1 1 1]);
    set(handles.req_status,'String','Requirements not met!');
end

function load_DS_Callback(hObject, eventdata, handles)
% hObject    handle to load_DS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of load_DS as text
%        str2double(get(hObject,'String')) returns contents of load_DS as a double
update_display(hObject,eventdata,handles);

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
update_display(hObject,eventdata,handles);

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
update_display(hObject,eventdata,handles);

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
update_display(hObject,eventdata,handles);

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
update_display(hObject,eventdata,handles);

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
update_display(hObject,eventdata,handles);

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
update_display(hObject,eventdata,handles);

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
update_display(hObject,eventdata,handles);

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
update_display(hObject,eventdata,handles);

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
update_display(hObject,eventdata,handles);

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
update_display(hObject,eventdata,handles);

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

% Read the Excel file, get the index of the last row, and write the data
% tuple in the next row
set(handles.save_result,'Enable','off');    % disable the button while action is being performed
pause(0.05);
A = xlsread('results_montecarlo.xlsx');
end_index = size(A,1);
write_index = end_index+2;  % 2 is added to account for the Headings row
data_tuple = get(handles.data_tuple_hidden,'value');
Alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
data_tuple_length = length(data_tuple);
end_column = Alphabet(data_tuple_length);
xlswrite('results_montecarlo.xlsx',data_tuple,['A',num2str(write_index),':',end_column,num2str(write_index)]);
set(handles.save_result,'Enable','on'); % enable the button after action is performed


% --- Executes on button press in units_toggle.
function units_toggle_Callback(hObject, eventdata, handles)
% hObject    handle to units_toggle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of units_toggle
update_display(hObject,eventdata,handles);

% --- Executes on button press in menu.
function menu_Callback(hObject, eventdata, handles)
% hObject    handle to menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
guidata(hObject, handles);
agv_simulation
% close(handles.figure1);


% --- Executes on button press in monte_carlo.
function monte_carlo_Callback(hObject, eventdata, handles)
% hObject    handle to monte_carlo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data_tuple = get(handles.data_tuple_hidden,'value');
agv_montecarlo(data_tuple);
% close(handles.figure1);



function lead_time_req_Callback(hObject, eventdata, handles)
% hObject    handle to lead_time_req (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lead_time_req as text
%        str2double(get(hObject,'String')) returns contents of lead_time_req as a double
update_display(hObject,eventdata,handles);

% --- Executes during object creation, after setting all properties.
function lead_time_req_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lead_time_req (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function idle_time_req_Callback(hObject, eventdata, handles)
% hObject    handle to idle_time_req (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of idle_time_req as text
%        str2double(get(hObject,'String')) returns contents of idle_time_req as a double
update_display(hObject,eventdata,handles);

% --- Executes during object creation, after setting all properties.
function idle_time_req_CreateFcn(hObject, eventdata, handles)
% hObject    handle to idle_time_req (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in reset_inputs.
function reset_inputs_Callback(hObject, eventdata, handles)
% hObject    handle to reset_inputs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.speed,'Value',4.9);
set(handles.count_DS,'Value',10);
set(handles.count_SM,'Value',11);
set(handles.count_MB,'Value',15);
set(handles.count_BP,'Value',16);

set(handles.load_DS,'String','1');
set(handles.load_SM,'String','1');
set(handles.load_MB,'String','1');
set(handles.load_BP,'String','1');

set(handles.arrival,'String','200');
set(handles.manufacturing,'String','300');
set(handles.packaging,'String','600');

set(handles.distance_DS,'String','0.04');
set(handles.distance_SM,'String','0.04');
set(handles.distance_MB,'String','0.04');
set(handles.distance_BP,'String','0.04');

set(handles.lead_time_req,'String','0.5');
set(handles.idle_time_req,'String','50');

update_display(hObject,eventdata,handles);
