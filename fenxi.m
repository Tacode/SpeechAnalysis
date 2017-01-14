function varargout = fenxi(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @fenxi_OpeningFcn, ...
                   'gui_OutputFcn',  @fenxi_OutputFcn, ...
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


% --- Executes just before fenxi is made visible.
function fenxi_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
h = handles.output; %返回其句柄
newIcon = javax.swing.ImageIcon('logo.gif')
figFrame = get(h,'JavaFrame'); %取得Figure的JavaFrame。
figFrame.setFigureIcon(newIcon); %修改图标

function varargout = fenxi_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;


% --- Executes on button press in luyin.
function luyin_Callback(hObject, eventdata, handles)
if get(hObject,'Value')
    set(handles.luyinpinlv,'Enable','on');
    set(handles.dakai,'Value',0);
    set(handles.luyinshijian,'Enable','on');
    set(handles.luyinqueding,'Enable','on');
    set(handles.dakaiqueding,'Enable','off');
    set(handles.bofang,'Value',0);
    set(handles.bofangpinlv,'Enable','off');
    set(handles.bofangsulv,'Enable','off');
    set(handles.bofangqueding,'Enable','off');
    set(handles.huixiang,'Enable','off');
    set(handles.huiyin,'Enable','off');
    set(handles.daofang,'Enable','off');
    set(handles.luyinqueding,'string','开始');
    set(handles.bofangsulv,'Enable','off');
else
end;

% Hint: get(hObject,'Value') returns toggle state of luyin


% --- Executes on button press in dakai.
function dakai_Callback(hObject, eventdata, handles)
% hObject    handle to dakai (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value')
    set(handles.luyin,'Value',0);
    set(handles.luyinshijian,'Enable','off');
    set(handles.luyinqueding,'Enable','off');
    set(handles.dakaiqueding,'Enable','on');
    set(handles.bofang,'Value',0);
    set(handles.bofangpinlv,'Enable','off');
    set(handles.bofangsulv,'Enable','off');
    set(handles.bofangqueding,'Enable','off');
    set(handles.luyinpinlv,'Enable','off');
    set(handles.huixiang,'Enable','off');
    set(handles.huiyin,'Enable','off');
    set(handles.daofang,'Enable','off');
else
end;
% Hint: get(hObject,'Value') returns toggle state of dakai


% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)

function luyinqueding_Callback(hObject, eventdata, handles)
% hObject    handle to luyinqueding (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(hObject,'string','录音中');
pause(0.4);
Fs=str2double(get(handles.luyinpinlv,'String'));
t=str2double(get(handles.luyinshijian,'String'));
% ai=analoginput('winsound',1);%初始化录音麦克
% chanel=addchannel(ai,1);%1表示单声道
% set(ai,'SampleRate',Fs); 
duration=t; %录音时间
% set(ai,'SamplesPerTrigger',duration*Fs);
% start(ai); 
% y=0;time=0;
% [y,time]=getdata(ai);%读出相应的数据
y=wavrecord(duration*Fs,Fs);
handles.y=y;
handles.Fs=Fs;
guidata(hObject,handles);
wavwrite(y,Fs,'y.wav'); 

% plot(handles.huitu2,handles.y)%画出声音波形
% title(handles.huitu2,'时域图');
ysize=size(handles.y);
set(hObject,'string','完毕');
set(handles.yuchuliqd,'Enable','on');
set(handles.fuliyebianhuan,'Enable','on');
set(handles.baocun,'Enable','on');
set(handles.biansheng,'Enable','on');
 
 
% --- Executes on button press in dakaiqueding.
function dakaiqueding_Callback(hObject, eventdata, handles)
% hObject    handle to dakaiqueding (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 [filename pathname]=uigetfile({'*.wav','ALL FILES(*.*)'},'选择声音文件');
if isequal([filename pathname],[0,0])
    return;
end
str=[pathname filename];%选择的声音文件路径和文件名
[temp Fs]=wavread(str);%temp表示声音数据 Fs表示频率
handles.y=temp;handles.Fs=Fs;
handles.xuanze=2;
guidata(hObject,handles);
% set(handles.yuchuli,'Enable','on');
set(handles.yuchuliqd,'Enable','on');
set(handles.fuliyebianhuan,'Enable','on');
set(handles.baocun,'Enable','on');
% set(handles.biansheng,'Enable','on'); 
set(handles.bofang,'Enable','on');
    set(handles.huixiang,'Enable','on');
    set(handles.huiyin,'Enable','on');
    set(handles.daofang,'Enable','on');
% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)

function luyinshijian_Callback(hObject, eventdata, handles)

function luyinshijian_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in bofang.
function bofang_Callback(hObject, eventdata, handles)
if get(hObject,'Value')
    set(handles.luyin,'Value',0);
    set(handles.luyinshijian,'Enable','off');
    set(handles.luyinqueding,'Enable','off');
    set(handles.dakaiqueding,'Enable','off');
    set(handles.dakai,'Value',0);
    set(handles.bofangpinlv,'Enable','on');
    set(handles.bofangsulv,'Enable','on');
    set(handles.bofangqueding,'Enable','on');
    set(handles.luyinpinlv,'Enable','off');
else
end;




function bofangpinlv_Callback(hObject, eventdata, handles)

function bofangpinlv_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in bofangqueding.
function bofangqueding_Callback(hObject, eventdata, handles)

c=handles.Fs;
% contents = cellstr(get(handles.bofangpinlv,'String')) ;%获取listbox1中的细胞矩阵
% choose=contents{get(handles.bofangpinlv,'Value')};%获取listbox中的值
% contents2 = cellstr(get(handles.bofangsulv,'String')) ;%获取listbox1中的细胞矩阵
% choose2=contents2{get(handles.bofangsulv,'Value')};%获取listbox中的值

choose1 = get (handles.bofangpinlv,'Value');
choose2 = get (handles.bofangsulv,'Value');
global flags;
switch choose1
    case 1  %默认频率
%         handles.ys=handles.y;
%         guidata(hObject,handles);
%         jiyin(handles);
        switch choose2
            case 1
%                   biansu(handles,1);
                handles.ys=Process(handles,1,1);
            case 2
%                   biansu(handles,0.5);
                handles.ys=Process(handles,1,0.5);
            case 3
%                   biansu(handles,1.5);
               handles.ys= Process(handles,1,1.5);
            case 4
%                   biansu(handles,2.0);
                handles.ys=Process(handles,1,2.0);
        end
    case 2 %男声
%         handles.ys=womanToman(handles);
%         guidata(hObject,handles);
%         jiyin(handles);
        if flags==0
            h=errordlg('警告,不能转换','错误'); 
             return
        end
        switch choose2
            case 1
%                   biansu(handles,1);
                 handles.ys=Process(handles,0.45,1);
            case 2
%                   biansu(handles,0.5);
                handles.ys= Process(handles,0.45,0.5);
            case 3
%                   biansu(handles,1.5);
                 handles.ys=Process(handles,0.5,1.5);
            case 4
%                   biansu(handles,2.0);
                 handles.ys=Process(handles,0.5,2.0);
        end
    case 3 %女声
        if flags==1
            h=errordlg('警告,不能转换','错误'); 
             return
        end
        switch choose2
            case 1
%                   biansu(handles,1);
                 handles.ys=Process(handles,2.2,1);
            case 2
%                   biansu(handles,0.5);
                  handles.ys=Process(handles,2.2,0.5);
            case 3
%                   biansu(handles,1.5);
                  handles.ys=Process(handles,2.2,1.5);
            case 4
%                   biansu(handles,2.0);
                  handles.ys=Process(handles,2.2,2);
        end
    case 4 %童声
%         handles.ys=tongsheng(handles);
%         guidata(hObject,handles);
%         jiyin(handles);
        if flags==1
        switch choose2
           case 1
%                   biansu(handles,1);
                  handles.ys=Process(handles,1.5,1);
            case 2
%                   biansu(handles,0.5);
                 handles.ys= Process(handles,1.5,0.5);
            case 3
%                   biansu(handles,1.5);
                 handles.ys= Process(handles,1.5,1.5);
            case 4
%                   biansu(handles,2.0);
                  handles.ys=Process(handles,1.5,2);
        end
        else
        switch choose2
           case 1
%                   biansu(handles,1);
                 handles.ys= Process(handles,3,1);
            case 2
%                   biansu(handles,0.5);
                  handles.ys=Process(handles,3,0.5);
            case 3
%                   biansu(handles,1.5);
                  handles.ys=Process(handles,3,1.5);
            case 4
%                   biansu(handles,2.0);
                  handles.ys=Process(handles,3,2);
        end
        end
    case 5 %老人声
%         handles.ys=oldman(handles);
%         guidata(hObject,handles);
%         jiyin(handles);
        if flags==1
         switch choose2
              case 1
%                   biansu(handles,1);
                  handles.ys=Process(handles,0.2,1);
              case 2
%                   biansu(handles,0.5);
                 handles.ys= Process(handles,0.2,0.5);
              case 3
%                   biansu(handles,1.5);
                 handles.ys= Process(handles,0.2,1.5);
              case 4
%                   biansu(handles,2.0);
                 handles.ys= Process(handles,0.2,2);
          end
        else
         switch choose2
           case 1
                  handles.ys=Process(handles,0.55,1);
            case 2
                  handles.ys=Process(handles,0.55,0.5);
            case 3
                  handles.ys=Process(handles,0.55,1.5);
            case 4
                  handles.ys=Process(handles,0.55,2);
        end
        end
end
guidata(hObject,handles);

function luyinpinlv_Callback(hObject, eventdata, handles)
function luyinpinlv_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function xianshi_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function xianshi_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in yuchuliqd.
function yuchuliqd_Callback(hObject, eventdata, handles)
global flags;
flags=shibie(handles);
h=dialog('name','男女声识别','position',[200 200 200 70]);
movegui(h, 'center');
if flags==1  
uicontrol('parent',h,'style','text','string','辨别为：女声！','position',[50 40 120 20],'fontsize',12); 
else 
  uicontrol('parent',h,'style','text','string','辨别为：男声！','position',[50 40 120 20],'fontsize',12);
end
uicontrol('parent',h,'style','pushbutton','position',...  
   [80 10 50 20],'string','确定','callback','delete(gcbf)');  



function yuchuli_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in fuliyebianhuan.
function fuliyebianhuan_Callback(hObject, eventdata, handles)

  temp=handles.y;
 Fs=handles.Fs;
 len=max(size(temp));%读出声音数据文件的长度
[sel,ok]=listdlg('ListString',{'默认长度','128','256','512','1024','2048','4096','8192','16384','32768','65536'},... 
'name','选择FFT变换的点数', 'OKstring','确定', ...
'Cancelstring','取消', 'SelectionMode','single','ListSize',[250 150]);
data_frequency=[len,128,256,512,1024,2048,4096,8192,16384,32768,65536];
if ok==1
    M=data_frequency(sel);
    y=temp(1:M);%取前M个数据做变换
     s=length(y); 
     zh=fft(y,s);              %做FFT变换
      f=0:Fs/s:Fs*(s-1)/s;  %计算频率
     
  plot(handles.huitu2,f(1:M/2),zh(1:M/2))
  set(handles.huitu2,'Xgrid','on');
  set(handles.huitu2,'Ygrid','on');
      legend('频谱图');
  xlabel(handles.huitu2,'频率');
    ylabel(handles.huitu2,'振幅');
     
else
end


% --- Executes on button press in baocun.
function baocun_Callback(hObject, eventdata, handles)
Fs=handles.Fs;
[sel,ok]=listdlg('ListString',{'默认频率','6000','8000','11025','16000','22050','32000','44100','48000','96000'},... 
'name','选择保存的频率', 'OKstring','确定', ...
'Cancelstring','取消', 'SelectionMode','single','ListSize',[240 120]);
data_frequency=[Fs,6000,8000,11025,16000,22050,32000,44100,48000,96000];


if ok==1
    fs=data_frequency(sel);
     [filename]=uiputfile({'*.wav'},'文件保存');
wavwrite(handles.y,fs,filename);%data表示声音数据
else
end;


% --- Executes on button press in biansheng.
function biansheng_Callback(hObject, eventdata, handles)
set(hObject,'string','处理中，请稍后');


	


% --- Executes on selection change in bofangsulv.
function bofangsulv_Callback(hObject, eventdata, handles)




function bofangsulv_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function Menu_Callback(hObject, eventdata, handles)
% hObject    handle to Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to shibieyuyin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function shibieyuyin_Callback(hObject, eventdata, handles)
% hObject    handle to shibieyuyin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
run 'shibieyuyin.m'


% --------------------------------------------------------------------
function shibieyuyin_Callback(hObject, eventdata, handles)
% hObject    handle to shibieyuyin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
run 'shibieyuyin.m'


% --------------------------------------------------------------------
function chuantong_Callback(hObject, eventdata, handles)
% hObject    handle to chuantong (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
run 'chuantong.m';

% --------------------------------------------------------------------
function chuan_Callback(hObject, eventdata, handles)
% hObject    handle to chuan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
run 'chuantong.m'


% --- Executes on button press in huiyin.
function huiyin_Callback(hObject, eventdata, handles)

x_delay=[zeros(handles.Fs/2,1);handles.ys]; %延时0.5秒
t=(0:length(x_delay)-1)/handles.Fs;
x_x=[handles.ys;zeros(handles.Fs/2,1)];
x_huisheng=x_x+0.45*x_delay;  
wavplay(x_huisheng,handles.Fs);
axes(handles.huitu);
plot(t,x_x); 
title('原语音信号'); %画出原始信号的时域图
xlabel( '时间(s)');
ylabel('幅度');  
axes(handles.huitu2);
plot(t,x_huisheng); 
title('回音信号'); %画出延时1秒后的信号时域图
xlabel( '时间(s)');
ylabel('幅度'); 


function huixiang_Callback(hObject, eventdata, handles)

x_delay=[zeros(handles.Fs/2,1);handles.ys;zeros(handles.Fs/2,1)]; %延时0.5秒
x_delay_delay=[zeros(handles.Fs/2,1);zeros(handles.Fs/2,1);handles.ys]; %反馈回去，再延0.5s
t=(0:length(x_delay)-1)/handles.Fs;
x_x=[handles.ys;zeros(handles.Fs/2,1);zeros(handles.Fs/2,1)];
x_huisheng=x_x+0.65*x_delay+0.65*x_delay_delay; %模拟回响效果    
wavplay(x_huisheng,handles.Fs);
axes(handles.huitu);
plot(t,x_x); 
title('原语音信号'); %画出原始信号的时域图
xlabel( '时间(s)');
ylabel('幅度');
axes(handles.huitu2);
plot(t,x_huisheng); 
title('回响信号'); %画出回响信号时域图
xlabel( '时间(s)');
ylabel('幅度'); 


function daofang_Callback(hObject, eventdata, handles)
i=1:length(handles.ys);
j=length(handles.ys):-1:1;
x_reversal(j)=handles.ys(i); %实现声音数据颠倒
t=(0:length(handles.ys)-1)/handles.Fs;
axes(handles.huitu);
plot(t,handles.ys);              
title('原语音信号'); %画出原始信号的时域图
xlabel( '时间(s)');
ylabel('幅度');
axes(handles.huitu2);
plot(t,x_reversal);              
title('倒放信号'); %画出回响信号时域图
xlabel( '时间(s)');
ylabel('幅度'); 
wavplay(x_reversal,handles.Fs);


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
val= get(hObject,'Value');
t=(0:length(handles.ys)-1)/handles.Fs;          
axes(handles.huitu);
plot(t,handles.ys); 
title('原语音信号'); %画出原始信号的时域图
xlabel( '时间(s)');
ylabel('幅度');
x_up=handles.ys*10*val; 
axes(handles.huitu2);
plot(t,x_up); 
title('放大信号'); 
xlabel( '时间(s)');
ylabel('幅度'); 
wavplay(x_up,handles.Fs);

function slider2_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
