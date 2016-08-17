%[nnInput, nnTarget, trainInput, trainTarget, testInput, testTarget, letters, target] = quickRead(im1path,im2path,im2test)
% --------------------
% ECE 614 - Final Project
% Author: Matt Nitzken

function [nnInput, nnTarget, trainInput, trainTarget, testInput, testTarget, letters, target] = quickRead(im1path,im2path,im2test)
    
    buffer = 10;
    inSize = 8;
    testSize = 36;
    
    target = [];
    for i=1:8
        temp = zeros(1,18); temp(:) = i;
        target = [target temp];
    end
    temp = zeros(1,18); temp(:) = 9; target = [target temp];
    temp = zeros(1,18); temp(:) = 0; target = [target temp];
    target = [target im2test];
    
    [bim] = binaryImage(im1path,180);
    [cols rows bszH bszW] = parseImage(bim);
    [lettersT1] = recoverLetters(bim,cols,rows,bszH,bszW,buffer,1);
    
    [bim] = binaryImage(im2path,180);
    [cols rows bszH bszW] = parseImage(bim);
    [lettersT2] = recoverLetters(bim,cols,rows,bszH,bszW,buffer,1);
    letters = [lettersT1;lettersT2];
    
    letters = zeros(size(lettersT1,1),size(lettersT1,2),size(lettersT1,3)+size(lettersT2,3));
    letters(:,:,1:size(lettersT1,3)) = lettersT1;
    letters(:,:,size(lettersT1,3)+1:size(letters,3)) = lettersT2;
    
    
    [nnInput, nnTarget] = splitLetters(letters,target,inSize);
    
%     target = [];
%     temp = zeros(1,18); temp(:) = 9; target = [target temp];
%     temp = zeros(1,18); temp(:) = 0; target = [target temp];
%     temp = im2test;%[1 7 5 1 4 2 5 6 8 4 3 6 2 1 7 8 3 9 2 5 1 3 5 7 2 9 4 0 8 0 9 3 6 7 1 0];
%     target = [target temp];
    

%     [nnInput2, nnTarget2] = splitLetters(letters,target,inSize);
%     
%     nnInput = [nnInput1;nnInput2];
%     nnTarget = [nnTarget1;nnTarget2];
    
    trainInput = nnInput(1:size(nnInput,1)-testSize,:);
    trainTarget = nnTarget(1:size(nnInput,1)-testSize,:);
    
    testInput = nnInput(size(nnInput,1)-testSize+1:size(nnInput,1),:);
    testTarget = nnTarget(size(nnInput,1)-testSize+1:size(nnInput,1),:);
    
    
%     %Quick-print function
%     for i=1:size(letters,3)
%         imshow(letters(:,:,i));
%         pause(0.2);
%     end
end