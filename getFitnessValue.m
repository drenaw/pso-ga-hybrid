function fitnessValue = getFitnessValue(noofOriginalJobs,noofMachines,noofStages,inputTime,inputEnergy,position,index)
    % FOR FIRST STAGE
    orderQ = floor(position(:,:,index));
    usedMachines = zeros(noofMachines(1),noofOriginalJobs);
    for i=1:noofOriginalJobs
        usedMachines(orderQ(i,1,index),i)=1;
    end
    for i=1:noofMachines(1)
        if (sum(usedMachines(i,:))>=2)
            
        end
    end
end