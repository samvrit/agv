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

% Last Modified by GUIDE v2.5 11-Nov-2017 23:53:15

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
% This sets up the initial plot - only do when we are invisible
% so window can get raised using agv_montecarlo.
if strcmp(get(hObject,'Visible'),'off')
    %plot(rand(5));
    xlabel('System Lead Time (h)');
end

set(handles.display_lead_time,'String','');
if nargin == 4
    data_tuple = varargin{1};
    agv_speed = data_tuple(1,1);
    agv_count = data_tuple(1,2:5);
    agv_mean_load = data_tuple(1,6:9);
    agv_node_distances = data_tuple(1,10:13);
    arrival_rate = data_tuple(1,14);
    mfg_rate = data_tuple(1,15);
    pkg_rate = data_tuple(1,16);
    lead_time_requirement = data_tuple(1,19);
    idle_time_requirement = data_tuple(1,20);
        
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
% UIWAIT makes agv_montecarlo wait for user response (see UIRESUME)
% uiwait(handles.figure1);
handles.timer = timer(...
    'ExecutionMode', 'fixedRate', ...       % Run timer repeatedly.
    'Period', 0.1, ...                        % Initial period is 1 sec.
    'TimerFcn', {@update_display_mc, handles}); % Specify callback function.
start(handles.timer)    % start the timer


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
set(handles.run_sim,'Enable','off');
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
ste = str2double(get(handles.display_standard_error_lead_time,'string'));
button_state = get(hObject,'Value');
if button_state == get(handles.units_toggle,'Max')
    set(hObject,'Value',button_state);
	set(handles.display_lead_time,'string',num2str(round(lead_time*60,2)));
    set(handles.display_standard_error_lead_time,'string',num2str(round(ste*60,2)));
    set(handles.lead_time_text,'string','Mean System Lead Time (min)');
elseif button_state == get(handles.units_toggle,'Min')
    set(hObject,'Value',button_state);
	set(handles.display_lead_time,'string',num2str(round(lead_time/60,2)));
    set(handles.display_standard_error_lead_time,'string',num2str(round(ste/60,2)));
    set(handles.lead_time_text,'string','Mean System Lead Time (hours)');
end

% --- Executes on slider movement.
function speed_Callback(hObject, eventdata, handles)
% hObject    handle to speed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
update_display_mc(hObject,eventdata,handles);

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
update_display_mc(hObject,eventdata,handles);

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
update_display_mc(hObject,eventdata,handles);

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
update_display_mc(hObject,eventdata,handles);

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
update_display_mc(hObject,eventdata,handles);

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
update_display_mc(hObject,eventdata,handles);

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
update_display_mc(hObject,eventdata,handles);

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
update_display_mc(hObject,eventdata,handles);

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
update_display_mc(hObject,eventdata,handles);

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
update_display_mc(hObject,eventdata,handles);

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
update_display_mc(hObject,eventdata,handles);

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
update_display_mc(hObject,eventdata,handles);

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
update_display_mc(hObject,eventdata,handles);

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
update_display_mc(hObject,eventdata,handles);

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
update_display_mc(hObject,eventdata,handles);

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
update_display_mc(hObject,eventdata,handles);

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
handles.output = 1;
delete(hObject);

function update_display_mc(hObject, eventdata, handles)
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

toggle_button_state = get(handles.units_toggle,'Value');
if toggle_button_state
    lead_time_requirement = lead_time_requirement*60;
end

data_tuple_def = [agv_speed,agv_count,agv_mean_load,node_distances,arrival_rate,mfg_rate,pkg_rate,0,0,0,0,0,lead_time_requirement,idle_time_requirement];
set(handles.data_tuple_default,'Value',data_tuple_def);

lead_time = get(handles.display_lead_time,'String');
if strcmp(lead_time,'')
    set(handles.req_status,'BackgroundColor',[0.94 0.94 0.94]);
    set(handles.req_status,'String','');
