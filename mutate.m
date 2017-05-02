function x = mutate(position,noofMachines,pm)
    x=position;
    noofJobs=length(position(:,1));
    noofStages=length(position(1,:,1));
    maxMachines=cumsum(noofMachines);
    minMachines=maxMachines-noofMachines+ones(1,noofStages);
    for t=1:noofStages
        r=rand;
        if(r>pm)
            elementi=floor((noofJobs)*rand + 1);
            position = rand;
            x(elementi,t)=minMachines(t)+position*[maxMachines(t)-minMachines(t)] + position;
        end
    end
end
