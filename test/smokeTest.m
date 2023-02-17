% Smoke Test

%%

playerId = 734801;
[name, url, img, score, badgeCount] = getPlayerData(playerId);
assert(isequal(name,"Binbin Qi"))
assert(isequal(url,'https://www.mathworks.com/matlabcentral/cody/players/734801'))
assert(isequal(img,'https://www.mathworks.com/matlabcentral/profiles/734801.jpg'))

%%