else
    lead_time = str2double(lead_time);
    idle_time = str2double(get(handles.display_idle_time,'String'));
    if (lead_time <= lead_time_requirement) && (idle_time <= idle_time_requirement)
        set(handles.req_status,'BackgroundColor',[0 1 0]);
        set(handles.req_status,'ForegroundColor',[0 0 0]);
        set(handles.req_status,'String','Requirements met!');
    else
        set(handles.req_status,'BackgroundColor',[1 0 0]);
        set(handles.req_status,'ForegroundColor',[1 1 1]);
        set(handles.req_status,'String','Requirements not met!');
    end
end

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
set(handles.run_sim,'Enable','off');
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
set(handles.iterations,'Enable','off');
set(handles.reset_inputs,'Enable','off');
pause(0.05);

agv_speed = round(get(handles.speed,'value'),1);
set(handles.display_speed,'string',agv_speed);

n_DS = round(get(handles.count_DS,'value'));
n_SM = round(get(handles.count_SM,'value'));
n_MB = round(get(handles.count_MB,'value'));
n_BP = round(get(handles.count_BP,'value'));

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
n = str2double(get(handles.iterations,'string'));
arrival_rate = str2double(get(handles.arrival,'string'));
mfg_rate = str2double(get(handles.manufacturing,'string'));
pkg_rate = str2double(get(handles.packaging,'string'));

lead_time_requirement = str2double(get(handles.lead_time_req,'String'));
idle_time_requirement = str2double(get(handles.idle_time_req,'String'));

[lead_time, ste1, idle_time, ste2, total_wait_time, simulation_time, simulation_runtime, cumulative_avg] = montecarlo(agv_speed,agv_mean_load, agv_count, arrival_rate, node_distances, mfg_rate, pkg_rate, t, n);
data_tuple = [agv_speed,agv_count,agv_mean_load,node_distances,arrival_rate,mfg_rate,pkg_rate,lead_time,ste1,idle_time,ste2,t,lead_time_requirement,idle_time_requirement];
set(handles.data_tuple_hidden,'value',data_tuple);
set(handles.lead_time_hidden,'value',total_wait_time);
set(handles.cumulative_hidden,'value',cumulative_avg);
set(handles.lead_time_dist_hidden,'value',total_wait_time);
set(handles.mean_lead_time_hidden,'value',lead_time);

set(handles.run_sim,'Enable','on');
set(handles.lead_time_graph,'Enable','on');
set(handles.cumulative_graph,'Enable','on');
set(handles.lead_time_dist_graph,'Enable','on');
set(handles.sim_running_text,'string','Simulation completed!');
button_state = get(handles.units_toggle,'Value');
if button_state == get(handles.units_toggle,'Max')
	set(handles.display_lead_time,'string',num2str(round(lead_time*60,2)));
    set(handles.display_standard_error_lead_time,'string',num2str(round(ste1*60,2)));
    set(handles.lead_time_text,'string','Mean System Lead Time (min)');
elseif button_state == get(handles.units_toggle,'Min')
	set(handles.display_lead_time,'string',num2str(round(lead_time,2)));
    set(handles.display_standard_error_lead_time,'string',num2str(round(ste1,2)));
    set(handles.lead_time_text,'string','Mean System Lead Time (hours)');
end

if (lead_time <= lead_time_requirement) && (idle_time <= idle_time_requirement)
    set(handles.req_status,'BackgroundColor',[0 1 0]);
    set(handles.req_status,'String','Requirements met!');
else
    set(handles.req_status,'BackgroundColor',[1 0 0]);
    set(handles.req_status,'String','Requirements not met!');
end

