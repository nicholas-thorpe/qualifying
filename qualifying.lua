local p = {}

local getArgs = require('Module:Arguments').getArgs

-- Import code for player data (opponents)
local OpponentLibraries = require('Module:OpponentLibraries')
local Opponent = OpponentLibraries.Opponent
local OpponentDisplay = OpponentLibraries.OpponentDisplay

-- Beginning of the table
--
-- Parameters:
-- title = title of the table, default "Qualifying"
-- type = type of qualifier, defualt "solo"
function p.QualifierStart()
	
end

-- Players who qualified without submitting a score
--
-- Parameters:
-- player = the tag of the player
-- flag = the flag of the player
function p.AutoQualifier()
	
end

-- Players who qualified by submitting one high score
--
-- Parameters:
-- player = the tag of the player
-- flag = the flag of the player
-- score = the highest score the player got during qualifying
-- forfeit = if the player dropped out after qualifying but before bracket
function p.SoloQualifier()
	
end

-- Players who qualified by submitting multiple high scores averaged together
--
-- Parameters:
-- player = the tag of the player
-- flag = the flag of the player
-- scores = how many high scores were submitted
-- scoreX = each of the highest scores the player got during qualifying
-- forfeit = if the player dropped out after qualifying but before bracket
function p.AverageQualifier()
	
end

-- Players who qualified by submitting multiple games targetting a particular score
--
-- Parameters:
-- player = the tag of the player
-- flag = the flag of the player
-- score = the number of times the player scored the requisite target
-- kicker = the highest score the player got that didn't meet the requisite target
-- forfeit = if the player dropped out after qualifying but before bracket
function p.TargetQualifier()
	
end

-- End of the table
function p.QualifierEnd()
	local output = '</div>'
	
	return output
end

return p