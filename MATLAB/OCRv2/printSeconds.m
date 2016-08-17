%[null] = printSeconds(time)
% --------------------
% ECE 614 - Final Project
% Author: Matt Nitzken

function [null] = printSeconds(time)
    time = floor(time);
    
    if (time >= 1000)
        fprintf('\b\b\b\b\b\b %ds',time);
    elseif (time < 1000) && (time >= 100)
        fprintf('\b\b\b\b\b %ds',time);
    elseif (time <100) && (time >= 10)
        fprintf('\b\b\b\b %ds',time);
    else
        fprintf('\b\b\b %ds',time);
    end
end