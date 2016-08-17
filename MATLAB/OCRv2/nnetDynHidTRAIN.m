%[Wij Whh Wkj]=nnetDynHidTRAIN(input, target, eta, time)
% --------------------
% ECE 614 - Final Project
% Author: Matt Nitzken

function [Wij Whh Wkj]=nnetDynHidTRAIN(input, target, eta, time)


inputNodes = size(input,2);
hiddenNodes = 26;
outputNodes = 6;

%starting weights
Wij=(rand(inputNodes,hiddenNodes) - .5)/1000;%(1/inputNodes)*ones(inputNodes,hiddenNodes); %Input to hidden
Whh=(rand(hiddenNodes,hiddenNodes) - .5)/1000; %dynamic hidden layer pass
Wkj=(rand(hiddenNodes,outputNodes) - .5)/1000;%(1/hiddenNodes)*ones(hiddenNodes,outputNodes); %Hidden to output

fprintf('Beginning network training...\nTime Remaining: %ds',time);

tic
iterationTracker = 0;
while (toc < time)
    printSeconds(time-toc);
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

        %-----------------------
        %Calculate Error Value for OUTPUT
        evO = zeros(outputNodes,1);
        for i=1:outputNodes
            evO(i) = (dataTar(i)-netOO(i)) * (netOO(i)*(1-netOO(i)));
        end
        
        %Calculate Error Value for HIDDEN-SECOND PASS
        evHH = zeros(hiddenNodes,1);
        for i=1:hiddenNodes
            
            temp = 0;
            for j=1:outputNodes
                temp = temp+ (evO(j)*(Wkj(i,j)));
            end
            evHH(i) = temp * ((netHH(i)*(1-netHH(i))));
        end

        %Calculate Error Value for HIDDEN
        evH = zeros(hiddenNodes,1);
        for i=1:hiddenNodes
            
            temp = 0;
            for j=1:hiddenNodes
                temp = temp + (evHH(j)*(Whh(i,j)));
            end
            evH(i) = temp * (netHO(i)*(1-netHO(i)));
        end

        %-----------------------
        %Update INPUT->HIDDEN
        for i=1:inputNodes
            for j=1:hiddenNodes
                Wij(i,j) = Wij(i,j) + (eta*evH(j)*dataSet(i));
            end
        end
        
        %Update HIDDEN->HIDDEN-SECONDPASS
        for i=1:hiddenNodes
            for j=1:hiddenNodes
                Whh(i,j) = Whh(i,j) + (eta*evHH(j)*(netHH(i)));
            end
        end
        
        %Update HIDDEN->OUTPUT
        for i=1:hiddenNodes
            for j=1:outputNodes
            Wkj(i,j) = Wkj(i,j) + (eta*evO(j)*(netHO(i)));
            end
        end
    end
    iterationTracker = iterationTracker + 1;
end
fprintf('\nIteration Tracker: %d iterations completed.',iterationTracker);
fprintf('\nTraining Completed.\n');