classdef eternityII
% Eternity II Object
% v0.6.8
% Author: Matt Nitzken
% 
% An E2 object and its control methods are defined in this class.  The
% object simulates a board representative of the Eternity II board game and
% is an NP-Complete problem for a board of size NxN.  This object attempts
% to simplify the construction and solving routines of this complex game
% for usage by a genetic algorithm.
    
    properties
    %Eternity II object properties
        tiles %the dimensions
        tileMatrix %the tile storage
        tileRotate %the rotation storage
    end
    
    methods (Static)
        % no static methods atm
    end
    
    methods

        function obj=eternityII(tileCount)
        % obj=eternityII(tileCount)
        % Desc: Create an Eternity II object
        %NEW TILE DEFINITION
        % - a tile is located at i,j
        % - a tile is defined as a string of numbers (4 values)
        % - a rotation variable determines the rotation of a tile (0-3)
            
            obj.tiles = tileCount; %define number of tiles
            obj.tileMatrix = zeros(tileCount,tileCount,4); %create an empty tile matrix
            obj.tileRotate = zeros(tileCount,tileCount); %create an empty rotation matrix
        end
        
        function displayBoard(obj)
        % displayBoard(obj)
        % Desc: Display a plot of an Eternity II Board
            
            clf; hold on %clear plot and set controls
            sVal = obj.tiles; %get dimensions of the board
            colVals = {'k';'r';'c';'g';'m'}; %color vals [0-black, 1-red, 2-blue, 3-green, 4-yellow];
            
            %plot all tiles
            for i=1:sVal
                for j=1:sVal
                    [tile] = getCurrentTile(obj,i,j); %get the current REAL tile
                    plot(j,i-.25,'^','Color',colVals{tile(1)+1}); %plot its north val
                    plot(j,i+.25,'v','Color',colVals{tile(3)+1}); %plot its south val
                    plot(j+.25,i,'<','Color',colVals{tile(2)+1}); %plot its east val
                    plot(j-.25,i,'>','Color',colVals{tile(4)+1}); %plot its west val
                end
            end
        end
        
        function [obj2] = mutateBoard(obj,chanceVal,attemptVal)
        % [obj2] = mutateBoard(obj,chanceVal,attemptVal)
        % Desc: The mutation algorithm for an Eternity II object
        % Details:
        % There are 2 control variables: chance and attempt
        % Chance - The chance a mutation will be undergone during an attempt
        % Attempts - The maximum number of possible mutations that can
        % occur during one generation change (i.e. the max tiles that COULD
        % mutate.  This does not mean they will all actually mutate)
        % An E2 obj can undergo 3 types of mutation (swap, rotate or swap & rotate).
            
            obj2 = obj;
            for iter = 1:attemptVal
                if (rand<=chanceVal)
                    type = round(rand.*2);
                    
                    loc1 = [round(rand*(obj2.tiles-1))+1 round(rand*(obj2.tiles-1))+1];
                    loc2 = [round(rand*(obj2.tiles-1))+1 round(rand*(obj2.tiles-1))+1];
                    if (type == 0)
                        %swap 2 tiles
                        tile_0 = squeeze(obj2.tileMatrix(loc1(1),loc1(2),:));
                        tile_0R = obj2.tileRotate(loc1(1),loc1(2));
                        
                        tile_1 = squeeze(obj2.tileMatrix(loc2(1),loc2(2),:));
                        tile_1R = obj2.tileRotate(loc2(1),loc2(2));
                       
                        obj2.tileMatrix(loc1(1),loc1(2),:) = tile_1;
                        obj2.tileRotate(loc1(1),loc1(2)) = tile_1R;
                        
                        obj2.tileMatrix(loc2(1),loc2(2),:) = tile_0;
                        obj2.tileRotate(loc2(1),loc2(2)) = tile_0R;
                    elseif (type == 1)
                        %turn a tile
                        tile_0R = obj.tileRotate(loc1(1),loc1(2)); %get its rotation component
                        [tile_0R] = rotateTile(tile_0R);
                        obj2.tileRotate(loc1(1),loc1(2)) = tile_0R; %update its new rotation
                        
                    elseif (type == 2)
                        %swap 2 tiles
                        %turn both tiles
                        tile_0 = squeeze(obj2.tileMatrix(loc1(1),loc1(2),:));
                        tile_0R = obj2.tileRotate(loc1(1),loc1(2));
                        
                        tile_1 = squeeze(obj2.tileMatrix(loc2(1),loc2(2),:));
                        tile_1R = obj2.tileRotate(loc2(1),loc2(2));
                        
                        [tile_0R] = rotateTile(tile_0R);
                        [tile_1R] = rotateTile(tile_1R);

                        obj2.tileMatrix(loc1(1),loc1(2),:) = tile_1;
                        obj2.tileRotate(loc1(1),loc1(2)) = tile_1R;
                        
                        obj2.tileMatrix(loc2(1),loc2(2),:) = tile_0;
                        obj2.tileRotate(loc2(1),loc2(2)) = tile_0R;
                    end
                end
            end
        end
        
        
        function [obj] = fillE2Tiles(obj,fillData,rotateData)
        % [obj] = fillE2Tiles(obj,fillData,rotateData)
        % Desc: Fill an E2 board using a control list.  This function has mostly
        % been deprecated and is not currently used to fill a board.
        % Details: It is manually used to fill an E2 with a manually constructed
        % board
        
            iter = 1;
            for i=1:obj.tiles
                for j=1:obj.tiles
                    for pos=1:4
                        obj.tileMatrix(i,j,pos) = fillData(iter,pos);
                    end
                    
                    obj.tileRotate(i,j) = rotateData(iter);
                    iter = iter+1;
                end
            end
        end
        
        
        function [tile] = getCurrentTile(obj,posI,posJ)
        % [tile] = getCurrentTile(obj,posI,posJ)
        % Desc: Get a current 'Real' tile
        % Details: This is a confusing function... Tiles are stored as a
        % set listing of numbers.  There are many ways to correctly arrange
        % tiles into a potential solution and therefore a tile can be
        % 'rotated' by the algorithm to try and find optimum boards as it
        % is highly possible a complete board could be entered with pieces
        % incorrectly turned.  This function will take the 'data' and
        % return a [4x1] matrix of its 'REAL' form.  In this sense data for
        % a piece is never changed during a mutation, it simply rotates
        % using a variable and thus the initial pieces cannot be
        % accidentally destroyed and can be compared to a general crowd
        % control population.
           
            data = obj.tileMatrix(posI,posJ,:);
            rotVal = obj.tileRotate(posI,posJ);

            while(rotVal~=0)
                data = [data(4);squeeze(data(1:3))];
                rotVal = rotVal-1;
            end
            
            tile = data;
        end
        
        
        function [cost] = getE2Cost(obj)
        % [cost] = getE2Cost(obj)
        % Desc: Get the cost of the current E2 object
        % Details: Cost is determined by the number of correctly placed
        % pieces.  To avoid checking overlap pieces from 1:tiles-1 are
        % compared on the bottom and right to the adjacent pieces top and
        % left.  If a tile matches it gets a score of 1 if not a score of
        % 0.  On the right boundary only down pieces are checked and on the
        % bottom boundary only right pieces are checked.  The last cell
        % (i.e. (tiles,tiles)) has already been 'checked' through checking
        % other pieces and thus its cost is inheritely ignored.
        
            cost = 0;
            for i=1:obj.tiles
                for j=1:obj.tiles
                    %check only down and right for equivalence
                    %check only right for equivalence in last row
                    check = 0;
                    if (i<obj.tiles) %if not last row
                        if (j<obj.tiles) %if not last column
                            tile_0 = getCurrentTile(obj,i,j);
                            tile_R = getCurrentTile(obj,i,j+1);
                            tile_D = getCurrentTile(obj,i+1,j);
                            check = compareTiles(tile_0,tile_D,0) + compareTiles(tile_0,tile_R,1);
                        else %if is last column (there is no E for this col)
                            tile_0 = getCurrentTile(obj,i,j);
                            tile_D = getCurrentTile(obj,i+1,j);
                            check = compareTiles(tile_0,tile_D,0);
                        end
                    else %if is last row (there is no S for this row)
                        if (j<obj.tiles) %if not last column
                            tile_0 = getCurrentTile(obj,i,j);
                            tile_R = getCurrentTile(obj,i,j+1);
                            check = compareTiles(tile_0,tile_R,1);
                        else %if is last column (there is no E or S)
                            %therefore we do nothing
                        end
                    end
                    
                    cost = cost + check; %keep running sum of cost
                end
            end
        end
        
        function [score] = getE2Score(obj)
        % [cost] = getE2Cost(obj)
        % Desc: Get the cost of the current E2 object
        % Details: Cost is determined by the number of correctly placed
        % pieces.  To avoid checking overlap pieces from 1:tiles-1 are
        % compared on the bottom and right to the adjacent pieces top and
        % left.  If a tile matches it gets a score of 1 if not a score of
        % 0.  On the right boundary only down pieces are checked and on the
        % bottom boundary only right pieces are checked.  The last cell
        % (i.e. (tiles,tiles)) has already been 'checked' through checking
        % other pieces and thus its cost is inheritely ignored.
        
            score = 0;
            %check main matrix for color comparisons
            for i=2:obj.tiles-1
                for j=2:obj.tiles-1
                    
                    tile_0 = getCurrentTile(obj,i,j);
                    tile_D = getCurrentTile(obj,i+1,j);
                    tile_R = getCurrentTile(obj,i,j+1);
                    
                    if ~((tile_0(2) == 0) && (tile_R(4) == 0))
                        score = score + 2*(tile_0(2) == tile_R(4));
                    end
                    if ~((tile_0(3) == 0) && (tile_D(1) == 0))
                        score = score + 2*(tile_0(3) == tile_D(1));
                    end
                end
            end
            
            %check corners for accuracy
            tile_0 = getCurrentTile(obj,1,1);
            tile_R = getCurrentTile(obj,1,2);
            tile_D = getCurrentTile(obj,2,1);
            if (tile_0(1) == 0); score = score + 1; end
            if (tile_0(4) == 0); score = score + 1; end
                if ~((tile_0(2) == 0) && (tile_R(4) == 0))
                    score = score + 2*(tile_0(2) == tile_R(4));
                end
                if ~((tile_0(3) == 0) && (tile_D(1) == 0))
                    score = score + 2*(tile_0(3) == tile_D(1));
                end            
            tile_0 = getCurrentTile(obj,1,obj.tiles);
            tile_D = getCurrentTile(obj,2,obj.tiles);
            if (tile_0(1) == 0); score = score + 1; end
            if (tile_0(2) == 0); score = score + 1; end
                if ~((tile_0(3) == 0) && (tile_D(1) == 0))
                    score = score + 2*(tile_0(3) == tile_D(1));
                end
            tile_0 = getCurrentTile(obj,obj.tiles,1);
            tile_R = getCurrentTile(obj,obj.tiles,2);
            if (tile_0(3) == 0); score = score + 1; end
            if (tile_0(4) == 0); score = score + 1; end
                if ~((tile_0(2) == 0) && (tile_R(4) == 0))
                    score = score + 2*(tile_0(2) == tile_R(4));
                end
            tile_0 = getCurrentTile(obj,obj.tiles,obj.tiles);
            if (tile_0(2) == 0); score = score + 1; end
            if (tile_0(3) == 0); score = score + 1; end

            
            for j=2:obj.tiles-1
                tile_0 = getCurrentTile(obj,1,j);
                tile_D = getCurrentTile(obj,2,j);
                tile_R = getCurrentTile(obj,1,j+1);
                
                if ~((tile_0(2) == 0) && (tile_R(4) == 0))
                    score = score + 2*(tile_0(2) == tile_R(4));
                end
                if ~((tile_0(3) == 0) && (tile_D(1) == 0))
                    score = score + 2*(tile_0(3) == tile_D(1));
                end
                if (tile_0(1) == 0); score = score + 1; end
            end
            for j=2:obj.tiles-1
                tile_0 = getCurrentTile(obj,obj.tiles,j);
                tile_R = getCurrentTile(obj,obj.tiles,j+1);
                if ~((tile_0(2) == 0) && (tile_R(4) == 0))
                    score = score + 2*(tile_0(2) == tile_R(4));
                end
                if (tile_0(3) == 0); score = score + 1; end
            end
            for i=2:obj.tiles-1
                tile_0 = getCurrentTile(obj,i,1);
                tile_D = getCurrentTile(obj,i+1,1);
                tile_R = getCurrentTile(obj,i,2);
                if ~((tile_0(2) == 0) && (tile_R(4) == 0))
                    score = score + 2*(tile_0(2) == tile_R(4));
                end
                if ~((tile_0(3) == 0) && (tile_D(1) == 0))
                    score = score + 2*(tile_0(3) == tile_D(1));
                end
                if (tile_0(4) == 0); score = score + 1; end
            end
            for i=2:obj.tiles-1
                tile_0 = getCurrentTile(obj,i,1);
                tile_D = getCurrentTile(obj,i+1,1);
                if ~((tile_0(3) == 0) && (tile_D(1) == 0))
                    score = score + 2*(tile_0(3) == tile_D(1));
                end
                if (tile_0(2) == 0); score = score + 1; end
            end
                
            
        end
        
        function [uniqueE2, uniqueE2Count] = findUnique(obj)

            uniqueE2 = zeros(1,4);
            uniqueE2Count = zeros(1);

            for i=1:obj.tiles
                for j=1:obj.tiles
                    var = squeeze(obj.tileMatrix(i,j,:));
                    add = 1;
                    for iter = 1:size(uniqueE2,1)
                        temp = squeeze(uniqueE2(iter,:))';
                        if (sum(temp==var)==4)
                            uniqueE2Count(iter) = uniqueE2Count(iter)+1;
                            add = 0;
                            break
                        end
                    end

                    if (add)
                        uniqueE2(size(uniqueE2,1)+1,1:4) = var;
                        uniqueE2Count(length(uniqueE2Count)+1) = 1;
                    end
                end
            end
            uniqueE2(1,:) = [];
            uniqueE2Count(1) = [];
            uniqueE2Count = uniqueE2Count';

        end
    end
    
