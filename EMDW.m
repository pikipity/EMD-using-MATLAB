function [C,R] = EMDW( s, step, thread )
% Calculate the EMD of s
%
% [C,R] = EMDW( s, step, thread )
%
%Input:
%   s: input signal
%   step: maximum step, default value is 10
%   thread: use to determine IMF, default value is 0.3
%Output:
%   C are IMF components

if nargin==1
    step=10;
    thread=0.3;
elseif nargin==2
    thread=0.3;
end

IsMonotonic=0;
L=length(s);
t=1:L;
n=0;
C=[];
while IsMonotonic==0
    n=n+1;
    h=s;
    IsIMF=0;
    while IsIMF==0
        [MaxPosition MaxValue NumMax MinPosition MinValue NumMin]=LocalMaxMin(h);
        pp=csape(MaxPosition,MaxValue,'variational');
        UpEnvelope=ppval(pp,t);
        pp=csape(MinPosition,MinValue,'variational');
        DownEnvelope=ppval(pp,t);
        m=(UpEnvelope+DownEnvelope)./2;
        prevh=h;
        h=h-m;
        eps = 0.0000001;
        SD = sum ( ((prevh - h).^2) ./ (prevh.^2 + eps) );
        if SD<=thread
            IsIMF=1;
        end
    end
    s=s-h;
    C(n,:)=h;
    [MaxPosition MaxValue NumMax MinPosition MinValue NumMin]=LocalMaxMin(s);
    if sum(NumMax)==0 || sum(NumMin)==0 || n>=step
        IsMonotonic=1;
    end
end

R=s;
end

