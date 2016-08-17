%BeeSearch HiveMind Control Algorithm

%THIS IS THE RAW RUNTIME!  Note that there are some differences and
%modifications between this code and the GUI code.  The GUI code has
%several additional features and is a bit faster.  Additionally the GUI
%outputs multiple motifs (the top 3) whereas this code only is capable of
%extracting the top motif.

% It is recommended to use the GUI version as this is much more of a
% debugging code and the GUI is more a finalized build.

% Run the GUI by typing "beesearch" in the command prompt!

clear
clc

NoOfSearcher = 35;
NoOfForager = 15;
NoOfDrone = 15;
NoOfMutDrone = 10;
NoOfWorkers = 10;

mLength = 6;
stabilityControl = 100;
stabilityCount = 8;
emergencyKill = 4;

filepath = 'sample.txt';

fprintf('BeeSearch :: Initializing the Hive...\n');
% status = cellstr(get(handles.edit14,'String'));
% status{length(status)+1} = 'BeeSearch :: Initializing the Hive...';
% set(handles.edit14,'String',char(status));
%setup the hive (a hive consists of 5 colonies)
myField = field(filepath);
myHive = cell(5,1);
myHive{1}=colony(35,1,mLength,myField.fSize);
myHive{2}=colony(15,2,mLength,5,myField.fSize);
myHive{3}=colony(15,3,mLength,5);
myHive{4}=colony(15,4,mLength,5);
myHive{5}=colony(NoOfWorkers,5,mLength,5);

fprintf('BeeSearch :: Beginning initial field search...\n');
% status = cellstr(get(handles.edit14,'String'));
% status{length(status)+1} = 'BeeSearch :: Beginning initial field search...';
% set(handles.edit14,'String',char(status));
%Seed the colonies (have the seekers with initial data go find some motifs)
[myHive{1}] = colonyMembersSearch(myHive{1},myField);
[myHive{2}] = colonyMembersSearch(myHive{2},myField);
[myHive{1}] = colonyMembersUpdate(myHive{1},myField);
[myHive{2}] = colonyMembersUpdate(myHive{2},myField);

%now create some initial workers...
[scoreMatrix] = powerRank([colonyMembersRank(myHive{1});colonyMembersRank(myHive{2})]);
for i = 1:NoOfWorkers
    myHive{5}.members{i}.sLogOdds = myHive{scoreMatrix(i,3)}.members{scoreMatrix(i,2)}.LogOdds;
end
[myHive{5}] = colonyMembersUpdate(myHive{5},myField);

%----------------------------------------------------

%enter cycling
tic
fprintf('BeeSearch :: Parameters locked... Hive beginning search pattern...\n');
% status = cellstr(get(handles.edit14,'String'));
% status{length(status)+1} = 'BeeSearch :: Parameters locked... Hive beginning search pattern...';
% set(handles.edit14,'String',char(status));
sysActive = 1;
stabilizer = 0;
prevResults = zeros(stabilityCount,1);
while(sysActive)
    %adjust the drones and workers to prepare for searching
    [myHive{3}] = adjustColonyDrones(myHive{3},myHive{5},myField);
    [myHive{4}] = adjustColonyMutantDrones(myHive{4},myHive{5});
    [myHive{5}] = adjustColonyWorkers(myHive{5});
    
    %if a bee needs to search to then have it go search
    [myHive{1}] = colonyMembersSearch(myHive{1},myField); %scouts search
    [myHive{2}] = colonyMembersSearch(myHive{2},myField); %foragers search
    [myHive{3}] = colonyMembersSearch(myHive{3},myField); %drones search

    for i = 1:5
        [myHive{i}] = colonyMembersUpdate(myHive{i},myField); %update ALL colonies in the field
    end

    %score all of the results
    [scoreMatrix] = powerRank([colonyMembersRank(myHive{1});colonyMembersRank(myHive{2});colonyMembersRank(myHive{3});colonyMembersRank(myHive{4});colonyMembersRank(myHive{5})]);
    %select the field positions of the new worker bees...
    for i = 1:NoOfWorkers
        myHive{5}.members{i}.sLogOdds = myHive{scoreMatrix(i,3)}.members{scoreMatrix(i,2)}.LogOdds;
    end
    [myHive{5}] = colonyMembersUpdate(myHive{5},myField); %refresh the workers
    
    if(sum(scoreMatrix(1:stabilityCount,1)==prevResults)==stabilityCount)
        stabilizer = stabilizer + 1;
    else
        stabilizer = 0;
    end
    
    if (stabilizer>=stabilityControl)
        sysActive = 0;
    end
    
    if(length(unique(scoreMatrix(1:stabilityCount,1))) < emergencyKill)
        %occasionally the colony will cross-feed on one another and all
        %populations will become converged on a single target.  This should
        %not occur and will undermine the capability of the algorithm.  If
        %this flaw occurs the algorithm takes immediate action to remove
        %the stability flaw.
%         status = cellstr(get(handles.edit14,'String'));
%         status{length(status)+1} = 'WARNING :: Intelligence flaw detected... the hive has destabilized...';
%         status{length(status)+1} = 'WARNING :: Initiating worker bee kill procedure...';
%         set(handles.edit14,'String',char(status));
        fprintf('WARNING :: Intelligence flaw detected... the hive has destabilized...\n');
        fprintf('WARNING :: Initiating worker bee kill procedure...\n');
        %force searchers to scatter in field
        [myHive{1}] = colonyMembersSearch(myHive{1},myField);
        [myHive{2}] = colonyMembersSearch(myHive{2},myField);
        [myHive{1}] = colonyMembersUpdate(myHive{1},myField);
        [myHive{2}] = colonyMembersUpdate(myHive{2},myField);
        [scoreMatrix] = powerRank([colonyMembersRank(myHive{1});colonyMembersRank(myHive{2})]);
        for i = 1:NoOfWorkers %reseed all workers
            myHive{5}.members{i}.sLogOdds = myHive{scoreMatrix(i,3)}.members{scoreMatrix(i,2)}.LogOdds;
        end
        [myHive{5}] = colonyMembersUpdate(myHive{5},myField);
        stabilizer = 0;
    end
    
    scoreMatrix(1:stabilityCount,1)
    stabilizer

    prevResults = scoreMatrix(1:stabilityCount,1);
end

% status = cellstr(get(handles.edit14,'String'));
% status{length(status)+1} = 'BeeSearch :: Hive convergence detected...';
% set(handles.edit14,'String',char(status));
fprintf('BeeSearch :: Hive convergence detected...\n');
scoreMatrix(1,1)
toc
%repeat cycling

finalBee = myHive{5}.members{1};
[motifStore posStore scoreStore] = getFinalData(myField,finalBee);
saveSequenceFile(finalBee.LogOdds,finalBee.RelEntropy,motifStore,myField.paths,posStore,scoreStore);