function p = getP(noofOriginalJobs,noofStages,inputTime,q)
    for k=1:50
        for i=1:noofOriginalJobs
            for j=1:noofStages
                p(i,j,k)=inputTime(i,q(i,j,k));
            end
        end
    end
end