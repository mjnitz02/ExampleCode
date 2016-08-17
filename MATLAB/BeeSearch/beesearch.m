function varargout = beesearch(varargin)
    gui_Singleton = 1;
    gui_State = struct('gui_Name',       mfilename, ...
                       'gui_Singleton',  gui_Singleton, ...
                       'gui_OpeningFcn', @beesearch_OpeningFcn, ...
                       'gui_OutputFcn',  @beesearch_OutputFcn, ...
                       'gui_LayoutFcn',  [] , ...
                       'gui_Callback',   []);
    if nargin && ischar(varargin{1})
        gui_State.gui_Callback = str2func(varargin{1});
    end

    if nargout
        [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
    else
        gui_mainfcn(gui_State, varargin{:});
    end

function beesearch_OpeningFcn(hObject, eventdata, handles, varargin)
    handles.output = hObject;
    handles.filepath = '';
    
    handles.beeImage = imread('bee.png');
    imshow(handles.beeImage);
    
    warning('off','MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame');
    jframe=get(gcf,'javaframe');
    jIcon=javax.swing.ImageIcon('bee.png');
    jframe.setFigureIcon(jIcon);
    
    guidata(hObject, handles);
function varargout = beesearch_OutputFcn(hObject, eventdata, handles) 
    varargout{1} = handles.output;


% Browse button
function pushbutton1_Callback(hObject, eventdata, handles)
    [filename, pathname] = uigetfile('*.*','Browse for your sequences file');
    if (filename ~= 0)
        set(handles.edit2,'String',strcat(pathname,filename));
    end
    
% Analyze button
function pushbutton2_Callback(hObject, eventdata, handles)

    clc
    filepath = get(handles.edit2,'String');

    NoOfSearcher = str2double(get(handles.edit3,'String'));
    NoOfForager = str2double(get(handles.edit4,'String'));
    NoOfDrone = str2double(get(handles.edit5,'String'));
    NoOfMutDrone = str2double(get(handles.edit6,'String'));
    NoOfWorkers = str2double(get(handles.edit7,'String'));

    mLength = str2double(get(handles.edit15,'String'));
    stabilityControl = str2double(get(handles.edit8,'String'));
    stabilityCount = str2double(get(handles.edit9,'String'));
    emergencyKill = str2double(get(handles.edit13,'String'));

%     fprintf('BeeSearch :: Initializing the Hive...\n');
    status = cellstr(get(handles.edit14,'String'));
    status{length(status)+1} = 'BeeSearch :: Initializing the Hive...';
    set(handles.edit14,'String',char(status));
%     setup the hive (a hive consists of 5 colonies)
    myField = field(filepath);
    myHive = cell(5,1);
    myHive{1}=colony(35,1,mLength,myField.fSize);
    myHive{2}=colony(15,2,mLength,5,myField.fSize);
    myHive{3}=colony(15,3,mLength,5);
    myHive{4}=colony(15,4,mLength,5);
    myHive{5}=colony(NoOfWorkers,5,mLength,5);

%     fprintf('BeeSearch :: Beginning initial field search...\n');
    status = cellstr(get(handles.edit14,'String'));
    status{length(status)+1} = 'BeeSearch :: Beginning initial field search...';
    set(handles.edit14,'String',char(status));
    %Seed the colonies (have the seekers with initial data go find some motifs)
    [myHive{1}] = colonyMembersSearch(myHive{1},myField);
    [myHive{2}] = colonyMembersSearch(myHive{2},myField);
    [myHive{1}] = colonyMembersUpdate(myHive{1},myField);
    [myHive{2}] = colonyMembersUpdate(myHive{2},myField);

    %now create some initial workers...
    [scoreMatrix] = powerRank([colonyMembersRank(myHive{1});colonyMembersRank(myHive{2})]);
    for i = 1:NoOfWorkers
        myHive{5}.members{i}.sLogOdds = myHive{scoreMatrix(i,3)}.members{scoreMatrix(i,2)}.LogOdds;
    end
    [myHive{5}] = colonyMembersUpdate(myHive{5},myField);

    %----------------------------------------------------

    %enter cycling
    tic
%     fprintf('BeeSearch :: Parameters locked... Hive beginning search pattern...\n');
%     status = cellstr(get(handles.edit14,'String'));
    status = 'BeeSearch :: Parameters locked... Hive beginning search pattern...';
    set(handles.edit14,'String',char(status));
    imshow(colorize(handles.beeImage,1))
    pause(0.1)
    sysActive = 1;
    stabilizer = 0;
    prevResults = zeros(stabilityCount,1);
    while(sysActive)
        %adjust the drones and workers to prepare for searching
        [myHive{3}] = adjustColonyDrones(myHive{3},myHive{5},myField);
        [myHive{4}] = adjustColonyMutantDrones(myHive{4},myHive{5});
        [myHive{5}] = adjustColonyWorkers(myHive{5});

        %if a bee needs to search to then have it go search
        [myHive{1}] = colonyMembersSearch(myHive{1},myField); %scouts search
        [myHive{2}] = colonyMembersSearch(myHive{2},myField); %foragers search
        [myHive{3}] = colonyMembersSearch(myHive{3},myField); %drones search

        for i = 1:5
            [myHive{i}] = colonyMembersUpdate(myHive{i},myField); %update ALL colonies in the field
        end

        %score all of the results
        [scoreMatrix] = powerRank([colonyMembersRank(myHive{1});colonyMembersRank(myHive{2});colonyMembersRank(myHive{3});colonyMembersRank(myHive{4});colonyMembersRank(myHive{5})]);
        %select the field positions of the new worker bees...
        for i = 1:NoOfWorkers
            myHive{5}.members{i}.sLogOdds = myHive{scoreMatrix(i,3)}.members{scoreMatrix(i,2)}.LogOdds;
        end
        [myHive{5}] = colonyMembersUpdate(myHive{5},myField); %refresh the workers

        if(sum(scoreMatrix(1:stabilityCount,1)==prevResults)==stabilityCount)
            stabilizer = stabilizer + 1;
            if ((stabilizer/stabilityControl) > 0.9)
                imshow(colorize(handles.beeImage,5)); pause(0.1);
            elseif ((stabilizer/stabilityControl) > 0.5)
                imshow(colorize(handles.beeImage,3)); pause(0.1);
            elseif ((stabilizer/stabilityControl) > 0.25)
                imshow(colorize(handles.beeImage,2)); pause(0.1);
            else
                imshow(colorize(handles.beeImage,1)); pause(0.1);
            end
        else
            stabilizer = 0;
            imshow(colorize(handles.beeImage,1)); pause(0.1);
        end

        if (stabilizer>=stabilityControl)
            sysActive = 0;
        end

        if(length(unique(scoreMatrix(1:stabilityCount,1))) < emergencyKill)
            %occasionally the colony will cross-feed on one another and all
            %populations will become converged on a single target.  This should
            %not occur and will undermine the capability of the algorithm.  If
            %this flaw occurs the algorithm takes immediate action to remove
            %the stability flaw.
            status = cellstr(get(handles.edit14,'String'));
            status{length(status)+1} = 'WARNING :: Intelligence flaw detected... the hive has destabilized...';
            status{length(status)+1} = 'WARNING :: Initiating worker bee kill procedure...';
            set(handles.edit14,'String',char(status));
            pause(0.1)
%             fprintf('WARNING :: Intelligence flaw detected... the hive has destabilized...\n');
%             fprintf('WARNING :: Initiating worker bee kill procedure...\n');
            %force searchers to scatter in field
            [myHive{1}] = colonyMembersSearch(myHive{1},myField);
            [myHive{2}] = colonyMembersSearch(myHive{2},myField);
            [myHive{1}] = colonyMembersUpdate(myHive{1},myField);
            [myHive{2}] = colonyMembersUpdate(myHive{2},myField);
            [scoreMatrix] = powerRank([colonyMembersRank(myHive{1});colonyMembersRank(myHive{2})]);
            for i = 1:NoOfWorkers %reseed all workers
                myHive{5}.members{i}.sLogOdds = myHive{scoreMatrix(i,3)}.members{scoreMatrix(i,2)}.LogOdds;
            end
            [myHive{5}] = colonyMembersUpdate(myHive{5},myField);
            stabilizer = 0;
        end

        scoreMatrix(1:stabilityCount,1)
        stabilizer

        prevResults = scoreMatrix(1:stabilityCount,1);
    end

    status = cellstr(get(handles.edit14,'String'));
    status{length(status)+1} = 'BeeSearch :: Hive convergence detected...';
    set(handles.edit14,'String',char(status));
    pause(0.1)
%     fprintf('BeeSearch :: Hive convergence detected...\n');
    scoreMatrix(1,1)
    toc
    %repeat cycling
    status = cellstr(get(handles.edit14,'String'));
    status{length(status)+1} = 'BeeSearch :: Saving Motif 1...'; set(handles.edit14,'String',char(status)); pause(0.1)
    finalBee = myHive{5}.members{1}; [motifStore posStore scoreStore] = getFinalData(myField,finalBee); pause(1);
    saveSequenceFile(finalBee.LogOdds,finalBee.RelEntropy,motifStore,myField.paths,posStore,scoreStore);
    
    status{length(status)+1} = 'BeeSearch :: Saving Motif 2...'; set(handles.edit14,'String',char(status)); pause(0.1)
    finalBee = myHive{5}.members{2}; [motifStore posStore scoreStore] = getFinalData(myField,finalBee); pause(1);
    saveSequenceFile(finalBee.LogOdds,finalBee.RelEntropy,motifStore,myField.paths,posStore,scoreStore);
    
    status{length(status)+1} = 'BeeSearch :: Saving Motif 3...'; set(handles.edit14,'String',char(status)); pause(0.1)
    finalBee = myHive{5}.members{3}; [motifStore posStore scoreStore] = getFinalData(myField,finalBee); pause(1);
    saveSequenceFile(finalBee.LogOdds,finalBee.RelEntropy,motifStore,myField.paths,posStore,scoreStore);



%unused functions
function edit2_Callback(hObject, eventdata, handles)
function edit2_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
function edit3_Callback(hObject, eventdata, handles)
function edit3_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
function edit4_Callback(hObject, eventdata, handles)
function edit4_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
function edit5_Callback(hObject, eventdata, handles)
function edit5_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
function edit6_Callback(hObject, eventdata, handles)
function edit6_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit7_Callback(hObject, eventdata, handles)
function edit7_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit8_Callback(hObject, eventdata, handles)
function edit8_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit9_Callback(hObject, eventdata, handles)
function edit9_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit13_Callback(hObject, eventdata, handles)
function edit13_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit14_Callback(hObject, eventdata, handles)
function edit14_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit15_Callback(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit15 as text
%        str2double(get(hObject,'String')) returns contents of edit15 as a double


% --- Executes during object creation, after setting all properties.
function edit15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
