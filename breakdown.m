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
position(:,:,ps)
%check if the machine is operating at breakTime or not


minMachines=maxMachines-noofMachines+ones(1,noofStages);
if(breakStage~=1)
    breakMachine=breakMachine-maxMachines(breakStage-1);
end
breakMachine


for j=1:length(position(:,1,ps))
    j
    breakTime
    en(j,breakMachine,i)
    start(j,breakMachine,i)
    if(en(j,breakMachine,i)>breakTime)
        if(start(j,breakMachine,i)<=breakTime)
            disp('Machine running during breakTime');
            f=rand;
            position(j,i,ps)=minMachines(i)+f*[maxMachines(i)-minMachines(i)] + f;
            while(floor(position(j,i,ps))==(breakMachine+maxMachines(breakStage-1)))
                f=rand;
                f
                position(j,i,ps)=minMachines(i)+f*[maxMachines(i)-minMachines(i)] + f;
            end
            position(j,i,ps)
        end
        
    if(start(j,breakMachine,i)>breakTime && start(j,breakMachine,i)~=Inf)
        disp('Machine not running during breakTime');
        f=rand;
        position(j,i,ps)=minMachines(i)+f*[maxMachines(i)-minMachines(i)] + f;
        while(floor(position(j,i,ps))==(breakMachine+maxMachines(breakStage-1)))
            f=rand;
            position(j,i,ps)=minMachines(i)+f*[maxMachines(i)-minMachines(i)] + f;
        end
        position(j,i,ps);
        
    end
    end
%return the updated position
newPos=position(:,:,ps);

end

