%[letters] = recoverLetters(bim,cols,rows,bszH,bszW,buffer,crop)
% --------------------
% ECE 614 - Final Project
% Author: Matt Nitzken

function [letters] = recoverLetters(bim,cols,rows,bszH,bszW,buffer,crop)


    letters = zeros(bszH-(buffer*2)+1,bszW-(buffer*2)+1,(length(cols)-1)*(length(rows)-1));
    
    token = 1;
    for i=1:length(rows)-1
        for j=1:length(cols)-1
            temp = bim(rows(i)+buffer:rows(i)+bszH-buffer,cols(j)+buffer:cols(j)+bszW-buffer);
            
            [r0 c0] = size(temp);
            [r c] = find(temp == 1);
            if (~isempty(r))
                rCentroid = min(r) + int16((max(r)-min(r))/2);
                cCentroid = min(c) + int16((max(c)-min(c))/2);
                [r0 c0] = size(temp);

                shiftR = (r0/2)-rCentroid;
                shiftC = (c0/2)-cCentroid;

                shiftTemp = zeros(size(temp));
                T = double([1 0 0;0 1 0;shiftR shiftC 1]);
                for a = 1:size(temp,1)
                    for b = 1:size(temp,2)
                        loc = [a b 1]*T;
                        if((loc(1)>0)&&(loc(2)>0))
                            shiftTemp(loc(1),loc(2)) = temp(a,b);
                        end
                    end
                end
                temp = shiftTemp(1:r0,1:c0);
            end
            
            letters(:,:,token) = temp;
            token = token+1;
        end
    end
    
    if(exist('crop','var'))
        clip = round((size(letters,2)-size(letters,1))/2);
        lettersC = letters(:,clip:size(temp,2)-clip-1,:);
    end
    
    letters = zeros(88,88,size(lettersC,3));
    for i = 1:size(lettersC,3)
        letters(1:size(lettersC,1),1:size(lettersC,2),i) = lettersC(:,:,i);
    end
end