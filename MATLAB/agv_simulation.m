function varargout = agv_simulation(varargin)
% AGV_SIMULATION MATLAB code for agv_simulation.fig
%      AGV_SIMULATION, by itself, creates a new AGV_SIMULATION or raises the existing
%      singleton*.
%
%      H = AGV_SIMULATION returns the handle to a new AGV_SIMULATION or the handle to
%      the existing singleton*.
%
%      AGV_SIMULATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AGV_SIMULATION.M with the given input arguments.
%
%      AGV_SIMULATION('Property','Value',...) creates a new AGV_SIMULATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before agv_simulation_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to agv_simulation_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help agv_simulation

% Last Modified by GUIDE v2.5 05-Nov-2017 18:12:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @agv_simulation_OpeningFcn, ...
                   'gui_OutputFcn',  @agv_simulation_OutputFcn, ...
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


% --- Executes just before agv_simulation is made visible.
function agv_simulation_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to agv_simulation (see VARARGIN)

% Choose default command line output for agv_simulation
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes agv_simulation wait for user response (see UIRESUME)
% uiwait(handles.figure1);
image = imread('queue.png');
axes(handles.axes1);
imshow(image);

% --- Outputs from this function are returned to the command line.
function varargout = agv_simulation_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in analytical.
function analytical_Callback(hObject, eventdata, handles)
% hObject    handle to analytical (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
agv_analytical
close(handles.figure1);

% --- Executes on button press in montecarlo.
function montecarlo_Callback(hObject, eventdata, handles)
% hObject    handle to montecarlo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
agv_montecarlo
close(handles.figure1);
