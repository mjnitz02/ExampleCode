%[nnInput, nnTarget] = splitLetters(letters,target,inSize)
% --------------------
% ECE 614 - Final Project
% Author: Matt Nitzken

% This is a debug testing file

function [nnInput, nnTarget] = splitLetters(letters,target,inSize)

    nnVars = (size(letters,1)/inSize)*(size(letters,2)/inSize);
    
    %remove blank areas
    lettersTemp = letters;
    token = 1;
    for i=1:size(letters,3)
        if(sum(sum(letters(:,:,i)))<5)
            lettersTemp(:,:,token) = [];
            token = token-1;
        end
        token = token+1;
    end
    letters = lettersTemp;
    
    nnInput = zeros(size(letters,3),nnVars);
    for i=1:size(letters,3)
        [cellStor] = parseLetter(letters(:,:,i),inSize);
        nnInput(i,:) = squeeze(sum(sum(cellStor)))';
    end
    
    nnTarget = zeros(length(target),6);
    for i=1:length(target)
        binaryTarget(target(i));
        nnTarget(i,:) = binaryTarget(target(i));
    end
end

function [cellStor] = parseLetter(letter,factor)

    token = 1; %Reset token and begin iterating
    for i=1:size(letter,1)/factor
        %Find current row origin
        if (i==1)
            rOrigin = 1;
        else
            rOrigin = rOrigin+factor;
        end

        for j=1:size(letter,2)/factor
            %Find current column origin
            if (j==1)
                cOrigin = 1;
            else
                cOrigin = cOrigin+factor;
            end

            %Extract letter window based on factor at current origins
            cellStor(:,:,token) = letter(rOrigin:rOrigin+(factor-1),cOrigin:cOrigin+(factor-1));
            token = token+1; %increment loop token
        end
    end
end

function [target] = binaryTarget(value)

    temp = dec2bin(value,6);    
    target = double(temp);
    target = target-48;
    
end