% [im] = colorize(im,gradiant)
% CECS660 - Bioinformatics
% Author: Matt Nitzken
% 
% Description:
% Colorize a bee object to show progress.
% ---------------------------------------------------

function [im] = colorize(im,gradiant)

    switch gradiant
        case 1;
            vals = [1 20 20];
        case 2;
            vals = [1 20 1];
        case 3;
            vals = [1 1 20];
        case 4;
            vals = [20 20 1];
        case 5;
            vals = [20 1 1];
    end

    im(:,:,1) = im(:,:,1)./vals(1);
    im(:,:,2) = im(:,:,2)./vals(2);
    im(:,:,3) = im(:,:,3)./vals(3);

end