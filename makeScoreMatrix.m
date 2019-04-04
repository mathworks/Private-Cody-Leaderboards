function [scoreMatrix,t,playerNames] = makeScoreMatrix(scoreTable, players)
    %makeScoreMatrix Make a matrix with scores vs. author and time
    %   [scoreMatrix,t,playerNames] = makeScoreMatrix(scoreTable, players)
    
    t = unique(scoreTable.Time);
    p = unique(scoreTable.Id);
    
    % s is the score matrix
    % It has a row for every unique time stamp
    % and a column for every unique player
    s = nan(length(t),length(p));
    for i = 1:length(t)
        for j = 1:length(p)
            tnow = t(i);
            pnow = p(j);
            % Find all the scoreTable entries for this time and person
            ix = find((scoreTable.Time == tnow) & (scoreTable.Id == pnow));
            if ~isempty(ix)
                s(i,j) = scoreTable.Score(ix);
            else
                if i > 1
                    s(i,j) = s(i-1,j);
                end
            end
        end
    end
    % Re-order the score matrix according to who is in the lead at the end.
    % This makes the legend more easy to interpret.
    [~,ix] = sort(s(end,:),'descend');
    s = s(:,ix);
    p = p(ix);
    playerNames = strings(length(p),1);
    for i = 1:length(p)
        playerNames(i) = players.Name(players.ID==p(i));
    end
    
    scoreMatrix = s;
end
