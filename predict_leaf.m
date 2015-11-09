function varargout = predict_leaf(varargin)
 addpath(genpath('.\predict_leaf'));
% PREDICT_LEAF MATLAB code for predict_leaf.fig
%      PREDICT_LEAF, by itself, creates a new PREDICT_LEAF or raises the existing
%      singleton*.
%
%      H = PREDICT_LEAF returns the handle to a new PREDICT_LEAF or the handle to
%      the existing singleton*.
%
%      PREDICT_LEAF('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PREDICT_LEAF.M with the given input arguments.
%
%      PREDICT_LEAF('Property','Value',...) creates a new PREDICT_LEAF or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before predict_leaf_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to predict_leaf_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help predict_leaf

% Last Modified by GUIDE v2.5 22-Apr-2015 02:27:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @predict_leaf_OpeningFcn, ...
                   'gui_OutputFcn',  @predict_leaf_OutputFcn, ...
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


% --- Executes just before predict_leaf is made visible.
function predict_leaf_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to predict_leaf (see VARARGIN)

% Choose default command line output for predict_leaf
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes predict_leaf wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = predict_leaf_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in webcam.
function webcam_Callback(hObject, eventdata, handles)
% hObject    handle to webcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global x;
x=0;
%%edit this url based on what you get on your ipcamera screen
%%---------------------------------------------------
url = 'http://192.168.43.1:8080/shot.jpg';
%%-------------------------------------------------
ss  = imread(url);
while(1)
ss  = imread(url);
figure(1),imshow(ss);
drawnow; 
if x == 1
    break
end    
end
%%specify where you want to save the image--------------------------------
%% edit this---------------------------------------------------------
imwrite(ss,'.\predict_leaf\predict\original_image.jpg');   
%%---------------------------------------------------------------------
% --- Executes on button press in click_picture.
function click_picture_Callback(hObject, eventdata, handles)
% hObject    handle to click_picture (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global x;
x=1;

% --- Executes on button press in predict.
function predict_Callback(hObject, eventdata, handles)
% hObject    handle to predict (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pred = num2str(process_predict_leaf());
name=strcat('This leaf belongs to class ','   ',pred);
set(handles.prediction,'string',name);


% --- Executes on button press in chlorophyll.
function chlorophyll_Callback(hObject, eventdata, handles)
% hObject    handle to chlorophyll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
chloro =num2str( predict_chlorophyll());
name=strcat('chlorophyll content is ','   ',chloro);
set(handles.chloro_val,'string',name);



% --- Executes on button press in nitrogen.
function nitrogen_Callback(hObject, eventdata, handles)
% hObject    handle to nitrogen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
nitro=num2str(predict_nitrogen());
name=strcat('Nitrogen content is ','   ',nitro);
set(handles.Nitrogen_val,'string',name);
