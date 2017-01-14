%语音识别男女
% clear all; clc; close all;
% filedir=[];                               % 设置数据文件的路径
% filename='y.wav';                % 设置数据文件的名称
% fle=[filedir filename];                    % 构成路径和文件名的字符串
% [xx,fs]=wavread(fle);                     % 读取文件
% fs=10000;
% duration=3;
% xx=wavrecord(duration*fs,fs);
function flags=shibie(handles)
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
    temp
    for i=1:length(temp)
        if temp(i)>Threshold
            count=count+1;
        end
    end
    count
    ratio=count/length(temp);
%     if ratio>0.9
%         disp('辨别语音为：女声');
%     else
%         disp('辨别语音为：男声');
%     end   
    if ratio>0.6
       flags=1;  %女声
    else
       flags=0;   %男声
    end   
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
 axes(handles.huitu4);
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
end

