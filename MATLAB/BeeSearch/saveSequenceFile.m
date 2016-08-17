% saveSequenceFile(LOmatrix,REmatrix,motifStore,sequences,mPos,mScore)
% CECS660 - Bioinformatics
% Author: Matt Nitzken
% 
% Description:
% Save the specified information to an output file
% ---------------------------------------------------

function saveSequenceFile(LOmatrix,REmatrix,motifStore,sequences,mPos,mScore)

%     filepath = strcat('Output_',datestr(clock,'dd-mm-yyyy_HH:MM:SS'),'.txt')
    
    mSize = length(motifStore{1});
    hDat = ['A' 'C' 'G' 'T'];
    fid=fopen(strcat('Output_',datestr(clock,'dd-mm-yyyy_HH_MM_SS'),'.txt'),'w'); %open a file for reading

    fprintf(fid,'BeeSearch Results\r\n');
    fprintf(fid,'\r\n');
    fprintf(fid,'NOTE: This file has been formatted to easily load into Microsoft Excel\r\n');
    fprintf(fid,'or any another spreadsheet software for an easier visualization.\r\n');
    fprintf(fid,'\r\n');
    

    %print relative entropy matrix
    fprintf(fid,'Best Relative Entropy:\t%0.4f\r\n\n',sum(sum(REmatrix)));
    fprintf(fid,'Final Relative Entropy Matrix:\r\n');
    fprintf(fid,'\t');
    for i=1:mSize
        fprintf(fid,'%d\t',i);
    end
    fprintf(fid,'\r\n');
    for i=1:4
        fprintf(fid,hDat(i));
        fprintf(fid,'\t');
        for j = 1:mSize
            fprintf(fid,'%0.4f\t',REmatrix(i,j));
        end
        fprintf(fid,'\r\n');
    end
    fprintf(fid,'Col. Entropy:\t');
    temp = sum(REmatrix);
    for i = 1:mSize
        fprintf(fid,'%0.4f\t',temp(i));
    end
    fprintf(fid,'\r\n');
    fprintf(fid,'\r\n');
    
    
    %print log-odds matrix
    fprintf(fid,'Final Log-Odds Matrix:\r\n');
    fprintf(fid,'\t');
    for i=1:mSize
        fprintf(fid,'%d\t',i);
    end
    fprintf(fid,'\r\n');
    for i=1:4
        fprintf(fid,hDat(i));
        fprintf(fid,'\t');
        for j = 1:mSize
            fprintf(fid,'%0.4f\t',LOmatrix(i,j));
        end
        fprintf(fid,'\r\n');
    end
    fprintf(fid,'\r\n');
    
    
    %print final motifs
    fprintf(fid,'Final Motifs:\r\n');
    fprintf(fid,'Sequence #\tLocation\tScore\tMotif\tFull Sequence\r\n');
    for i=1:length(motifStore)
        fprintf(fid,'Seq%d\t%d\t%0.3f\t',i,mPos(i),mScore(i));
        temp = motifStore{i};
        rMotif='';
        for j = 1:length(temp)
            rMotif = strcat(rMotif,getGChar(temp(j)));
        end
        fprintf(fid,rMotif);
        fprintf(fid,'\t');
        temp = sequences{i};
        rSeq='';
        for j = 1:length(temp)
            rSeq = strcat(rSeq,getGChar(temp(j)));
        end
        fprintf(fid,rSeq);
        fprintf(fid,'\r\n');
    end
    
    fclose(fid); %close the file
    
end

function [charVal] = getGChar(numVal)
    switch numVal
        case 1;
            charVal = 'A';
        case 2;
            charVal = 'C';
        case 3;
            charVal = 'G';
        case 4;
            charVal = 'T';
    end
end