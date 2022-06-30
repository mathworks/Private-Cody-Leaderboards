function players = addPlayerToFile(filename,idList,option)
    %addPlayerToFile Add one or more Cody players to a designated CSV file
    %   players = addPlayerToFile(filename,idList,option)
    
    arguments
        filename {mustBeText}
        idList {mustBeNumeric}
        option {mustBeTextScalar} = ""
    end

    names = strings(size(idList));
    for i = 1:length(idList)
        name = getPlayerData(idList(i));
        names(i) = name;
    end
    
    newPlayers = table(names,idList);
    newPlayers.Properties.VariableNames = {'Name','ID'};
    
    if exist(filename,'file') && option~="new"
        % Read the existing file unless the user has specifically requested
        % a new file
        oldPlayers = readtable(filename);
        players = [oldPlayers; newPlayers];
    else
        players = newPlayers;
    end
    
    % De-dupe any players that have been added twice.
    players = sortrows(players,'ID');
    [~,ia] = unique(players.ID);
    % Keep only unique rows
    players = players(ia,:);
    
    writetable(players,filename);
    
end