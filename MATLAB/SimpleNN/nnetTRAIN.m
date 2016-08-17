% ------------------------------------------------------
%   [Wij Wkj]=nnetTRAIN(input, target, eta, count)
%   Description: Will TEST a neural network on given inputs
%   Author: Matt Nitzken
%
%   Required Dependancies:
%	none
%
%   inputs:
%      input: a Neural Network input array (AxB)
%	   target: a Neural Network target array (Ax6)
%	   eta: the training weight
%	   count: the number of training iterations
%
%   outputs:
%	   Wij: Input->Hidden Weights
%	   Wkj: Hidden->Ouput Weights
%
% ------------------------------------------------------

function [Wij Wkj]=nnetTRAIN(input, target, iterations)

    inputNodes = size(input,2);
    hiddenNodes = 24;
    outputNodes = 1;

    %starting weights
    Wij=sign(rand(inputNodes,hiddenNodes) - .5);%(rand(inputNodes,hiddenNodes) - .5)/1000;%(1/inputNodes)*ones(inputNodes,hiddenNodes); %Input to hidden
    Wkj=sign(rand(hiddenNodes,outputNodes) - .5);%(rand(hiddenNodes,outputNodes) - .5)/1000;%(1/hiddenNodes)*ones(hiddenNodes,outputNodes); %Hidden to output

    fprintf('Beginning network training...\nTime Remaining: %ds',time);

    tic
    for counter = 1:iterations
        for iter = 1:size(input,1)
            %Extract a sample input and target
            dataSet = input(iter,:);
            dataTar = target(iter,:);


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

            
            %-----------------------
            %Calculate Error Value for OUTPUT
            evO = zeros(outputNodes,1);
            for i=1:outputNodes
                evO(i) = (1/2) * (dataTar(i)-netOO(i)) * (1-(netOO(i)^2));
            end

            %Calculate Error Value for HIDDEN
            evH = zeros(hiddenNodes,1);
            for i=1:hiddenNodes

                net = 0;
                for j=1:outputNodes
                    net = net + (evO(j)*(Wkj(i,j)));
                end
                evH(i) = (1/2) * (1-netHO(i)^2) * net;
            end


            %-----------------------
            %Update INPUT->HIDDEN
            for i=1:inputNodes
                for j=1:hiddenNodes
                    Wij(i,j) = Wij(i,j) + (eta*evH(j));
%                     Wij(i,j) = Wij(i,j) + (eta*evH(j)*dataSet(i));
                end
            end

            %Update HIDDEN->OUTPUT
            for i=1:hiddenNodes
                for j=1:outputNodes
                    Wkj(i,j) = Wkj(i,j) + (eta*evO(j));
%                 Wkj(i,j) = Wkj(i,j) + (eta*evO(j)*(netHO(i)));
                end
            end
        end
    end
    fprintf('\nTraining Completed.\n');
end