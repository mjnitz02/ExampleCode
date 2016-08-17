% ClassDef - FIELD
% CECS660 - Bioinformatics
% Author: Matt Nitzken
%
% Dependencies:
%   field, colony
%
% Constructors:
%   obj=bee(type,motifLen,spread,params)
% 
% Description:
% This class is a bee constructor.  Bees are the local worker objects for
% targetted searching.  There are 5 types of bees each with unique
% restrictions and capabilities.  They search on a field for new paths.
% Some bees are capable of finding new matrices on their own.  Other bees
% work as a hive intelligence and search near other bees.

% Usage:
% These scores can then be compared externally to find the most successful
% bees.  The most successful bees are then used to target the next wave of
% bee searches.
% ---------------------------------------------------

%Bee types
% 1 - searcher
% 2 - local forager
% 3 - drone
% 4 - Mutant Drone
% 5 - Worker
classdef bee

    properties
        % data properties
        type %is a bee a searcher, drone or worker
        restrictions %0 - unrestriced, [data] - restricted
        spread %how much can a bee search
        mutation %if a bee is a drone-mutator what type is he?
        
        motifLen %what size motif is this bee searching for
        
        sLogOdds %the searching log odds a bee has
        LogOdds %the log odds of a bee after searching the field using his sLogOdds
        
        Entropy %the entropy of a bee
        RelEntropy %the relative entropy of a bee
    end
    
    methods
        function obj=bee(type,motifLen,spread,params)
            obj.type = type;
            obj.motifLen = motifLen;
            obj.spread = spread;
            if (~exist('params','var')); params = 0; end
            [obj.restrictions obj.mutation] = bee.tuneBee(type,spread,params);
        end
        
        %[bee] = scoreBeeSearch(bee,counts)
        function [bee] = scoreBeeSearch(bee,counts)
            counts = counts+1;
            prob = zeros(size(counts));
            for i = 1:size(prob,2)
                prob(:,i) = counts(:,i)./sum(counts(:,i));
            end
            
            bee.sLogOdds = zeros(4,bee.motifLen);
            for i = 1:size(bee.sLogOdds,1)
                for j = 1:size(bee.sLogOdds,2)
                    bee.sLogOdds(i,j) = log2(prob(i,j+1)/prob(i,1));
                end
            end
        end
        
        function [bee] = searchNearBee(bee,beeOrigin,field)
            [paths score] = rankBeeAgainstField(field,beeOrigin);
            bee.restrictions = paths(1:bee.spread);
        end

        function [bee] = mutateDrone(bee,beeOrigin)
            %this function is incorrect
            switch bee.mutation;
                case 1;
                    bee.sLogOdds = flipud(beeOrigin.LogOdds);
                case 2;
                    bee.sLogOdds = fliplr(beeOrigin.LogOdds);
                case 3;
                    [a b] = size(beeOrigin.LogOdds);
                    temp = reshape(randperm(a*b),a,b);
                    bee.sLogOdds = beeOrigin.LogOdds(temp);
            end
        end
    end
    
    methods(Static)
        function [restrictions mutation] = tuneBee(type,spread,params)
            switch type
                case 1; %This is a SEARCHER bee
                    restrictions = 0;
                    mutation = 0;
                case 2; %This is a LOCAL FORAGER bee
                    if (params{2} == 1)
                        restrictions = 1:spread;
                    elseif (params{2} == params{1})
                        restrictions = params{1}-spread:params{1};
                    else
                        restrictions = params{2}-((spread-1)/2):params{2}+((spread-1)/2);
                        if (min(restrictions)<1); restrictions = restrictions + sum(restrictions<1); end
                        if (max(restrictions)>params{1}); restrictions = restrictions - sum(restrictions>params{1}); end
                    end
                    mutation = 0;
                case 3; %This is a DRONE bee
                    restrictions = -1; %bee is not allowed to search atm
                    mutation = 0;
                case 4; %This is a MUTANT DRONE bee
                    restrictions = -1; %bee is not allowed to search atm
                    temp = rand;
                    if (temp < 0.5)
                        mutation = 3; % a 3 mutation (rogue) is more common than any other type
                    elseif (temp < 0.75)
                        mutation = 2; %a side flip mutation
                    else
                        mutation = 1; %an inverted flip mutation
                    end
                case 5; %This is a WORKER bee
                    restrictions = -1; %bee is not allowed to search atm
                    mutation = 0;
            end
        end 
    end
end