function [name, url, img, score, badgeCount] = getPlayerData(id)
%Use screen-scraping to return information about a Cody player given Player ID
%
%   [name, url, img, score, badgeCount] = getPlayerData(id)
%

% Cody player's page
url = sprintf('https://www.mathworks.com/matlabcentral/cody/players/%d',id);
html = webread(url);

% extract the image url
profTarget = 'matlabcentral/profiles/.*?\.(jpg|jpeg|png)';
tk = regexpi(html,profTarget,'tokens','once');
img = sprintf('https://www.mathworks.com/matlabcentral/profiles/%d.%s',id,tk{1});

% extract the score, badge, and Cody name from a hyperlink title
target = '<a title="Score: (\d+), Badges: (\d+)".*?href="/matlabcentral/cody/players/.*?">(.*?)</a>';
tk = regexp(html,target,'tokens','once');
name = tk{3};
score = str2double(tk{1});
badgeCount = str2double(tk{2});

end
