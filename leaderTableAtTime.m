function currentTable = leaderTableAtTime(playerTable, scoreTable, t1)
    %leaderTableAtTime Return the list of leaders at a specified time
    
    if nargin < 3
        t1 = datetime("now");
    end
    
    keep = scoreTable.Time < t1;
    scoreTable1 = scoreTable(keep,:);
    [~,ia] = unique(scoreTable1.Id,'last');
    scoreTable1 = scoreTable1(ia,:);
    currentTable = timetable2table(scoreTable1);
    currentTable.Time = [];
    currentTable = sortrows(currentTable,'Score','descend');
    names = strings(height(currentTable),1);
    for i = 1:height(currentTable)
        id = currentTable.Id(i);
        names(i) = playerTable.Name(playerTable.ID==id);
    end
    
    currentTable(:,end+1) = table(names);
    currentTable.Properties.VariableNames{4} = 'Name';
    
    currentTable = currentTable(:,[4 1 2 3]);

end
