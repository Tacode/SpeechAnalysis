function [TT,FF,Ef,SF,voiceseg,vosl,vseg,vsl,Thr2]=...
   Ext_F0ztms(xx,fs,wlen,inc,Thr1,r2,miniL,mnlong,ThrC)

N=length(xx);                             % 信号长度
time = (0 : N-1)/fs;                      % 设置时间刻度
lmin=floor(fs/500);                       % 最高基音频率500Hz对应的基音周期
lmax=floor(fs/60);                        % 最高基音频率60Hz对应的基音周期 

yy=enframe(xx,wlen,inc)';                 % 第一次分帧
fn=size(yy,2);                            % 取来总帧数
frameTime = frame2time(fn, wlen, inc, fs);% 计算每一帧对应的时间
% 用于基音检测的端点检测和元音主体检测
[voiceseg,vosl,vseg,vsl,Thr2,Bth,SF,Ef]=pitch_vads(yy,fn,Thr1,r2,miniL,mnlong);
% 60～500Hz的带通滤波器系数
b=[0.012280   -0.039508   0.042177   0.000000   -0.042177   0.039508   -0.012280];
a=[1.000000   -5.527146   12.854342   -16.110307   11.479789   -4.410179   0.713507];
x=filter(b,a,xx);                         % 数字滤波
x=x/max(abs(x));                          % 幅值归一化
y=enframe(x,wlen,inc)';                   % 第二次分帧

[Extseg,Dlong]=Extoam(voiceseg,vseg,vosl,vsl,Bth);   % 计算延伸区间和延伸长度
T1=ACF_corrbpa(y,fn,vseg,vsl,lmax,lmin,ThrC(1));     % 对元音主体进行基音检测
% 对语音主体的前后向过渡区延伸基音检测        
T0=zeros(1,fn);                           % 初始化
F0=zeros(1,fn);
for k=1 : vsl                             % 共有vsl个元音主体
    ix1=vseg(k).begin;                    % 第k个元音主体开始位置
    ix2=vseg(k).end;                      % 第k个元音主体结束位置
    in1=Extseg(k).begin;                  % 第k个元音主体前向延伸开始位置
    in2=Extseg(k).end;                    % 第k个元音主体后向延伸结束位置
    ixl1=Dlong(k,1);                      % 前向延伸长度
    ixl2=Dlong(k,2);                      % 后向延伸长度
    if ixl1>0                             % 需要前向延伸基音检测
        [Bt,voiceseg]=back_Ext_shtpm1(y,fn,voiceseg,Bth,ix1,...
        ixl1,T1,k,lmax,lmin,ThrC);
    else                                  % 不需要前向延伸基音检测
        Bt=[];
    end
    if ixl2>0                             % 需要后向延伸基音检测
        [Ft,voiceseg]=fore_Ext_shtpm1(y,fn,voiceseg,Bth,ix2,...
        ixl2,vsl,T1,k,lmax,lmin,ThrC);
    else                                  % 不需要后向延伸基音检测
        Ft=[];
    end
    T0(in1:in2)=[Bt T1(ix1:ix2) Ft];      % 第k个元音主体完成了前后向延伸检测 
end
tindex=find(T0>lmax);                     % 限止延伸后最大基音周期值不超越lmax
T0(tindex)=lmax;
tindex=find(T0<lmin & T0~=0);             % 限止延伸后最小基音周期值不低于lmin
T0(tindex)=lmin;
tindex=find(T0~=0);
F0(tindex)=fs./T0(tindex);
TT=pitfilterm1(T0,Extseg,vsl);             % T0平滑滤波
FF=pitfilterm1(F0,Extseg,vsl);             % F0平滑滤波







