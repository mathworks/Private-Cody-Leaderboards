function [name, url, img, score, badgeCount] = getPlayerData(id)
%Use screen-scraping to return information about a Cody player given Player ID
%
%   [name, url, img, score, badgeCount] = getPlayerData(id)
%

% Cody player's page
url = sprintf('https://www.mathworks.com/matlabcentral/cody/players/%d',id);
html = webread(url);

% extract the image url
profTarget = 'matlabcentral/profiles/(.*?)\.(jpg|jpeg|png)';
tk = regexpi(html,profTarget,'tokens','once');
img = sprintf('https://www.mathworks.com/matlabcentral/profiles/%s.%s',tk{1},tk{2});


% extract the score, badge, and Cody name from a hyperlink title
% extracting this way is the easy way. However, it only works if the user has played Cody and has activity on their
% profile. Is it possible to have no activity but have a score? Not sure.
    target = '<a title="Score: (\d+), Badges: (\d+)".*?href="/matlabcentral/cody/players/.*?">(.*?)</a>';
    tk = regexpi(html,target,'tokens','once');
    if ~isempty(tk)
        name = tk{3};
        score = str2double(tk{1});
        badgeCount = str2double(tk{2});
    else
        % Use a more difficult way to extract the name, score, and badgeCount.
        % This can handle no activity on the Cody player's page.
        
        % This is the only pattern that occurs for the name
        namePattern = '<h1 class="add_margin_10">(.+?)</h1>';
        name = regexpi(html,namePattern,'tokens','once');
        name = name{1};
        
        % White space \s can break up this set of html tags so we try to guard against
        % this by using the \s*
        scorePattern = '>\s*(\d*)\s*</h\d>\s*Score\s*</div>';
        score = regexpi(html,scorePattern,'tokens','once');
        score = str2double(score{1});
        badgePattern = '>\s*(\d+)\s*</h\d>\s*Badges\s*</div>';
       badgeCount = regexpi(html,badgePattern,'tokens','once');
       badgeCount = str2double(badgeCount{1});
    end
end
