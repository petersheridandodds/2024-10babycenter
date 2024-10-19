more off;

%% shows what happens moving away from one year 

filename1s = {
    '../data/pre-birth.csv',
             };
    
filename2s = {
    '../data/post-birth.csv',
    };
    
corpusname1s = {
    'BabyCenter: Pre-birth',
               };

corpusname2s = {
    'BabyCenter: Post-birth',
              };

for loop_i = 1:length(filename1s)
    filename1 = filename1s{loop_i};
    filename2 = filename2s{loop_i};

    %%    opts = detectImportOptions(filename1,
    data1 = importdata(filename1,',',1);
    data2 = importdata(filename2,',',1);
    data1.data = data1.data(:,1);
    data2.data = data2.data(:,1);
    data1.textdata = data1.textdata(2:end,1);
    data2.textdata = data2.textdata(2:end,1);

    j=1;
    elements(j).types = data1(1).textdata;
    elements(j).counts = data1(1).data;
    elements(j).probs = data1(1).data/sum(data1(1).data);
    elements(j).ranks = tiedrank(-data1(1).data);
    elements(j).totalunique = length(data1(1).data);

    j=2;
    elements(j).types = data2(1).textdata;
    elements(j).counts = data2(1).data;
    elements(j).probs = data2(1).data/sum(data2(1).data);
    elements(j).ranks = tiedrank(-data2(1).data);
    elements(j).totalunique = length(data2(1).data);
    
    mixedelements = combine_distributions(elements(1),elements(2));

    settings.imageformat.open = 'no';
    settings.maxrank_log10 = 5.5;
    settings.maxcount_log10 = 4;

    settings.more_string = {'more','frequent'};
    settings.less_string = {'less','frequent'};
    
    settings.typename = 'word';
    settings.units = 'counts';

    settings.topNshuffling = 25;
    settings.topNshift = 40;
    settings.topNdeltasum = 'all';

    settings.xoffset = +0.05;

    settings.max_plot_string_length = 20;
    settings.max_shift_string_length = 25;


    fprintf(1,'constructing figure ...\n');

    settings.system1_name = corpusname1s{loop_i};
    settings.system2_name = corpusname2s{loop_i};

    %%%%%%%%%%%%
    %% rtd
    %%%%%%%%%%%%
    
    alphavals = [(0:18)/12, 2, 3, 5, 10, Inf];

    settings.axislabel_top1 = 'Word use rank $r$';
    settings.axislabel_top2 = 'Word use rank $r$';

    settings.plotkind = 'rank';
    settings.instrument = 'rank divergence';
    
    for loop_j = 1:length(alphavals)
        settings.alpha = alphavals(loop_j);
        %% settings.alpha = 1/3;
        %% settings.alpha = 1/2;
        %% settings.alpha = 5/6;

        tag = sprintf('babycenter_pre_post_birth001-rtd-%02d-alpha%02d',loop_i,loop_j);

        figallotaxonometer9000(mixedelements,tag,settings);
    
    end    

    %%%%%%%%%%%%
    %% ptd
    %%%%%%%%%%%%
    
    alphavals = [(0:18)/12, 2, 3, 5, 10, Inf];

    settings.axislabel_top1 = 'Normalized frequency $p$';
    settings.axislabel_top2 = 'Normalized frequency $p$';

    settings.plotkind = 'probability';
    settings.instrument = 'probability divergence';
    
    for loop_j = 1:0 %% length(alphavals)
        settings.alpha = alphavals(loop_j);
        %% settings.alpha = 1/3;
        %% settings.alpha = 1/2;
        %% settings.alpha = 5/6;

        tag = sprintf('babycenter_pre_post_birth001-ptd-%02d-alpha%02d',loop_i,loop_j);

        figallotaxonometer9000(mixedelements,tag,settings);
    
    end    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end


more on;

%% create flipbooks

%% !combinepdfs figallotaxonometer9000/figallotaxonometer9000-story_corps_memory001-rtd-01-alpha??_noname.pdf flipbooks/figallotaxonometer9000-story_corps_memory001-rtd-01-flipbook.pdf
