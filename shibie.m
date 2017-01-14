%����ʶ����Ů
% clear all; clc; close all;
% filedir=[];                               % ���������ļ���·��
% filename='y.wav';                % ���������ļ�������
% fle=[filedir filename];                    % ����·�����ļ������ַ���
% [xx,fs]=wavread(fle);                     % ��ȡ�ļ�
% fs=10000;
% duration=3;
% xx=wavrecord(duration*fs,fs);
function flags=shibie(handles)
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
    temp
    for i=1:length(temp)
        if temp(i)>Threshold
            count=count+1;
        end
    end
    count
    ratio=count/length(temp);
%     if ratio>0.9
%         disp('�������Ϊ��Ů��');
%     else
%         disp('�������Ϊ������');
%     end   
    if ratio>0.6
       flags=1;  %Ů��
    else
       flags=0;   %����
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
axis([0 max(time) 0 450]); title('ԭʼ��������Ƶ��'); ylabel('Ƶ��/Hz');
xlabel('ʱ��/s'); 
hold off;
end

