function [wocObj] = findWoCE2P(objMatrix,locOccur,rotOccur)

    obj = objMatrix{1}; %get the first object
    [uniqueE2, uniqueE2Count] = obj.findUnique; %find its unique tiles
%     [locOccur rotOccur] = findOccurence(objMatrix,uniqueE2); %find the occurence matrix
    
    %ok i have the unique tiles and occurences so I now need to generate a
    %new board......
    wocObj = eternityII(obj.tiles);
    for i=1:obj.tiles
        for j=1:obj.tiles
            %Lets find the most common tile that can go here:
            posVals = squeeze(locOccur(i,j,:)); %take vals
            posVals(:,2) = 1:length(posVals); %create indexing
            posVals = flipud(sortrows(posVals)); %flip and sort by rows
            
            indexer = 1;
            search = 1;
            searchResult = 0;
            
            while(search)
                if(uniqueE2Count(posVals(indexer,2))>0)
                    searchResult = uniqueE2(posVals(indexer,2),:);
                    uniqueE2Count(posVals(indexer,2)) = uniqueE2Count(posVals(indexer,2)) - 1;
                    search = 0;
                else
                    indexer = indexer+1;
                end
            end
            
            posVals = squeeze(rotOccur(i,j,posVals(indexer,2),:)); %take vals
            posVals(:,2) = 1:length(posVals); %create indexing
            posVals = flipud(sortrows(posVals)); %flip and sort by rows
            
            rotType = posVals(2,1);
            
            wocObj.tileMatrix(i,j,:) = searchResult;
            wocObj.tileRotate(i,j) = rotType;
        end
    end

end

%% 
function [locOccur rotOccur] = findOccurence(objMatrix,uniqueE2)
% [locOccur rotOccur] = findOccurence(objMatrix,uniqueE2)
% 
% v1.0.0
% Author: Matt Nitzken
% Dependancies: eternityII object class, uniqueE2
% 
% Description: This is another painful algorithm... To track the wisdom of
% crowds decision 2 matrices are created.  An [NxNxsize(uniqueE2)] (3-D) matrix
% is constructed to count each time a unique tile occurs in a location.  An
% [NxNxsize(uniqueE2)x4] (4-D) matrix is constructed to track how often a
% specific rotation occurs for a unique tiling at a given location.  Using
% these I can calculate what the most common occurence of a tile is at a
% given location and what the most common orientation of that tile at a
% given location is.  This essentially creates a 2 part cost occurence
% matrix.

    obj = objMatrix{1};
    
    locOccur = zeros(obj.tiles,obj.tiles,size(uniqueE2,1));
    rotOccur = zeros(obj.tiles,obj.tiles,size(uniqueE2,1),4);
    
    for a=1:length(objMatrix)
        
        obj = objMatrix{a};
    
        for i=1:obj.tiles
            for j=1:obj.tiles
                var = squeeze(obj.tileMatrix(i,j,:));
                rot = obj.tileRotate(i,j);

                pos = 0;
                for iter = 1:size(uniqueE2,1)
                    temp = squeeze(uniqueE2(iter,:))';
                    if (sum(temp==var)==4)
                        pos = iter;
                        break
                    end
                end

                locOccur(i,j,pos) = locOccur(i,j,pos) + 1;
                rotOccur(i,j,pos,rot+1) = rotOccur(i,j,pos,rot+1) + 1;
            end
        end
        
    end

end