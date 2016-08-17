function [newBoard] = buildEIIBoard(tiles)
% [newBoard] = buildEIIBoard(tiles)
% 
% v1.0.0
% Author: Matt Nitzken
% Dependancies: eternityII object class
% 
% Desc: This function constructs a perfect Eternity II board.  This ensures
% that the test case is 'potentially' solvable.  After randomizing the
% pieces and rotations from this perfect board there is no gaurantee that
% an algorithm will actually solve it, but it ensures that there is a
% possibility that it can be solved.

    newBoard = eternityII(tiles);
    
    for i=1:tiles
        for j=1:tiles
            
            if (i<newBoard.tiles) %if not last row
                if (j<newBoard.tiles) %if not last column
                    val1 = round(rand*3)+1;
                    val2 = round(rand*3)+1;
                    tile_0 = newBoard.tileMatrix(i,j,:);
                    tile_R = newBoard.tileMatrix(i,j+1,:);
                    tile_D = newBoard.tileMatrix(i+1,j,:);
                    
                    tile_0(2) = val1;
                    tile_R(4) = val1;
                    
                    tile_0(3) = val2;
                    tile_D(1) = val2;
                    
                    newBoard.tileMatrix(i,j,:) = tile_0;
                    newBoard.tileMatrix(i,j+1,:) = tile_R;
                    newBoard.tileMatrix(i+1,j,:) = tile_D;
                else %if is last column (there is no E for this col)
                    val1 = round(rand*3)+1;
                    tile_0 = newBoard.tileMatrix(i,j,:);
                    tile_D = newBoard.tileMatrix(i+1,j,:);

                    tile_0(3) = val1;
                    tile_D(1) = val1;
                    
                    newBoard.tileMatrix(i,j,:) = tile_0;
                    newBoard.tileMatrix(i+1,j,:) = tile_D;
                end
            else %if is last row (there is no S for this row)
                if (j<newBoard.tiles) %if not last column
                    val1 = round(rand*3)+1;
                    tile_0 = newBoard.tileMatrix(i,j,:);
                    tile_R = newBoard.tileMatrix(i,j+1,:);
                    
                    tile_0(2) = val1;
                    tile_R(4) = val1;

                    newBoard.tileMatrix(i,j,:) = tile_0;
                    newBoard.tileMatrix(i,j+1,:) = tile_R;
                else %if is last column (there is no E or S)
                    %therefore we do nothing
                end
            end
        end    
    end

end