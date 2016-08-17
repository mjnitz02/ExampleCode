%[identityMatrix]=nnetDynHidTEST(input, Wij, Whh, Wkj)
% --------------------
% ECE 614 - Final Project
% Author: Matt Nitzken

function [identityMatrix]=nnetDynHidTEST(input, Wij, Whh, Wkj)

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
            netHO(i) = 1/(1+exp(-(netH(i))));
        end

        %-----------------------
        %Calculate HIDDEN-SECONDPASS
        netHS=zeros(hiddenNodes,1) ;
        for i=1:hiddenNodes
            for j=1:hiddenNodes
                netHS(i) = netHS(i)+netHO(j)*Whh(j,i);
            end
        end
        netHH=zeros(hiddenNodes,1);
        for i=1:hiddenNodes
            netHH(i) = 1/(1+exp(-(netHS(i))));
        end

        %Calculate OUTPUT
        netO=zeros(1,outputNodes);
        for i=1:outputNodes
            for j=1:hiddenNodes
            netO(i)=netO(i)+netHH(j)*Wkj(j,i);
            end
        end
        netOO=zeros(outputNodes,1);
        for i=1:outputNodes
            netOO(i) = 1/(1+exp(-(netO(i))));
        end

    identityMatrix(iter,:) = round(netOO(:));
end