function [C R] = EMDW( s, step, thread )
% Calculate the EMD of s
%
% [C R] = EMDW( s, step, thread )
%
%Input:
%   s: input signal
%   step: maximum step
%   thread: use to determine IMF
%Output:
%   C are IMF components
%   R=s-c

IsIMF=0;
IsMonotonic=0;
L=length(s);
t=1:L;
n=0;
C=[];
R=[];
while IsMonotonic==0
    n=n+1;
    h=s;
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
    R(n,:)=s;
    C(n,:)=h;
    [MaxPosition MaxValue NumMax MinPosition MinValue NumMin]=LocalMaxMin(s);
    if (isempty(MaxValue) && isempty(MinValue)) || n>=step
        IsMonotonic=1;
    end
end
            
end

