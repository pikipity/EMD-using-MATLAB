function [ MaxPosition LocalMaximum MinPosition LocalMinimum ] = LocalMaxMin( x )
%   find the Local Maximum and Local Minimum values and their position in x
%which is a one dimention array
%
%[ LocalMaximum MaxPosition LocalMinimum MinPosition ] = LocalMaxMin( x )
%
%Note: the first and the final values (not positions) are lost in results.

xSize=size(x);
if xSize(1)~=1 || xSize(2)<4
    error('The size of input is wrong');
else

LocalMaximum=[];
MaxPosition=[];
LocalMinimum=[];
MinPosition=[];

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
        elseif d1(AdjustPosition)>0
            LocalMaximum=[LocalMaximum x(AdjustPosition+1)];
            MaxPosition=[MaxPosition AdjustPosition+1];
        end
    else
        if d1(AdjustPosition)==0 && d2(AdjustPosition)~=0
            if StartPosition==0
                if d2(AdjustPosition)>0
                    LocalMinimum=[LocalMinimum x(2:AdjustPosition+1)];
                    MinPosition=[MinPosition (2:AdjustPosition+1)];
                else
                    LocalMaximum=[LocalMaximum x(2:AdjustPosition+1)];
                    MaxPosition=[MaxPosition (2:AdjustPosition+1)];
                end
            else
                if d1(StartPosition)*d2(AdjustPosition)<0
                    if d2(AdjustPosition)>0
                        LocalMinimum=[LocalMinimum x(StartPosition+1:AdjustPosition+1)];
                        MinPosition=[MinPosition (StartPosition+1:AdjustPosition+1)];
                    else
                        LocalMaximum=[LocalMaximum x(StartPosition+1:AdjustPosition+1)];
                        MaxPosition=[MaxPosition (StartPosition+1:AdjustPosition+1)];
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
    else
                LocalMaximum=[LocalMaximum x(StartPosition+1:length(x)-1)];
                MaxPosition=[MaxPosition (StartPosition+1:length(x)-1)];
    end
end
end
end

