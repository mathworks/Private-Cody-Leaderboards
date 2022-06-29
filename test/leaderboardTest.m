classdef leaderboardTest < matlab.unittest.TestCase

    methods (TestClassSetup)
        % Shared setup for the entire test class
    end

    methods (TestMethodSetup)
        % Setup for each test
    end

    methods (Test)
        % Test methods

        function getPlayerDataTest(testCase)
            playerId = 734801;
            [name, url, img, score, badgeCount] = getPlayerData(playerId);
            testCase.verifyEqual(name,'Binbin Qi');
            testCase.verifyEqual(url,'https://www.mathworks.com/matlabcentral/cody/players/734801');
            testCase.verifyEqual(img,'https://www.mathworks.com/matlabcentral/profiles/734801.jpg');
        end

        function makeLeaderboardTest(testCase)
            dirname = tempdir;
            ldrBoardFilename = fullfile(dirname,"test_leaderboard.html");
            idList = [734801; 3529521; 5349647; 4345310; 3397427];
            makeLeaderboard(ldrBoardFilename,idList)
            disp(ldrBoardFilename)
        end

        function addPlayerToFileTest(testCase)
            dirname = tempdir;
            playerFilename = fullfile(dirname,"players.csv");
            idList = [734801; 3529521;];
            players = addPlayerToFile(playerFilename,idList,"new")
            disp(playerFilename)

            % Add four players, two of which have already been added
            idList = [734801; 3529521; 5349647; 4345310;];
            players = addPlayerToFile(playerFilename,idList,"new")
            testCase.verifyEqual(height(players),4)
        end        

    end

end