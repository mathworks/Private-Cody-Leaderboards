function makeLeaderboard(filename, idList)
    % Given a list of Cody player IDs, make a private leaderboard
       
    % First make a table with all the player information in it.
    scoreList = zeros(size(idList));
    badgeCountList = zeros(size(idList));
    nameList = strings(size(idList));
    urlList = strings(size(idList));
    imgList = strings(size(idList));
    
    for i = 1:length(idList)
        id = idList(i);

        [name, url, img, score, badgeCount] = getPlayerData(id);
      
        nameList(i) = name;
        urlList(i) = url;
        imgList(i) = img;
        scoreList(i) = score;
        badgeCountList(i) = badgeCount;
    end
    
    players = table(nameList,idList,scoreList,badgeCountList,urlList,imgList);
    players.Properties.VariableNames = {'Name','ID','Score','Badges','URL','Avatar'};
    
    players = sortrows(players,'Score','descend');
    
    d = datetime;
    d.Format = 'd MMM yyyy h:mm a';
    
    % Now write out the HTML file.
    
    fid = fopen(filename,'w');
    fprintf(fid,'<html>\n');
    
    % Styles in the Head
    fprintf(fid,'<head>\n');
    fprintf(fid,'<style>\n');
    fprintf(fid,'html {\n');
    fprintf(fid,'    font-family: sans-serif;}\n');
    fprintf(fid,'table {\n');
    fprintf(fid,'    width: 800px;\n');
    fprintf(fid,'    border-collapse: collapse;\n');
    fprintf(fid,'    font-size: 24px;}\n');
    fprintf(fid,'th, td {\n');
    fprintf(fid,'    border-bottom: 1px solid #ddd;\n');
    fprintf(fid,'    padding: 8px;}\n');
    fprintf(fid,'th {\n');
    fprintf(fid,'    background-color: #2F7EB2;\n');
    fprintf(fid,'    color: white;\n');
    fprintf(fid,'    text-align: left;}\n');
    fprintf(fid,'</style>\n');
    fprintf(fid,'</head>\n');
        
    % Body
    fprintf(fid,'<body>\n');
    
    fprintf(fid,'<h1>Cody Private Leaderboard</h1>\n');
    
    fprintf(fid,'<p style="color:#A0A0A0">As of %s</p>',d);
    
    fprintf(fid,'<table>\n');
    
    fprintf(fid,'<tr>\n');
    fprintf(fid,'<th>Rank</th>');
    fprintf(fid,'<th></th>');
    fprintf(fid,'<th>Name</th>');
    fprintf(fid,'<th>Score</th>');
    fprintf(fid,'<th>Badges</th>');
    fprintf(fid,'</tr>\n');
    
    for i = 1:height(players)
        fprintf(fid,'<tr>\n');
        fprintf(fid,'<td>%d</td>',i);
        fprintf(fid,'<td><img src="%s" height="42" width="46"/></td>',players.Avatar(i));
        fprintf(fid,'<td><a href="%s">%s</a></td>',players.URL(i),players.Name(i));
        fprintf(fid,'<td>%d</td>',players.Score(i));
        fprintf(fid,'<td><a href="%s/badges">%d</a></td>',players.URL(i),players.Badges(i));
        fprintf(fid,'</tr>\n');
    end
    fprintf(fid,'</table>\n');
    fprintf(fid,'</body>\n');
    fprintf(fid,'</html>\n');
    fclose(fid);
    
end


