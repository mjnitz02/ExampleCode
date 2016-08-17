function [bestBoard costArray] = eternityIIRandom(blindBoard,rCount)
% [path costArray] = tspGenetic2(tspData,popCount,iterations,recRate,muteRate,muteType)
% This is a modified version of the previous tspGenetic

    e2Boards = cell(rCount,1);
    
    for i=1:rCount
        e2Boards{i} = blindBoard.mutateBoard(1,300);
    end

    sotfCosts = findSotFCosts(e2Boards);
    bestBoard = e2Boards{sotfCosts(1)};  %find the best board using survival of the fittest
    costArray = bestBoard.getE2Score; %get the board cost
    
end