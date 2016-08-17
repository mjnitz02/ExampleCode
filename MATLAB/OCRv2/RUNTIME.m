%Main runtime files
% --------------------
% ECE 614 - Final Project
% Author: Matt Nitzken

% There is no GUI so data is controlled by commenting/uncommenting code.

clear all
clc

% load test.mat

fprintf('Reading/Splitting data sets...');
% [nnInput, nnTarget, trainInput, trainTarget, testInput, testTarget, letters, target] = quickRead('data/Scan1_Pic0001.jpg','data/Scan1_Pic0002.jpg',[1 7 5 1 4 2 5 6 8 4 3 6 2 1 7 8 3 9 2 5 1 3 5 7 2 9 4 0 8 0 9 3 6 7 1 0]);
[nnInput, nnTarget, trainInput1, trainTarget1, testInput1, testTarget1] = quickRead('data/Scan1_Pic0001.jpg','data/Scan1_Pic0002.jpg',[1 7 5 1 4 2 5 6 8 4 3 6 2 1 7 8 3 9 2 5 1 3 5 7 2 9 4 0 8 0 9 3 6 7 1 0]);
[nnInput, nnTarget, trainInput2, trainTarget2, testInput2, testTarget2] = quickRead('data/Scan2_Pic0001.jpg','data/Scan2_Pic0002.jpg',[5 4 8 7 9 9 0 3 9 1 2 5 0 2 3 1 2 7 6 8 3 6 2 5 6 3 9 1 5 2 3 7 1 8 0 5]);
[nnInput, nnTarget, trainInput3, trainTarget3, testInput3, testTarget3] = quickRead('data/Scan3_Pic0001.jpg','data/Scan3_Pic0002.jpg',[3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 7 6 9 8 0 8 7 6 5 4 3 6 2]);
fprintf('Complete.\n');


fprintf('Combining data...');
trainInput = [trainInput1;trainInput2;trainInput3];
trainTarget = [trainTarget1;trainTarget2;trainTarget3];
testInput = [testInput1;testInput2;testInput3];
testTarget = [testTarget1;testTarget2;testTarget3];

clear nnInput nnTarget
clear trainInput1 trainInput2 trainInput3 trainTarget1 trainTarget2 trainTarget3
clear testInput1 testInput2 testInput3 testTarget1 testTarget2 testTarget3

fprintf('Complete.\n');

%Train and test the network
fprintf('Training Neural Network (30s)...');
[Wij Whh Wkj]=nnetDynHidTRAIN(trainInput, trainTarget, 0.01, 30);
fprintf('Complete.\n');
fprintf('Testing Neural Network...');
[testResult]=nnetDynHidTEST(testInput, Wij, Whh, Wkj);
fprintf('Complete.\n');

fprintf('Computing results:\n');
error = computeError(testTarget,testResult);
eStore(1) = sum(error);

fprintf('Training Neural Network (60s)...');
[Wij Whh Wkj]=nnetDynHidTRAIN(trainInput, trainTarget, 0.01, 60);
fprintf('Complete.\n');
fprintf('Testing Neural Network...');
[testResult]=nnetDynHidTEST(testInput, Wij, Whh, Wkj);
fprintf('Complete.\n')

fprintf('Computing results:\n');
error = computeError(testTarget,testResult);
eStore(2) = sum(error);

fprintf('Training Neural Network (300s)...');
[Wij Whh Wkj]=nnetDynHidTRAIN(trainInput, trainTarget, 0.01, 300);
fprintf('Complete.\n');
fprintf('Testing Neural Network...');
[testResult]=nnetDynHidTEST(testInput, Wij, Whh, Wkj);
fprintf('Complete.\n');

fprintf('Computing results:\n');
error = computeError(testTarget,testResult);
eStore(3) = sum(error);

fprintf('Training Neural Network (600s)...');
[Wij Whh Wkj]=nnetDynHidTRAIN(trainInput, trainTarget, 0.01, 600);
fprintf('Complete.\n');
fprintf('Testing Neural Network...');
[testResult]=nnetDynHidTEST(testInput, Wij, Whh, Wkj);
fprintf('Complete.\n');

fprintf('Computing results:\n');
error = computeError(testTarget,testResult);
eStore(4) = sum(error);

trueResponse = [1 7 5 1 4 2 5 6 8 4 3 6 2 1 7 8 3 9 2 5 1 3 5 7 2 9 4 ...
                0 8 0 9 3 6 7 1 0 5 4 8 7 9 9 0 3 9 1 2 5 0 2 3 1 2 7 ...
                6 8 3 6 2 5 6 3 9 1 5 2 3 7 1 8 0 5 3 4 5 6 7 8 9 0 1 ...
                2 3 4 5 6 7 8 9 0 1 2 3 4 5 7 6 9 8 0 8 7 6 5 4 3 6 2];

calcResponse = zeros(size(trueResponse));
for i = 1:length(calcResponse);
    calcResponse(i) = binaryResponse(testResult(i,:));
end

correctResponse = trueResponse(trueResponse==calcResponse);
falseResponse = trueResponse(trueResponse~=calcResponse);