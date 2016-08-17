function [sotfCosts] = findSotFCosts(objMatrix)

    sotfCosts = zeros(length(objMatrix),1);
    
    for i=1:length(objMatrix)
        board = objMatrix{i};
        sotfCosts(i) = board.getE2Score;
    end
    
    sotfCosts(:,2) = 1:length(objMatrix);
    sotfCosts = flipud(sortrows(sotfCosts));
    sotfCosts = sotfCosts(:,2);
end