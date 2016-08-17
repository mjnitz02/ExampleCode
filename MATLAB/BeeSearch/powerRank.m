% [scoreMatrix] = powerRank(scoreMatrix)
% CECS660 - Bioinformatics
% Author: Matt Nitzken
% 
% Description:
% Tnis algorithm will quickly take a score matrix and rank order it.
% ---------------------------------------------------

function [scoreMatrix] = powerRank(scoreMatrix)

    [null idx] = sort(scoreMatrix(:,1),'descend');
    temp = zeros(size(scoreMatrix));
    
    for i = 1:size(temp,1)
        temp(i,:) = scoreMatrix(idx(i),:);
    end
    
    scoreMatrix = temp;

end