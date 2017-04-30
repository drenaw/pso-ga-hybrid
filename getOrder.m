function order = getOrder( pos)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
    order=zeros(2,length(pos));
    tempos=pos;
    for x=1:length(pos);
        
        i=x;
        min=pos(i);
        for a=(x+1):length(pos)
            if(min>pos(a))
                i=a;
                min=pos(a);
            end
        end
       
        for a=1:length(tempos)
            if(tempos(a)==min)
                break;
            end
        end
        
        order(1,x)=a;
        order(2,x)=floor(pos(i));
        temp=pos(i);
        pos(i)=pos(x);
        pos(x)=temp;
    end
end
