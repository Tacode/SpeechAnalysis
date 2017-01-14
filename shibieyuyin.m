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
set(hObject,'string','¼����');
pause(0.4);
duration=5; %¼��ʱ��
Fs=10000;
y=wavrecord(duration*Fs,Fs);
handles.y=y;
handles.Fs=Fs;
guidata(hObject,handles);
xx=y;
xx=xx-mean(xx);                           % ȥ��ֱ������
x=xx/max(abs(xx));                        % ��ֵ��һ��
lx=length(x);                             % ���ݳ���
time=(0:lx-1)/Fs;                         % �����Ӧ��ʱ������
set(hObject,'string','���');
axes(handles.axes1);
plot(time,x,'k'); title('ԭʼ��������'); 
axis([0 max(time) -1 1]); xlabel('ʱ��/s'); ylabel('��ֵ')

% --- Executes on button press in shibie.
function shibie_Callback(hObject, eventdata, handles)
% hObject    handle to shibie (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
xx=handles.y;
fs=handles.Fs;
xx=xx-mean(xx);                           % ȥ��ֱ������
x=xx/max(abs(xx));                        % ��ֵ��һ��
lx=length(x);                             % ���ݳ���
time=(0:lx-1)/fs;                         % �����Ӧ��ʱ������
wlen=240;                                 % �趨֡��
inc=80;                                   % �趨֡�Ƶĳ���  
T1=0.1; r2=0.5;                           % �˵������
X=enframe(x,wlen,inc)';                   % ���ղ������з�֡
fn=size(X,2);                             % ��֡��
miniL=10;                                 % �л������֡��
mnlong=5;                                 % Ԫ���������֡��
ThrC=[10 15];                             % ��ֵ
p=12;                                     % LPC�״�
count=0;
Threshold=160;
% �������
[Dpitch,Dfreq,Ef,SF,voiceseg,vosl,vseg,vsl,T2]=...
    Ext_F0ztms(x,fs,wlen,inc,T1,r2,miniL,mnlong,ThrC);
    frameTime=(((1:fn)-1)*inc+wlen/2)/fs; 
%%%%%%%%%%%%%%%%%��ʶ�����%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    temp=Dfreq(find(Dfreq~=0));
    for i=1:length(temp)
        if temp(i)>Threshold
            count=count+1;
        end
    end
    ratio=count/length(temp);
    if ratio>0.9
        flags=1;
        disp('�������Ϊ��Ů��');
    else
        flags=0;
        disp('�������Ϊ������');
    end 

h=dialog('name','��Ů��ʶ��','position',[100 200 200 70]);
movegui(h, 'center');
if flags==1  
uicontrol('parent',h,'style','text','string','���Ϊ��Ů����','position',[40 40 120 20],'fontsize',12); 
elseif flags==0 
  uicontrol('parent',h,'style','text','string','���Ϊ��������','position',[40 40 120 20],'fontsize',12);
else
  uicontrol('parent',h,'style','text','string','������ʶ��','position',[40 40 120 20],'fontsize',12);
end
uicontrol('parent',h,'style','pushbutton','position',...  
   [80 10 50 20],'string','ȷ��','callback','delete(gcbf)');  
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
axis([0 max(time) 0 450]); title('ԭʼ��������Ƶ��'); ylabel('Ƶ��/Hz');
xlabel('ʱ��/s'); 
hold off;


% --- Executes on button press in bofang.
function bofang_Callback(hObject, eventdata, handles)
wavplay(handles.y,handles.Fs);


% --- Executes on button press in dakai.
function dakai_Callback(hObject, eventdata, handles)
 [filename pathname]=uigetfile({'*.wav','ALL FILES(*.*)'},'ѡ�������ļ�');
if isequal([filename pathname],[0,0])
    return;
end
str=[pathname filename];%ѡ��������ļ�·�����ļ���
[temp Fs]=wavread(str);%temp��ʾ�������� Fs��ʾƵ��
handles.y=temp;handles.Fs=Fs;
guidata(hObject,handles);
xx=handles.y;
xx=xx-mean(xx);                           % ȥ��ֱ������
x=xx/max(abs(xx));                        % ��ֵ��һ��
lx=length(x);                             % ���ݳ���
time=(0:lx-1)/Fs;                         % �����Ӧ��ʱ������
axes(handles.axes1);
plot(time,x,'k'); title('ԭʼ��������'); 
axis([0 max(time) -1 1]); xlabel('ʱ��/s'); ylabel('��ֵ')
