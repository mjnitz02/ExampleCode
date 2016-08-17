%[bim] = binaryImage(impath,threshold)
% --------------------
% ECE 614 - Final Project
% Author: Matt Nitzken

function [bim] = binaryImage(impath,threshold)

    im = imread(impath);
    
    if ~exist('threshold','var') threshold = 100; end

    bim = zeros(size(im,1),size(im,2));
    for i=1:size(im,1)
        for j=1:size(im,2)
            if (im(i,j)>threshold)
                bim(i,j) = 0;
            else
                bim(i,j) = 1;
            end
        end
    end
    
    bim = bim(10:size(bim,1)-10,10:size(bim,2)-10);
    
end