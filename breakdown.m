function newPos = breakdown(noofOriginalJobs,noofMachines,maxMachines,noofStages,position,p,ps,breakMachine,breakTime )
[start en]=getStartandEnd(noofOriginalJobs,noofMachines,maxMachines,noofStages,position,p,ps); %get start and end using function

breakStage=0;
%get the stage at which that machine operates
for i=1:length(maxMachines)
    
    if(breakMachine<=maxMachines(i))
        breakStage=i;
        break;
    end
    
end


%check if the machine is operating at breakTime or not
minMachines=maxMachines-noofMachines+ones(1,noofStages);
if(breakStage~=1)
    breakMachine=breakMachine-maxMachines(breakStage-1);
end


for j=1:length(position(:,1,ps))
    if(en(j,breakMachine,i)>breakTime)
        if(start(j,breakMachine,i)<=breakTime)
            
            f=rand;
            position(j,i,ps)=minMachines(i)+f*[maxMachines(i)-minMachines(i)] + f;
            if(breakStage>1)
                breakMachine=breakMachine+maxMachines(breakStage-1);
            end
            while(floor(position(j,i,ps))==breakMachine)
                f=rand;
                
                position(j,i,ps)=minMachines(i)+f*[maxMachines(i)-minMachines(i)] + f;
            end

        end
        
        if(start(j,breakMachine,i)>breakTime && start(j,breakMachine,i)~=Inf)
            f=rand;
            position(j,i,ps)=minMachines(i)+f*[maxMachines(i)-minMachines(i)] + f;
            if(breakStage>1)
                breakMachine=breakMachine+maxMachines(breakStage-1);
            end
            while(floor(position(j,i,ps))==breakMachine)
                f=rand;
                position(j,i,ps)=minMachines(i)+f*[maxMachines(i)-minMachines(i)] + f;
            end

            
        end
    end
    %return the updated position
    newPos=position(:,:,ps);
    
end

