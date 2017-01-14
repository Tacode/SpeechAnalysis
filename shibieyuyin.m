function varargout = shibieyuyin(varargin)
% SHIBIEYUYIN MATLAB code for shibieyuyin.fig
%      SHIBIEYUYIN, by itself, creates a new SHIBIEYUYIN or raises the existing
%      singleton*.
%
%      H = SHIBIEYUYIN returns the handle to a new SHIBIEYUYIN or the handle to
%      the existing singleton*.
%
%      SHIBIEYUYIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SHIBIEYUYIN.M with the given input arguments.
%
%      SHIBIEYUYIN('Property','Value',...) creates a new SHIBIEYUYIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before shibieyuyin_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to shibieyuyin_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help shibieyuyin

% Last Modified by GUIDE v2.5 15-Dec-2016 23:44:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @shibieyuyin_OpeningFcn, ...
                   'gui_OutputFcn',  @shibieyuyin_OutputFcn, ...
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


% --- Executes just before shibieyuyin is made visible.
function shibieyuyin_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to shibieyuyin (see VARARGIN)

% Choose default command line output for shibieyuyin
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes shibieyuyin wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = shibieyuyin_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in lvyin.
function lvyin_Callback(hObject, eventdata, handles)
% hObject    handle to lvyin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(hObject,'string','录音中');
pause(0.4);
duration=5; %录音时间
Fs=10000;
y=wavrecord(duration*Fs,Fs);
handles.y=y;
handles.Fs=Fs;
guidata(hObject,handles);
xx=y;
xx=xx-mean(xx);                           % 去除直流分量
x=xx/max(abs(xx));                        % 幅值归一化
lx=length(x);                             % 数据长度
time=(0:lx-1)/Fs;                         % 求出对应的时间序列
set(hObject,'string','完毕');
axes(handles.axes1);
plot(time,x,'k'); title('原始语音波形'); 
axis([0 max(time) -1 1]); xlabel('时间/s'); ylabel('幅值')

% --- Executes on button press in shibie.
function shibie_Callback(hObject, eventdata, handles)
% hObject    handle to shibie (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
xx=handles.y;
fs=handles.Fs;
xx=xx-mean(xx);                           % 去除直流分量
x=xx/max(abs(xx));                        % 幅值归一化
lx=length(x);                             % 数据长度
time=(0:lx-1)/fs;                         % 求出对应的时间序列
wlen=240;                                 % 设定帧长
inc=80;                                   % 设定帧移的长度  
T1=0.1; r2=0.5;                           % 端点检测参数
X=enframe(x,wlen,inc)';                   % 按照参数进行分帧
fn=size(X,2);                             % 总帧数
miniL=10;                                 % 有话段最短帧数
mnlong=5;                                 % 元音主体最短帧数
ThrC=[10 15];                             % 阈值
p=12;                                     % LPC阶次
count=0;
Threshold=160;
% 基音检测
[Dpitch,Dfreq,Ef,SF,voiceseg,vosl,vseg,vsl,T2]=...
    Ext_F0ztms(x,fs,wlen,inc,T1,r2,miniL,mnlong,ThrC);
    frameTime=(((1:fn)-1)*inc+wlen/2)/fs; 
%%%%%%%%%%%%%%%%%简单识别程序%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    temp=Dfreq(find(Dfreq~=0));
    for i=1:length(temp)
        if temp(i)>Threshold
            count=count+1;
        end
    end
    ratio=count/length(temp);
    if ratio>0.9
        flags=1;
        disp('辨别语音为：女声');
    else
        flags=0;
        disp('辨别语音为：男声');
    end 

h=dialog('name','男女声识别','position',[100 200 200 70]);
movegui(h, 'center');
if flags==1  
uicontrol('parent',h,'style','text','string','辨别为：女声！','position',[40 40 120 20],'fontsize',12); 
elseif flags==0 
  uicontrol('parent',h,'style','text','string','辨别为：男声！','position',[40 40 120 20],'fontsize',12);
else
  uicontrol('parent',h,'style','text','string','请重新识别！','position',[40 40 120 20],'fontsize',12);
end
uicontrol('parent',h,'style','pushbutton','position',...  
   [80 10 50 20],'string','确定','callback','delete(gcbf)');  
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
axes(handles.axes2);
for k=1 : vsl
        line([frameTime(vseg(k).begin) frameTime(vseg(k).begin)],...
        [0 1.2],'color','b','Linestyle','-');
        line([frameTime(vseg(k).end) frameTime(vseg(k).end)],...
        [0 1.2],'color','b','Linestyle','--');
    if k==vsl
        Tx=T2(floor((vseg(k).begin+vseg(k).end)/2));
    end
end
% text(2.6,Tx+0.05,'T2');
plot(frameTime,Dfreq,'b');  
grid
hold on
plot(frameTime,Threshold,'r--');
axis([0 max(time) 0 450]); title('原始语音基音频率'); ylabel('频率/Hz');
xlabel('时间/s'); 
hold off;


% --- Executes on button press in bofang.
function bofang_Callback(hObject, eventdata, handles)
wavplay(handles.y,handles.Fs);


% --- Executes on button press in dakai.
function dakai_Callback(hObject, eventdata, handles)
 [filename pathname]=uigetfile({'*.wav','ALL FILES(*.*)'},'选择声音文件');
if isequal([filename pathname],[0,0])
    return;
end
str=[pathname filename];%选择的声音文件路径和文件名
[temp Fs]=wavread(str);%temp表示声音数据 Fs表示频率
handles.y=temp;handles.Fs=Fs;
guidata(hObject,handles);
xx=handles.y;
xx=xx-mean(xx);                           % 去除直流分量
x=xx/max(abs(xx));                        % 幅值归一化
lx=length(x);                             % 数据长度
time=(0:lx-1)/Fs;                         % 求出对应的时间序列
axes(handles.axes1);
plot(time,x,'k'); title('原始语音波形'); 
axis([0 max(time) -1 1]); xlabel('时间/s'); ylabel('幅值')
