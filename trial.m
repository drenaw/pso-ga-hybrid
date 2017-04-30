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
fitness = getFitness(noofStages,noofOriginalJobs,noofMachines,position,maxMachines,p);
delta = ones(noofOriginalJobs,noofStages,50);
globalBestFitness=intmax('int64');
globalBestFitnessIndex=0;
velocity = rand(noofOriginalJobs,noofStages,50);
rCoeff = rand(1,5);
isSame = false;

while(sum(sum(sum(delta(:,:,:))))~=0)
    [localBestFitness,localBestFitnessIndex] = min(fitness);
    if(localBestFitness<globalBestFitness)
        globalBestFitness = localBestFitness;
        globalBestFitnessIndex = localBestFitnessIndex;
    end
    positionOld = position;
    for j=1:50
        velocity(:,:,j) = rCoeff(1)*velocity(:,:,j) + rCoeff(2)*rCoeff(3)*(position(:,:,localBestFitnessIndex)-position(:,:,j)) + rCoeff(4)*rCoeff(5)*(position(:,:,globalBestFitnessIndex)-position(:,:,j));
        temp = position(:,:,j) - floor(position(:,:,j)) + velocity(:,:,j);
        for indI=1:noofOriginalJobs
            for indJ=1:noofStages
                checkVariable = position(indI,indJ,j) + temp(indI,indJ);
                if(checkVariable>maxMachines(indJ) || checkVariable<minMachines(indJ))
                    %DONT UPDATE
                else
                    position(indI,indJ,j) = position(indI,indJ,j) + temp(indI,indJ);
                end
            end
        end 
    end
    q = getQ(position);
    p = getP(noofOriginalJobs,noofStages,inputTime,q);
    e = getE(noofOriginalJobs,noofStages,inputEnergy,q);
    fitness = getFitness(noofStages,noofOriginalJobs,noofMachines,position,maxMachines,p)
    delta = position - positionOld;    
end

fitness
[localBestFitness,localBestFitnessIndex] = min(fitness)




