function varargout = steganograph(varargin)
% STEGANOGRAPH MATLAB code for steganograph.fig
%      STEGANOGRAPH, by itself, creates a new STEGANOGRAPH or raises the existing
%      singleton*.
%
%      H = STEGANOGRAPH returns the handle to a new STEGANOGRAPH or the handle to
%      the existing singleton*.
%
%      STEGANOGRAPH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STEGANOGRAPH.M with the given input arguments.
%
%      STEGANOGRAPH('Property','Value',...) creates a new STEGANOGRAPH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before steganograph_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to steganograph_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help steganograph

% Last Modified by GUIDE v2.5 25-Dec-2020 10:50:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @steganograph_OpeningFcn, ...
                   'gui_OutputFcn',  @steganograph_OutputFcn, ...
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


% --- Executes just before steganograph is made visible.
function steganograph_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to steganograph (see VARARGIN)

% Choose default command line output for steganograph
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes steganograph wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = steganograph_OutputFcn(hObject, eventdata, handles) 
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
global img1
[file path]=uigetfile(['data set/','*.pgm']);
img1=imread([path file]);
axes(handles.axes1),imshow(img1);
title('Input Image');


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%Sbox Value
Sbox=['637c777bf26b6fc53001672bfed7ab76';...
      'ca82c97dfa5947f0add4a2af9ca472c0';...
      'b7fd9326363ff7cc34a5e5f171d83115';...
      '04c723c31896059a071280e2eb27b275';...
      '09832c1a1b6e5aa0523bd6b329e32f84';...
      '53d100ed20fcb15b6acbbe394a4c58cf';...
      'd0efaafb434d338545f9027f503c9fa8';...
      '51a3408f929d38f5bcb6da2110fff3d2';...
      'cd0c13ec5f974417c4a77e3d645d1973';...
      '60814fdc222a908846eeb814de5e0bdb';...
      'e0323a0a4906245cc2d3ac629195e479';...
      'e7c8376d8dd54ea96c56f4ea657aae08';...
      'ba78252e1ca6b4c6e8dd741f4bbd8b8a';...
      '703eb5664803f60e613557b986c11d9e';...
      'e1f8981169d98e949b1e87e9ce5528df';...
      '8ca1890dbfe6426841992d0fb054bb16'];

