function e = getE(noofOriginalJobs,noofStages,inputEnergy,q)
    %finding out energy matrix, matrix E
    for k=1:50
        for i=1:noofOriginalJobs
            for j=1:noofStages
                e(i,j,k)=inputEnergy(i,q(i,j,k));
            end
        end
    end
end 
