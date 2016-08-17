% ------------------------------------------------------
%   [identityMatrix]=nnetTEST(input, Wij, Wkj)
%   Description: Will TEST a neural network on given inputs
%   Author: Matt Nitzken
%
%   Required Dependancies:
%	none
%
%   inputs:
%          input: a Neural Network input array (AxB)
%	   Wij: Input->Hidden Weights
%	   Wkj: Hidden->Ouput Weights
%
%   outputs:
%          identityMatrix: Computed target matrix (Ax6)
%
% ------------------------------------------------------

function [identityMatrix]=nnetTEST(input, Wij, Wkj)

inputNodes = size(input,2);
hiddenNodes = size(Wkj,1);
outputNodes = size(Wkj,2);

%identityMatrix = zeros(size(input,1),outputNodes);

for iter = 1:size(input,1)
    %Extract a sample input and target
    dataSet = input(iter,:);

    %-----------------------
    %Calculate HIDDEN
    netH=zeros(hiddenNodes,1);
    for i=1:hiddenNodes
        for j=1:inputNodes
        netH(i)=netH(i)+dataSet(j)*Wij(j,i);
        end
    end
    netHO=zeros(hiddenNodes,1);
    for i=1:hiddenNodes
        netHO(i) = 2/(1+exp(-(netH(i))))-1;
    end


    %Calculate OUTPUT
    netO=zeros(1,outputNodes);
    for i=1:outputNodes
        for j=1:hiddenNodes
        netO(i)=netO(i)+netHO(j)*Wkj(j,i);
        end
    end
    netOO=zeros(outputNodes,1);
    for i=1:outputNodes
        netOO(i) = 2/(1+exp(-(netO(i))))-1;
    end

    identityMatrix(iter,:) = sign(netOO(:));
end