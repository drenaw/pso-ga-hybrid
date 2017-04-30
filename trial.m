clc
noofOriginalJobs = input('Enter Number of Original Jobs: ');
noofStages = input('Enter Number of Stages: ');
noofMachines = zeros(1,noofStages);
for i=1:noofStages
  noofMachines(i) = input(sprintf('Enter number of Machines in stage %d: ',i));
end
totalMachines = sum(noofMachines);
%inputTime = zeros(noofOriginalJobs,totalMachines);inputEnergy = zeros(noofOriginalJobs,totalMachines);
%for i=1:noofOriginalJobs
%   for j=1:totalMachines
%     inputTime(i,j) = input(sprintf('Enter makespan of job %d and machine %d: ',i,j));
%     inputEnergy(i,j) = input(sprintf('Enter enery consumed by job %d and machine %d: ',i,j));
%   end
%end
inputTime
inputEnergy

maxMachines=cumsum(noofMachines);
minMachines=maxMachines-noofMachines+ones(1,noofStages);
position = rand(noofOriginalJobs,noofStages,50);

for i=1:50
    for j=1:int16(noofStages)
        position(:,j,i)=minMachines(j)+position(:,j,i)*[maxMachines(j)-minMachines(j)] + position(:,j,i);
    end
end

lambda=input('Enter the value of lambda: ');
q = getQ(position);
p = getP(noofOriginalJobs,noofStages,inputTime,q);
e = getE(noofOriginalJobs,noofStages,inputEnergy,q);
fitness = getFitness(noofStages,noofOriginalJobs,noofMachines,position,maxMachines,p)