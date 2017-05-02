function endTimesMatrix = getFitnessValue(noofOriginalJobs,noofMachines,noofStages,inputTime,inputEnergy,position,index)
    
    % FOR FIRST STAGE
    orderQ = floor(position(:,:,index));
    usedMachines = zeros(noofMachines(1),noofOriginalJobs);
    for i=1:noofOriginalJobs
        usedMachines(orderQ(i,1,index),i)=1;
    end
    endTimesMatrix = zeros(noofOriginalJobs,noofStages);
    for i=1:noofMachines(1)
        if (sum(usedMachines(i,:))==1)
            for j=1:noofOriginalJobs
                if (usedMachines(i,j)==1)
                    endTimesMatrix(j) = inputTime(j,i);
                end
            end
        elseif (sum(usedMachines(i,:))>=2)
            usedMachinesCopy = usedMachines;
            for j=1:noofOriginalJobs
                if (usedMachinesCopy(i,j)==1)
                    usedMachinesCopy(i,j)= 1 + position(j,1,index) - floor(position(j,1,index));
                end
            end
            [B,I] = sort(usedMachines(i,:),'ascend');
            usedMachinesCopy
            B
            I
        end
    end
end