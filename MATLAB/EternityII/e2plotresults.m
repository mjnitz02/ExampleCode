function e2plotresults()
    clc
    
    
    figure
    hold on
    
%     medfilt2(d2,[1 3]);
    
    lineTypes = {'-r';'--b';':m';'-.g';'-b';'--m';':g';'-.r'};
    contVar = 1;
    counter = 1;
    while (contVar)
        [filename, pathname] = uigetfile({'*.mat','EII Saved Files (*.mat)';'*.*','All Files (*.*)'},'Select Files','MultiSelect', 'on');
        if (~iscell(filename))
            if (filename == 0)
                contVar = 0; %#ok<NASGU>
                break;
            end
        end
        
        if (iscell(filename))
            analysis = zeros(2,length(filename));
            for i=1:length(filename)
                load(strcat(pathname,filename{i}))
                analysis(1,i) = max(costArray);
                analysis(2,i) = length(costArray);
                plot(costArray,lineTypes{counter},'LineWidth',3);
            end
            
            fprintf('Grouping %d\n',counter);
            fprintf('Score: Max - %d, Min - %d, Avg - %0.1f\n',max(analysis(1,:)),min(analysis(1,:)),mean(analysis(1,:)));
            fprintf('Iterations: Max - %d, Min - %d, Avg - %0.1f\n',max(analysis(2,:)),min(analysis(2,:)),mean(analysis(2,:)));
            fprintf('\n');
            
        else
            load(strcat(pathname,filename));
            plot(costArray,lineTypes{counter},'LineWidth',3);
        end

        counter = counter+1;
    end
    
    set(gcf,'Color','white');
    set(gca,'Box','on','LineWidth',4);
    set(gca,'FontSize',26)
    xlabel('Iterations')
    ylabel('Board Score')
end