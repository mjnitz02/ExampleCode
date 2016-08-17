%[values] = computeError(nnTestData, nnResultData)
% --------------------
% ECE 614 - Final Project
% Author: Matt Nitzken

function [values] = computeError(nnTestData, nnResultData)

values = zeros(1,size(nnTestData,1));

for i=1:size(nnTestData,1)
    if (sum(nnTestData(i,:)==nnResultData(i,:)) == 6)
        values(i) = 1;
    end
end
