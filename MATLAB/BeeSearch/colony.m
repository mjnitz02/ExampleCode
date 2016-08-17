% ClassDef - COLONY
% CECS660 - Bioinformatics
% Author: Matt Nitzken
%
% Dependencies:
%   field, bee
%
% Constructors:
%   obj=colony(count,type,motifLen,spread,params)
% 
% Description:
% A colony is a collective of like bees that can be batch operated on
% ---------------------------------------------------

classdef colony

    properties
        % data properties
        colonyType
        colonySize %is a bee a searcher, drone or worker
        members
    end
    
    methods
        function obj=colony(count,type,motifLen,spread,params)
            obj.colonyType = type;
            obj.colonySize = count;
            obj.members = cell(count,1);
            
            if (~exist('params','var')); params = 0; end
            
            for i = 1:count
                if (type==2)
                    obj.members{i} = bee(type,motifLen,spread,{params;round(i*(params/count))});
                else
                    obj.members{i} = bee(type,motifLen,spread);
                end
            end
        end
        
        function [obj] = colonyMembersSearch(obj,field)
            for i = 1:obj.colonySize
                obj.members{i} = searchField(field,obj.members{i});
            end
        end
        
        function [obj] = colonyMembersUpdate(obj,field)
            for i = 1:obj.colonySize
                obj.members{i} = updateBeeAgainstField(field,obj.members{i});
            end
        end
        
        function [scoreMatrix] = colonyMembersRank(obj)
            scores = zeros(obj.colonySize,1);
            for i = 1:obj.colonySize
                scores(i) = sum(sum(obj.members{i}.RelEntropy));
            end
            
            [score paths] = sort(scores,'descend');
            typeM = ones(length(score),1)*obj.colonyType;
            scoreMatrix = [score paths typeM];
        end
        
        function [obj] = adjustColonyWorkers(obj)
            for i=1:obj.colonySize
                obj.members{i}.sLogOdds = obj.members{i}.LogOdds;
            end
        end 
        
        function [obj] = adjustColonyDrones(obj,colonyOrigin,field)
            nbrs = round(exp(0:1/obj.colonySize:1));
            for i=1:obj.colonySize
                [paths score] = rankBeeAgainstField(field,colonyOrigin.members{nbrs(i)});
                obj.members{i}.restrictions = paths(1:obj.members{i}.spread)';
            end
        end
        
        function [obj] = adjustColonyMutantDrones(obj,colonyOrigin)
            nbrs = round(exp(0:1/obj.colonySize:1));
            for i=1:obj.colonySize
                obj.members{i} = mutateDrone(obj.members{i},colonyOrigin.members{nbrs(i)});
            end
        end
    end
    
    methods(Static)
        %there are currently no static methods for a colony
    end
end