end

%find if tiles match
function [val] = compareTiles(tile1,tile2,mode)

    if (mode)
        if ((tile1(2) == 0) && (tile1(4) == 0))
            val = 0;
        else
            val = (tile1(2) == tile2(4));
        end
    else
        if ((tile1(3) == 0) && (tile1(1) == 0))
            val = 0;
        else
            val = (tile1(3) == tile2(1));
        end
    end
end

function [score] = scoreTiles(tile1,tile2,mode,subMode)

    score = 0;
    
    switch mode
        
        case 1
            if ~((tile1(2) == 0) && (tile2(4) == 0))
                score = score + 2*(tile1(2) == tile2(4));
            end
            
        case 2
            if ~((tile1(3) == 0) && (tile2(1) == 0))
                score = score + 2*(tile1(3) == tile2(1));
            end
            
        case 3
            switch subMode
                case 1
                    if (tile1(1) == 0); score = score + 1; end
                    if (tile1(4) == 0); score = score + 1; end
                case 2
                    if (tile1(1) == 0); score = score + 1; end
                    if (tile1(2) == 0); score = score + 1; end
                case 3
                    if (tile1(2) == 0); score = score + 1; end
                    if (tile1(3) == 0); score = score + 1; end
                case 4
                    if (tile1(3) == 0); score = score + 1; end
                    if (tile1(4) == 0); score = score + 1; end
                otherwise
                    score = 0;
            end
            
        case 4
            switch subMode
                case 1
                    if (tile1(1) == 0); score = score + 1; end
                case 2
                    if (tile1(2) == 0); score = score + 1; end
                case 3
                    if (tile1(3) == 0); score = score + 1; end
                case 4
                    if (tile1(4) == 0); score = score + 1; end
                otherwise
                    score = 0;
            end
        
        otherwise
            score = 0;
    end
end

function [rotVal] = rotateTile(rotVal)

    change = round(rand*3);

    for i = 1:change
        rotVal = rotVal + 1;
        if (rotVal>3); rotVal = 0; end
    end           
end