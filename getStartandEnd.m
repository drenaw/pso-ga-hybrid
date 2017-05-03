function [start,en] = getStartandEnd( noofOriginalJobs,noofMachines,maxMachines,noofStages,position,p,ps )
maxnoofmachines=max(noofMachines(:));
start=Inf(noofOriginalJobs,maxnoofmachines,noofStages);
en=Inf(noofOriginalJobs,maxnoofmachines,noofStages);
for i=1:noofStages
    %if i==1
    if(i==1)
        a = position(:,i,ps);
        order = getOrder(a);
        for k=1:length(order(1,:))
            k;
            if(k==1)
                start(order(1,k),order(2,k),i)=0;
                start(:,:,i);
                en(order(1,k),order(2,k),i)=start(order(i,k),order(2,k),i)+p(order(1,k),i,ps);
                en(:,:,i);
            else
                l=-1;
                for f=k-1:-1:1
                    if(order(2,f)==order(2,k))
                        l=f;
                        break;
                    end
                end
                if(l~=-1)
                    start(order(1,k),order(2,k),i)=en(order(1,l),order(2,l),i);
                    start(:,:,i);
                    en(order(1,k),order(2,k),i)=start(order(1,k),order(2,k),i)+p(order(1,k),i,ps);
                    en(:,:,i);
                else
                    start(order(1,k),order(2,k),i)=0;
                    start(:,:,i);
                    en(order(1,k),order(2,k),i)=start(order(1,k),order(2,k),i)+p(order(1,k),i,ps);
                    en(:,:,i);
                end
            end
        end
        %if i!=1
    else
        endj1=0;
        endj2=0;
        for j=1:noofOriginalJobs
            z(j,1)=min(en(j,:,i-1));
            z(j,2)=j;
            z(j,3)=position(j,i,ps);
        end
        z;
        for j1=1:noofOriginalJobs
            j1;
            for j2=j1+1:noofOriginalJobs
                j2;
                maximum=en(1,floor(z(j1,3))-maxMachines(i-1),i);
                for g=2:noofOriginalJobs
                    s=en(g,floor(z(j1,3))-maxMachines(i-1),i);
                    if(maximum==Inf && s==Inf)
                        maximum=0;
                    elseif(maximum==Inf)
                        maximum=s;
                    elseif(s==Inf)
                    else
                        if(maximum<s)
                            maximum=s;
                        end
                    end
                end
                endj1=maximum;
                maximum=0;
                maximum=en(1,floor(z(j2,3))-maxMachines(i-1),i);
                
                for g=2:noofOriginalJobs
                    s=en(g,floor(z(j2,3))-maxMachines(i-1),i);
                    if(maximum==Inf && s==Inf)
                        maximum=0;
                    elseif(maximum==Inf)
                        maximum=s;
                    elseif(s==Inf)
                    else
                        if(maximum<s)
                            maximum=s;
                        end
                    end
                end
                endj2=maximum;
                
                if(floor(z(j1,3))==floor(z(j2,3)))
                    if(z(j1,1)<z(j2,1))
                        if(z(j1,1)>endj1)
                            start(z(j1,2),floor(z(j1,3))-maxMachines(i-1),i)=z(j1,1);
                        else
                            start(z(j1,2),floor(z(j1,3))-maxMachines(i-1),i)=endj1;
                        end
                        en(z(j1,2),floor(z(j1,3))-maxMachines(i-1),i)=start(z(j1,2),floor(z(j1,3))-maxMachines(i-1),i)+p(z(j1,2),i,ps);
                        start(:,:,i);
                        en(:,:,i);
                        break;
                        
                    elseif(z(j1,1)==z(j2,1))
                        if(z(j1,3)<z(j2,3))
                            %disp('j1<j2');
                            if(z(j1,1)>endj1)
                                start(z(j1,2),floor(z(j1,3))-maxMachines(i-1),i)=z(j1,1);
                            else
                                start(z(j1,2),floor(z(j1,3))-maxMachines(i-1),i)=endj1;
                            end
                            en(z(j1,2),floor(z(j1,3))-maxMachines(i-1),i)=start(z(j1,2),floor(z(j1,3))-maxMachines(i-1),i)+p(z(j1,2),i,ps);
                            start(:,:,i);
                            en(:,:,i);
                            break;
                        else
                            %disp('j2<j1');
                            if(z(j2,1)>endj2)
                                start(z(j2,2),floor(z(j2,3))-maxMachines(i-1),i)=z(j2,1);
                            else
                                start(z(j2,2),floor(z(j2,3))-maxMachines(i-1),i)=endj2;
                            end
                            en(z(j2,2),floor(z(j2,3))-maxMachines(i-1),i)=start(z(j2,2),floor(z(j2,3))-maxMachines(i-1),i)+p(z(j2,2),i,ps);
                            temp=z(j2,:);
                            for f=j2-1:-1:j1
                                f;
                                z(f+1,:)=z(f,:);
                            end
                            z;
                            z(j1,:)=temp;
                            start(:,:,i);
                            en(:,:,i);
                            break;
                        end
                    else
                        %disp('i am where you wanted');
                        if(z(j2,1)>endj2)
                            start(z(j2,2),floor(z(j2,3))-maxMachines(i-1),i)=z(j2,1);
                        else
                            start(z(j2,2),floor(z(j2,3))-maxMachines(i-1),i)=endj2;
                        end
                        en(z(j2,2),floor(z(j2,3))-maxMachines(i-1),i)=start(z(j2,2),floor(z(j2,3))-maxMachines(i-1),i)+p(z(j2,2),i,ps);
                        temp=z(j2,:);
                        for f=j2-1:-1:j1
                            f;
                            z(f+1,:)=z(f,:);
                        end
                        
                        z(j1,:)=temp;
                        z;
                        start(:,:,i);
                        en(:,:,i);
                        break;
                    end
                    
                else
                    if(z(j1,1)>endj1)
                        start(z(j1,2),floor(z(j1,3))-maxMachines(i-1),i)=z(j1,1);
                    else
                        start(z(j1,2),floor(z(j1,3))-maxMachines(i-1),i)=endj1;
                    end
                    en(z(j1,2),floor(z(j1,3))-maxMachines(i-1),i)=start(z(j1,2),floor(z(j1,3))-maxMachines(i-1),i)+p(z(j1,2),i,ps);
                    start(:,:,i);
                    en(:,:,i);
                    break;
                end
            end
        end
        maximum=en(1,floor(z(j1,3))-maxMachines(i-1),i);
        for g=2:noofOriginalJobs
            s=en(g,floor(z(j1,3))-maxMachines(i-1),i);
            if(maximum==Inf && s==Inf)
                maximum=0;
            elseif(maximum==Inf)
                maximum=s;
            elseif(s==Inf)
            else
                if(maximum<s)
                    maximum=s;
                end
            end
        end
        endj1=maximum;
        %display('z');
        z(j1,2);
        if(endj1>z(j1,1))
            
            start(z(j1,2),floor(z(j1,3))-maxMachines(i-1),i)=endj1;
        else
            start(z(j1,2),floor(z(j1,3))-maxMachines(i-1),i)=z(j1,1);
        end
        en(z(j1,2),floor(z(j1,3))-maxMachines(i-1),i)=start(z(j1,2),floor(z(j1,3))-maxMachines(i-1),i)+p(z(j1,2),i,ps);
        start(:,:,i);
        en(:,:,i);
        
    end
    
end
end
