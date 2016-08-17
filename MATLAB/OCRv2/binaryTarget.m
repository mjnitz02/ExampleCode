%[target] = binaryTarget(value)
% --------------------
% ECE 614 - Final Project
% Author: Matt Nitzken

function [target] = binaryTarget(value)

    temp = dec2bin(value,6);    
    target = double(temp);
    target = target-48;
end