function varargout = chuantong(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @chuantong_OpeningFcn, ...
                   'gui_OutputFcn',  @chuantong_OutputFcn, ...
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


function PlotUpdate(obj,events,handles)
global n w  x  t  Max
if isplaying(x)
    pause(0.05)
    t=x.CurrentSample/x.TotalSamples;
    if 1000*n<Max 
        m=w(1000*(n-1)+1:1000*n); 
        M=abs(fft(m));
        for s=1:32
            Z(s)=mean(M((s-1)*15+1:s*15));
        end
        axes(handles.axes1);
        bar(Z,'y');
        axis off;box off;
        ylim([0 10]);
        axes(handles.axes2);
        plot(m,'b');
        axis off;box off;
        axis([0 1100 -1 1]);
    end
    n=n+1;
end

% --- Executes just before chuantong is made visible.
function chuantong_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

function varargout = chuantong_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
val= get(hObject,'Value');
Fs1=handles.Fs*val*10;
t=(0:length(handles.y)-1)'/handles.Fs;
t1=(0:length(handles.y)-1)'/Fs1;   
axes(handles.axes1);
plot(t,handles.y);              
xlabel( '时间(s)');
ylabel('幅度');
title('原语音信号');
axes(handles.axes2);
plot(t1,handles.y);              
xlabel( '时间(s)');
ylabel('幅度');             
title('修改后的信号');
wavplay(handles.y,Fs1);

function slider1_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in open.
function open_Callback(hObject, eventdata, handles)
global x step w n Max 
n=1;
 [filename pathname]=uigetfile({'*.wav','ALL FILES(*.*)'},'选择声音文件');
if isequal([filename pathname],[0,0])
    return;
end
fpath=[pathname filename];%选择的声音文件路径和文件名
[temp, Fs]=wavread(fpath);%temp表示声音数据 Fs表示频率
handles.y=temp;handles.Fs=Fs;
w=handles.y;
x=audioplayer(handles.y,handles.Fs);
Max=length(handles.y);
step=fix(x.TotalSamples/handles.Fs/4);
guidata(hObject,handles);

function bofang_Callback(hObject, eventdata, handles)
global x w
handles.timer1= timer('Period',0.06,'ExecutionMode','FixedRate','TimerFcn',{@PlotUpdate,handles});
% wavplay(handles.y,handles.Fs);
stop(handles.timer1);
x=audioplayer(w,handles.Fs);
% play(x);
play(x);
if isplaying(x)
    start(handles.timer1);
end

stop(handles.timer1);


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
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
% 基音检测
[Dpitch,Dfreq,Ef,SF,voiceseg,vosl,vseg,vsl,T2]=...
    Ext_F0ztms(x,fs,wlen,inc,T1,r2,miniL,mnlong,ThrC);
    frameTime=(((1:fn)-1)*inc+wlen/2)/fs; 
    
axes(handles.axes3);
for k=1 : vsl
        line([frameTime(vseg(k).begin) frameTime(vseg(k).begin)],...
        [0 1.2],'color','b','Linestyle','-');
        line([frameTime(vseg(k).end) frameTime(vseg(k).end)],...
        [0 1.2],'color','b','Linestyle','--');
    if k==vsl
        Tx=T2(floor((vseg(k).begin+vseg(k).end)/2));
    end
end
plot(frameTime,Dpitch,'k'); hold on; xlabel('(c)')
axis([0 max(time) 0 120]); title('基音周期'); ylabel('样点值');

axes(handles.axes4);
plot(frameTime,Dfreq,'b');  hold on
axis([0 max(time) 0 450]); title('语音基音频率'); ylabel('频率/Hz');
xlabel('时间/s'); 

function lvyin_Callback(hObject, eventdata, handles)
set(hObject,'string','录音中');
pause(0.4);
duration=6; %录音时间
Fs=10000;
y=wavrecord(duration*Fs,Fs);
handles.y=y;
handles.Fs=Fs;
guidata(hObject,handles);
wavwrite(y,Fs,'x.wav'); 
set(hObject,'string','完毕');
