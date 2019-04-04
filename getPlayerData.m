function [name, url, img, score, badgeCount] = getPlayerData(id)
    %Use screen-scraping to return information about a Cody player given Player ID
    %   [name, url, img, score, badgeCount] = getPlayerData(id) 
    
    url = sprintf('https://www.mathworks.com/matlabcentral/cody/players/%d',id);
    html = webread(url);
    
    profUrl = sprintf('https://www.mathworks.com/matlabcentral/cody/players/%d',id);
    profHtml = webread(profUrl);
    profTarget = 'matlabcentral/profiles/(.*?)\.(jpg|jpeg|png)';
    tk = regexpi(profHtml,profTarget,'tokens','once');
    
    img = sprintf('https://www.mathworks.com/matlabcentral/profiles/%s.%s',tk{1},tk{2});
    
    target = '<a href="/matlabcentral/cody/players/.*?" title="Score: (\d+), Badges: (\d+)">(.*?)</a>';
    tk = regexp(html,target,'tokens','once');
    
    
    name = tk{3};
    score = str2double(tk{1});
    badgeCount = str2double(tk{2});
    
end