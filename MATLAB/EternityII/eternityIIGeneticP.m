function [bestBoard] = eternityIIGeneticP(blindBoard,boardSize,stableVal,popCount,topRate,muteRate,attemptRate)
% [path costArray] = tspGenetic2(tspData,popCount,iterations,recRate,muteRate,muteType)
% This is a modified version of the previous tspGenetic

    attemptRate = attemptRate.*boardSize*boardSize;
    e2Boards = cell(popCount,1);
    
    for i=1:popCount
        e2Boards{i} = blindBoard.mutateBoard(1,300);
    end

    bestBoard = e2Boards{1};
    bestCost = 0;
    
    fprintf('Convergence -> 100(This value is liable to reset multiple times):    0');
    %utilize smart stability
    counter = 0; %track number of iterations
    active = 1; %activate the genetic algorithm
    stabilityControl = 0; %zero the stability factor
    
    [uniqueE2] = blindBoard.findUnique;
    locOccur = zeros(boardSize,boardSize,size(uniqueE2,1));
    rotOccur = zeros(boardSize,boardSize,size(uniqueE2,1),4);
    
    while (active)
        counter = counter+1; %increase the current iteration count
        bestCost0 = bestCost; %recursively track distance for stability
        
        
        %NEED TO PERFORM GENETIC MUTATION HERE
        sotfCosts = findSotFCosts(e2Boards);
        [e2Boards] = geneticE2Driver(e2Boards,sotfCosts,topRate,muteRate,attemptRate);
        
        %Use the specified metric to calculate the best path
        [locOccur rotOccur] = findWoCE2Persist(e2Boards,locOccur,rotOccur);
        
        %Determine if the new best path is better than our current path
%         if (newCost>bestCost) %if is a new lowest dist then update
%             bestCost = newCost; %store the min dist
%             bestBoard = newBoard; %store the path
%             bestBoard.displayBoard; %display path visually
%             pause(0.1)
%         end
%         costArray(counter) = bestCost; %update cost matrix to reflect the current best path
        
        %check for stability
        if(bestCost0 == bestCost)
            stabilityControl = stabilityControl+1; %was stable for an iteration, increase stability
            updatePercentage(stabilityControl);
            if (stabilityControl >= stableVal) %if stable for 100 generations then exit
                active = 0; %throw exit command
            end
        end
    end
    newBoard = findWoCE2P(e2Boards,locOccur,rotOccur);
    newCost = newBoard.getE2Score
    newBoard.displayBoard;
    
    fprintf('\n');
end

function [e2Boards] = geneticE2Driver(e2Boards,sotfCosts,topRate,muteRate,attemptRate)
% [population1 population2] = genetic2parent(population1,curPathDist1,population2,curPathDist2,topRate,muteRate,muteType)
% This function is the main control algorithm for the genetic algorithm

    tempe2Boards = cell(length(e2Boards),1);
    %translate sotf percentage to a integer value
    topRate = round(length(e2Boards)*topRate);
    %error handle bad recRates
    if (topRate<1); topRate = 1; elseif (topRate>length(e2Boards)); topRate = length(e2Boards); end
    
    sIter = 1; %Wisdom of Crowds control variable
    for i=1:1:length(e2Boards) %iterate through population performing mutations
        tempBoard = e2Boards{sotfCosts(sIter)};
        tempe2Boards{i} = tempBoard.mutateBoard(muteRate,attemptRate);
        
        %only use the top recRate # of paths for analysis
        sIter = sIter+1; %increase mIter
        if (sIter>topRate); sIter = 1; end %if higher than recovery rate then reset
    end
    e2Boards = tempe2Boards;
end


