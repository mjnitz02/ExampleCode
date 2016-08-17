% ClassDef - FIELD
% CECS660 - Bioinformatics
% Author: Matt Nitzken
%
% Dependencies:
%   bee, colony
% 
% Constructors:
%   obj=field(filepath)
% 
% Description:
% A field is a search space of dna sequences.  The current version is only
% optimized to read DNA based sequences, but it could be modified to
% examine proteins as well.  Reads an input from a FASTA file.
% ---------------------------------------------------

classdef field

    properties
        paths
        fSize
    end
    
    methods
        function obj=field(filepath)
            sequences = field.scanSequenceFastaFile(filepath);
            obj.paths = sequences;
            obj.fSize = length(sequences);
        end

        function [bee] = searchField(obj,bee)
            %build a log odds matrix from the bees search intelligence
            %search in a set area that a searcher is restricted to and
            %generate a new log odds for this local population
            
            %this will allow for case 0 - unrestricted bee search and for
            %case 1 - restricted bee search.
            rPaths = [];
            switch bee.type
                case 1;
                    rPaths = randperm(obj.fSize);
                    rPaths = rPaths(1:bee.spread);
                case 2;
                    rPaths = bee.restrictions;
            end
            [bee] = searchRestrictedPaths(obj,bee,rPaths);
        end
        
        function [bee] = searchRestrictedPaths(obj,bee,rPaths)
            %have a bee search for an sLogOdds inside a restricted path set
            localPaths = obj.paths(rPaths);
            
            counts = zeros(4,bee.motifLen+1);
            for i=1:length(localPaths)
                temp = localPaths{i};
                pos = round(rand*(length(temp)-bee.motifLen-1))+1;
                motif = temp(pos:pos+bee.motifLen-1); %make this position the motif
                back = temp; back(pos:pos+bee.motifLen-1) = [];
                for j = 1:4
                    counts(j,1) = counts(j,1) + sum(back==j);
                    counts(j,2:bee.motifLen+1) = counts(j,2:bee.motifLen+1) + (motif==j);
                end
            end
            
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
        
        function [bee] = updateBeeAgainstField(obj,bee)
            for i=1:length(obj.paths) %iterate through sequences finding best motifs
                [motif back] = field.getMaxPos(obj.paths{i},bee.sLogOdds,bee.motifLen);
                motifStore{i} = motif;
                bgStore{i} = back;
            end
            
            counts = zeros(4,bee.motifLen+1);
            for i = 1:length(motifStore)
                for j=1:4
                    counts(j,1) = counts(j,1) + sum(bgStore{i}==j);
                    counts(j,2:bee.motifLen+1) = counts(j,2:bee.motifLen+1) + (motifStore{i}==j);
                end
            end
            counts = counts+1;
            prob = zeros(size(counts));
            for i = 1:size(prob,2)
                prob(:,i) = counts(:,i)./sum(counts(:,i));
            end
            
            bee.LogOdds = zeros(4,bee.motifLen);
            bee.Entropy = bee.LogOdds; bee.RelEntropy = bee.LogOdds;
            
            for i = 1:size(bee.LogOdds,1)
                for j = 1:size(bee.LogOdds,2)
                    bee.LogOdds(i,j) = log2(prob(i,j+1)/prob(i,1));
                    bee.Entropy(i,j) = prob(i,j+1)*log2(prob(i,j+1));
                    bee.RelEntropy(i,j) = prob(i,j+1)*log2(prob(i,j+1)/prob(i,1));
                end
            end
        end
        
        function [paths score] = rankBeeAgainstField(obj,bee)
            score = zeros(length(obj.paths),1);
            for i=1:length(obj.paths) %iterate through sequences finding best motifs
                score(i) = field.getMaxFit(obj.paths{i},bee.LogOdds,bee.motifLen);
            end
            [score paths] = sort(score,'descend');
        end
        
        function [motifStore posStore scoreStore] = getFinalData(obj,bee)
            posStore = zeros(obj.fSize,1);
            scoreStore = zeros(obj.fSize,1);
            % score each final best motif and get its data
            for i=1:obj.fSize
                [motif back score pos] = field.getMaxPos(obj.paths{i},bee.LogOdds,bee.motifLen);
                motifStore{i} = motif;
                posStore(i) = pos;
                scoreStore(i) = score;
            end
        end
    end
    
    methods(Static) %STATIC and PRIVATE methods
        
        %[motif back] = getMaxPos(path,LogOdds,mLen)
        function [motif back score pos] = getMaxPos(path,LogOdds,mLen)
            score = zeros(1,length(path)-mLen);
            for i=1:length(path)-mLen
                temp = path(i:i+mLen-1); %pull the current location as a chain
                for j=1:length(temp)
                    score(i) = score(i) + LogOdds(temp(j),j); %find its score using the LO matrix
                end
            end
            [score pos] = max(score);

            motif = path(pos:pos+mLen-1);
            back = path; back(pos:pos+mLen-1) = [];
        end
        
        function [score] = getMaxFit(path,LogOdds,mLen)
            score = zeros(1,length(path)-mLen);
            for i=1:length(path)-mLen
                temp = path(i:i+mLen-1); %pull the current location as a chain
                for j=1:length(temp)
                    score(i) = score(i) + LogOdds(temp(j),j); %find its score using the LO matrix
                end
            end
            score = max(score);
        end
        
        %[sequences] = scanSequenceFastaFile(filepath)
        function [sequences] = scanSequenceFastaFile(filepath)
            fid=fopen(filepath); %open a file for reading
            nullParse = textscan(fid,'%s','delimiter','\n','whitespace',''); %dump input
            numlines = length(nullParse{1}); %calc lines
            frewind(fid); %rewind the reader ID
            sCount = 0;
            for i = 1:numlines
                temp = fgetl(fid); %get a line
                if (~isempty(temp)) %if line is NOT empty
                    if (strcmp(temp(1),'>')); sCount = sCount + 1; end %track new sequence
                end
            end
            sequences = cell(sCount,1); %create sequence storage
            sTracker = 0; %start from 0;
            frewind(fid);
            for i = 1:numlines
                temp = fgetl(fid); %get a line
                if (~isempty(temp)) %if line is NOT empty
                    sTest = sTracker; %set previous sequence
                    if (strcmp(temp(1),'>')) %is it a new sequence?
                        sTracker = sTracker+1; %yes we now will begin a new sequence next pass, skip this header line
                    end
                    if (sTest == sTracker) %if a new sequence has not been detected
                        sPart0 = sequences{sTracker}; %get previous piece of sequence
                        sPart1 = field.fastParse(temp); %get and parse new part of sequence
                        sequences{sTracker} = [sPart0 sPart1]; %combine sequences and store
                    end
                end
            end
            fclose(fid); %close the file
        end

        %[arraySeq] = fastParse(strSeq)
        function [arraySeq] = fastParse(strSeq)
            arraySeq = zeros(1,length(strSeq));
            for i = 1:length(strSeq)
                switch strSeq(i)
                    case 'A'; arraySeq(i) = 1;
                    case 'C'; arraySeq(i) = 2;
                    case 'G'; arraySeq(i) = 3;
                    case 'T'; arraySeq(i) = 4;
                end
            end
        end
    end
end


        
