function [ MaxPosition LocalMaximum NumMax MinPosition LocalMinimum NumMin ] = LocalMaxMin( x )
%   find the Local Maximum and Local Minimum values and their position in x
%which is a one dimention array
%
% [ MaxPosition LocalMaximum NumMax MinPosition LocalMinimum NumMin ] = LocalMaxMin( x )
%
%Note: the first and the final values (not positions) are lost in results.
%The continuous same values will be counted as different points when
%calculate the "MaxPosition"/"MinPosition" and
%"LocalMaximum"/"LocalMinimum". But they will be counted as the same point
%when calculate the "NumMax" and the "NumMin".
%
%   In the "NumMax" and "NumMin", the first value is the number of points
%   which are larger than 0. The second value is the number of points which
%   are equal to 0. The theird value is the number of points which are
%   smaller than 0.

xSize=size(x);
if xSize(1)~=1 || xSize(2)<4
    error('The size of input is wrong');
else

LocalMaximum=[];
MaxPosition=[];
LocalMinimum=[];
MinPosition=[];
NumMax=[0 0 0];
NumMin=[0 0 0];

StartPosition=0;

Difference=diff(x);
d1=Difference(1:length(Difference)-1);
d2=Difference(2:length(Difference));
Adjust=d1.*d2;
Position=find(Adjust<=0);
for AdjustPosition=Position
    if Adjust(AdjustPosition)<0
        if d1(AdjustPosition)<0
            LocalMinimum=[LocalMinimum x(AdjustPosition+1)];
            MinPosition=[MinPosition AdjustPosition+1];
            if x(AdjustPosition+1)>0
                NumMin(1)=NumMin(1)+1;
            elseif x(AdjustPosition+1)==0
                NumMin(2)=NumMin(2)+1;
            else
                NumMin(3)=NumMin(3)+1;
            end
        elseif d1(AdjustPosition)>0
            LocalMaximum=[LocalMaximum x(AdjustPosition+1)];
            MaxPosition=[MaxPosition AdjustPosition+1];
            if x(AdjustPosition+1)>0
                NumMax(1)=NumMax(1)+1;
            elseif x(AdjustPosition+1)==0
                NumMax(2)=NumMax(2)+1;
            else
                NumMax(3)=NumMax(3)+1;
            end
        end
    else
        if d1(AdjustPosition)==0 && d2(AdjustPosition)~=0
            if StartPosition==0
                if d2(AdjustPosition)>0
                    LocalMinimum=[LocalMinimum x(2:AdjustPosition+1)];
                    MinPosition=[MinPosition (2:AdjustPosition+1)];
                    if x(AdjustPosition+1)>0
                        NumMin(1)=NumMin(1)+1;
                    elseif x(AdjustPosition+1)==0
                        NumMin(2)=NumMin(2)+1;
                    else
                        NumMin(3)=NumMin(3)+1;
                    end
                else
                    LocalMaximum=[LocalMaximum x(2:AdjustPosition+1)];
                    MaxPosition=[MaxPosition (2:AdjustPosition+1)];
                     if x(AdjustPosition+1)>0
                        NumMax(1)=NumMax(1)+1;
                    elseif x(AdjustPosition+1)==0
                        NumMax(2)=NumMax(2)+1;
                     else
                        NumMax(3)=NumMax(3)+1;
                    end
                end
            else
                if d1(StartPosition)*d2(AdjustPosition)<0
                    if d2(AdjustPosition)>0
                        LocalMinimum=[LocalMinimum x(StartPosition+1:AdjustPosition+1)];
                        MinPosition=[MinPosition (StartPosition+1:AdjustPosition+1)];
                        if x(AdjustPosition+1)>0
                            NumMin(1)=NumMin(1)+1;
                        elseif x(AdjustPosition+1)==0
                            NumMin(2)=NumMin(2)+1;
                        else
                            NumMin(3)=NumMin(3)+1;
                        end
                    else
                        LocalMaximum=[LocalMaximum x(StartPosition+1:AdjustPosition+1)];
                        MaxPosition=[MaxPosition (StartPosition+1:AdjustPosition+1)];
                        if x(AdjustPosition+1)>0
                            NumMax(1)=NumMax(1)+1;
                        elseif x(AdjustPosition+1)==0
                            NumMax(2)=NumMax(2)+1;
                        else
                            NumMax(3)=NumMax(3)+1;
                        end
                    end
                end
            end
            StartPosition=0;
        elseif d1(AdjustPosition)~=0 && d2(AdjustPosition)==0
            StartPosition=AdjustPosition;
        end
    end
end
if StartPosition~=0
    if d1(StartPosition)<0
                LocalMinimum=[LocalMinimum x(StartPosition+1:length(x)-1)];
                MinPosition=[MinPosition (StartPosition+1:length(x)-1)];
                if x(length(x)-1)>0
                       NumMin(1)=NumMin(1)+1;
                elseif x(length(x)-1)==0
                        NumMin(2)=NumMin(2)+1;
                 else
                        NumMin(3)=NumMin(3)+1;
                 end
    else
                LocalMaximum=[LocalMaximum x(StartPosition+1:length(x)-1)];
                MaxPosition=[MaxPosition (StartPosition+1:length(x)-1)];
                if x(length(x)-1)>0
                            NumMax(1)=NumMax(1)+1;
                 elseif x(length(x)-1)==0
                            NumMax(2)=NumMax(2)+1;
                 else
                            NumMax(3)=NumMax(3)+1;
                 end
    end
end
end

if x(1)-x(2)>0
    MaxPosition=[1 MaxPosition];
    LocalMaximum=[x(1) LocalMaximum];
else
    MinPosition=[1 MinPosition length(x)];
    LocalMinimum=[x(1) LocalMinimum x(length(x))];
end
if x(length(x))-x(length(x)-1)>0
    MaxPosition=[MaxPosition length(x)];
    LocalMaximum=[LocalMaximum x(length(x))];
else
    MinPosition=[MinPosition length(x)];
    LocalMinimum=[LocalMinimum x(length(x))];
end
end