set(handles.sim_time,'string',['Total Simulation Time: ',num2str(round(simulation_time,2)),' hours']);
set(handles.display_runtime,'string',['Simulation Runtime: ',num2str(round(simulation_runtime,2)),' seconds']);
set(handles.display_idle_time,'string',num2str(round(idle_time*100,2)));
set(handles.display_standard_error_idle_time,'string',num2str(round(ste2*100,2)));
set(handles.reset,'Enable','on');
set(handles.save_result,'Enable','on');
y1 = hist(total_wait_time,50);
y1 = y1/sum(y1);
x1 = linspace(0,max(total_wait_time),length(y1));
y2 = linspace(0,1.1*max(y1),20);
x2 = lead_time*ones(1,length(y2));
plot(x1,y1,x2,y2)
xlabel('System Lead Time (h)');
ylabel('Probability');
ylim([0 1.1*max(y1)]);

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
set(handles.iterations,'Enable','on');
set(handles.run_sim,'Enable','on');
set(handles.reset_inputs,'Enable','on');
set(handles.reset,'Enable','off');
set(handles.save_result,'Enable','off');
set(handles.lead_time_graph,'Enable','off');
set(handles.cumulative_graph,'Enable','off');
set(handles.lead_time_dist_graph,'Enable','off');

set(handles.sim_running_text,'string','');
set(handles.display_lead_time,'string','');
set(handles.display_standard_error_lead_time,'string','');
set(handles.display_standard_error_idle_time,'string','');
set(handles.display_idle_time,'string','');
set(handles.display_runtime,'string','');
set(handles.saved_text,'string','');
set(handles.sim_time,'string','');

set(handles.req_status,'BackgroundColor',[0.94 0.94 0.94]);
set(handles.req_status,'String','');

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
% close(handles.figure1);


% --- Executes on button press in analytical.
function analytical_Callback(hObject, eventdata, handles)
% hObject    handle to analytical (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
run_sim_status = get(handles.run_sim,'Enable');
if strcmp(run_sim_status,'off')
    data_tuple = get(handles.data_tuple_hidden,'value');
else
    data_tuple = get(handles.data_tuple_default,'value');
end
if data_tuple == 0.0
    agv_analytical;
else
    agv_analytical(data_tuple);
end
% close(handles.figure1);



function lead_time_req_Callback(hObject, eventdata, handles)
% hObject    handle to lead_time_req (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lead_time_req as text
%        str2double(get(hObject,'String')) returns contents of lead_time_req as a double
update_display_mc(hObject,eventdata,handles);

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
update_display_mc(hObject,eventdata,handles);

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



function iterations_Callback(hObject, eventdata, handles)
% hObject    handle to iterations (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of iterations as text
%        str2double(get(hObject,'String')) returns contents of iterations as a double


% --- Executes during object creation, after setting all properties.
function iterations_CreateFcn(hObject, eventdata, handles)
% hObject    handle to iterations (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in cumulative_graph.
function cumulative_graph_Callback(hObject, eventdata, handles)
% hObject    handle to cumulative_graph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cumulative_average = get(handles.cumulative_hidden,'value');
plot(cumulative_average);
xlabel('Iteration');
ylabel('Lead Time (h)');

% --- Executes on button press in lead_time_graph.
function lead_time_graph_Callback(hObject, eventdata, handles)
% hObject    handle to lead_time_graph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
lead_time = get(handles.lead_time_hidden,'value');
plot(lead_time);
xlabel('Iteration');
ylabel('Lead Time (h)');


% --- Executes on button press in lead_time_dist_graph.
function lead_time_dist_graph_Callback(hObject, eventdata, handles)
% hObject    handle to lead_time_dist_graph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
total_wait_time = get(handles.lead_time_hidden,'value');
lead_time = get(handles.mean_lead_time_hidden,'value');
y1 = hist(total_wait_time,50);
y1 = y1/sum(y1);
x1 = linspace(0,max(total_wait_time),length(y1));
y2 = linspace(0,1.1*max(y1),20);
x2 = lead_time*ones(1,length(y2));
plot(x1,y1,x2,y2)
xlabel('System Lead Time (h)');
ylabel('Probability');
ylim([0 1.1*max(y1)]);


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

set(handles.sim_iterations,'String','10000');
set(handles.iterations,'String','5');

update_display_mc(hObject,eventdata,handles);
