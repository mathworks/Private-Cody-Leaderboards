function [name, url, img, score, badgeCount] = getPlayerData(id)
    %Use screen-scraping to return information about a Cody player given Player ID
    %   [name, url, img, score, badgeCount] = getPlayerData(id) 
    
    url = sprintf('https://www.mathworks.com/matlabcentral/cody/players/%d',id);
    html = webread(url);
    
    target = 'matlabcentral/profiles/(.*?)\.(jpg|jpeg|png)';
    tk = regexpi(html,target,'tokens','once');
    
    img = sprintf('https://www.mathworks.com/matlabcentral/profiles/%s.%s',tk{1},tk{2});
    
    target = '<a title="Score: (\d+), Badges: (\d+).*?>(.*?)</a>';
    tk = regexp(html,target,'tokens','once');
        
    if length(tk) > 0
        % If you find the target pattern, extract the name, score and badge
        % count
        name = tk{3};
        score = str2double(tk{1});
        badgeCount = str2double(tk{2});
    else
        % If the target pattern doesn't appear, the user has not actually
        % played Cody yet. Score and badge count are set to zero.
        target = '<title>(.*?) - MATLAB Cody';
        tk = regexp(html,target,'tokens','once');
        name = tk{1};
        score = 0;
        badgeCount = 0;
    end
    
end