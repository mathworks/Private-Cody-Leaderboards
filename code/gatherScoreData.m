function scoreTable = gatherScoreData(filename, idList, option)
    % Get the scores for all the players listed in the idList
    %    scoreTable = gatherScoreData(filename, idList, option)

    arguments
        filename {mustBeText}
        idList {mustBeNumeric}
        option {mustBeTextScalar} = ""
    end
    
    if isequal(option,"new") || ~exist(filename,'file') 
        scoreTable = [];
    else
        scoreTable = readtimetable(filename);
    end
    
    % First make a table with all the player information in it.
    scoreList = zeros(size(idList));
    badgeCountList = zeros(size(idList));
    
    for i = 1:length(idList)
        id = idList(i);
        
        [~,~,~,score,badgeCount] = getPlayerData(id);
        
        scoreList(i) = score;
        badgeCountList(i) = badgeCount;
    end
    
    Time = NaT(size(idList));
    Time(1:end) = datetime('now');
    
    newTable = timetable(Time,idList,scoreList,badgeCountList);
    newTable.Properties.VariableNames = {'Id','Score','Badges'};
    
    if isempty(scoreTable)
        scoreTable = newTable;
    else
        scoreTable = [scoreTable; newTable];
    end
    
    % De-dupe the score table
    st = sortrows(scoreTable);
    keep = true(height(st),1);
    for i = 1:height(st)
        if keep(i)
            % Find all the entries with the same author and score
            ix = find((st.Id == st.Id(i)) & (st.Score == st.Score(i)));
            % Keep the first and last occurrence of these
            keep(ix) = false;
            keep(ix([1 end])) = true;
        end
    end
    scoreTable = st(keep,:);    
    
    writetimetable(scoreTable,filename)
    
end
