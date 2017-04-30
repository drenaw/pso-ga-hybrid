function fitness = getFitness(noofStages,noofOriginalJobs,noofMachines,position,maxMachines,p)
    fitness=zeros(1,50);
    for ps=1:50
        for i=1:noofStages
            if(i==1)
                start=Inf(noofOriginalJobs,noofMachines(i),noofStages);
                en=Inf(noofOriginalJobs,noofMachines(i),noofStages);
            end
            a=position(:,i,1);
            order=getOrder(a);        
            for k=1:length(order(1,:))
                if(i==1)
                    if(k==1)
                        start(order(1,k),order(2,k),i)=0;
                        start(:,:,i);
                        en(order(1,k),order(2,k),i)=start(order(i,k),order(2,k),i)+p(order(1,k),i,ps);
                        en(:,:,i);
                    else
                        if(order(2,k-1)==order(2,k))
                            start(order(1,k),order(2,k),i)=en(order(1,k-1),order(2,k-1),i);
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
                else
                    if(k==1)
                        start(order(1,k),order(2,k)-maxMachines(i-1),i)=min(en(order(1,k),:,i-1));
                        start(:,:,i);
                        en(order(1,k),order(2,k)-maxMachines(i-1),i)=start(order(1,k),order(2,k)-maxMachines(i-1),i)+p(order(1,k),i,ps);
                        en(:,:,i);
                    else
                        if(order(2,k-1)==order(2,k))
                            start(order(1,k),order(2,k)-maxMachines(i-1),i)=en(order(1,k-1),order(2,k-1)-maxMachines(i-1),i);
                            start(:,:,i);
                            en(order(1,k),order(2,k)-maxMachines(i-1),i)=start(order(1,k),order(2,k)-maxMachines(i-1),i)+p(order(1,k),i,ps);
                            en(:,:,i);
                        else
                            start(order(1,k),order(2,k)-maxMachines(i-1),i)=min(en(order(1,k),:,i-1));
                            start(:,:,i);
                            en(order(1,k),order(2,k)-maxMachines(i-1),i)=start(order(1,k),order(2,k)-maxMachines(i-1),i)+p(order(1,k),i,ps);
                            en(:,:,i);
                        end
                    end
                end
            end
            if(i==noofStages)
                max=en(1,1,i);
                for a=1:noofOriginalJobs
                    for b=1:noofMachines(i)
                        if(en(a,b,i)==Inf && max==Inf)
                            max=0;
                        elseif(max==Inf)
                            max=en(a,b,i);
                        elseif(en(a,b,i)==Inf)
                            continue;
                        else
                            if(en(a,b,i)>max)
                                max=en(a,b,i);
                            end
                        end
                    end
                end
                fitness(ps)=max;
            end
        end
    end
end
