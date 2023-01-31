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
-- type = type of qualifier, default "solo"
function p.QualifierStart()
	args = getArgs(frame)
	
	args['title'] = args['title'] or 'Qualifying'
	args['type'] = args['type'] or 'solo'
	
	local output = '<div class="qualifier-wrapper"><table><tr><th>Seed</th><th>Player></th>'
	
	if args['type'] == 'solo' then
		output = output .. '<th>Score</th></tr>'
	elseif args['type'] == 'average' then
		-- TODO: add a param that allows this to scale up to an arbitrary number of scores
		output = output .. '<th>Average</th><th>Score 1</th><th>Score 2</th></tr>'
	elseif args['type'] == 'target' then
		output = output .. '<th>Maxouts</th><th>Kicker</th></tr>'
	end
	
	return output
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
function p.SoloQualifier(frame)
	args = getArgs(frame)
	
	args['forfeit'] = args['forfeit'] or 'false'
	
	-- TODO: Figure out how to handle seeds in an elegant manner
	-- Will go for all four qualifier functions but focus is on Solo for now
	local output = '<tr><td>' .. '1' .. '</td><td'
	
	-- If the player is listed as forfeiting, strike out their name
	if args['forfeit'] == true
		output = output .. ' style:"text-decoration:line-through;"'
	end
	
	output = output .. '>' .. args['player']
	
	if args['flag']
		output = output .. ' {{flag|' .. args['flag'] .. '}}'
	end
	
	output = output .. '</td><td>{{formatnum:' .. args['score'] .. '}}</td></tr>'
	
	return output
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
	local output = '</table></div>'
	
	return output
end

return p