%[cols rows bszH bszW] = parseImage(bim)
% --------------------
% ECE 614 - Final Project
% Author: Matt Nitzken

function [cols rows bszH bszW] = parseImage(bim)

    [r c] = find(bim==1);

    pointsR = r(c==min(r)+20);
    parsedR = []; token = 1;
    for i=1:length(pointsR)
        if(isempty(parsedR))
            parsedR(token) = pointsR(i);
            token = token+1;
        else
            if (abs(parsedR(token-1)-pointsR(i))>20)
                parsedR(token) = pointsR(i);
                token = token+1;
            end
        end
    end

%     min(c)
    pointsC = c(r==min(c)+25);
    parsedC = []; token = 1;
    for i=1:length(pointsC)
        if(isempty(parsedC))
            parsedC(token) = pointsC(i);
            token = token+1;
        else
            if (abs(parsedC(token-1)-pointsC(i))>20)
                parsedC(token) = pointsC(i);
                token = token+1;
            end
        end
    end
    
    cols = parsedC;
    rows = parsedR;
    bszH = round(mean(diff(rows)));
    bszW = round(mean(diff(cols)));
end