local p = {}

local getArgs = require('Module:Arguments').getArgs

-- Import code for player data (opponents)
-- Currently unused and may be removed
local OpponentLibraries = require('Module:OpponentLibraries')
local Opponent = OpponentLibraries.Opponent
local OpponentDisplay = OpponentLibraries.OpponentDisplay

--[[
	Beginning of the table
	
	Parameters:
	title = title of the table, default "Qualifying"
	type = type of qualifier, default "solo"
	scores = optional, how many high scores are to be submitted for AverageQualifier
	target = optional, the requisite target score for TargetQualifier
]]
function p.QualifierStart()
	args = getArgs(frame)
	
	-- Default arg values
	args['title'] = args['title'] or 'Qualifying'
	args['type'] = args['type'] or 'solo'
	
	-- Default to solo if given an invalid table type
	if args['type'] != 'solo' and args['type'] != 'average' and args['type'] != 'target' then
		args['type'] = 'solo'
	end
	
	local output = '<div class="qualifier-wrapper"><table><caption>' .. args['title'] .. '</caption>'
	output = output .. '<tr><th>Seed</th><th>Player></th>'
	
	if args['type'] == 'solo' then
		output = output .. '<th>Score</th></tr>'
	elseif args['type'] == 'average' then
		output = output .. '<th>Average</th>'
		
		for i = 0, i < scores, i++ do
			output = output .. '<th>Score ' .. i .. '</th>'
		end
	elseif args['type'] == 'target' then
		output = output .. '<th>' .. args['target'] .. '</th><th>Kicker</th></tr>'
	end
	
	return output
end

--[[
	Players who qualified without submitting a score
	
	Parameters:
	player = the tag of the player
	flag = the flag of the player
]]
function p.AutoQualifier()
	args = getArgs(frame)
	
	local output = '<tr><td>' .. '1' .. '</td><td>' .. args['player']
	
	if args['flag'] then
		output = output .. ' {{flag|' .. args['flag'] .. '}}'
	end
	
	-- TODO: Add colspan to make this display correctly in Average and Target tables
	output = output .. '</td><td>AUTO</td></tr>'
	
	return output
end

--[[
	Players who qualified by submitting one high score
	
	Parameters:
	player = the tag of the player
	flag = the flag of the player
	score = the highest score the player got during qualifying
	forfeit = optional, if the player dropped out after qualifying but before bracket
]]
function p.SoloQualifier(frame)
	args = getArgs(frame)
	
	-- Default arg values
	args['score'] = args['score'] or 0
	args['forfeit'] = args['forfeit'] or 'false'
	
	-- TODO: Figure out how to handle seeds in an elegant manner
	-- Will go for all four qualifier functions but focus is on Solo for now
	local output = '<tr><td>' .. '1' .. '</td><td'
	
	-- If the player is listed as forfeiting, strike out their name
	if args['forfeit'] == true then
		output = output .. ' style:"text-decoration:line-through;"'
	end
	
	-- TODO: Decide whether to use the opponent template or something else for player tag
	output = output .. '>' .. args['player']
	
	if args['flag'] then
		output = output .. ' {{flag|' .. args['flag'] .. '}}'
	end
	
	output = output .. '</td><td>{{formatnum:' .. args['score'] .. '}}</td></tr>'
	
	return output
end

--[[
	Players who qualified by submitting multiple high scores averaged together
	
	Parameters:
	player = the tag of the player
	flag = the flag of the player
	scores = how many high scores were submitted
	scoreX = each of the highest scores the player got during qualifying
	forfeit = optional, if the player dropped out after qualifying but before bracket
]]
function p.AverageQualifier()
	args = getArgs(frame)
	
	-- Default arg values
	args['scores'] = args['scores'] or 1
	args['score1'] = args['score1'] or 0
	args['forfeit'] = args['forfeit'] or 'false'
	
	local output = '<tr><td>' .. '1' .. '</td><td'
	
	-- If the player is listed as forfeiting, strike out their name
	if args['forfeit'] == true then
		output = output .. ' style:"text-decoration:line-through;"'
	end
	
	output = output .. '>' .. args['player']
	
	if args['flag'] then
		output = output .. ' {{flag|' .. args['flag'] .. '}}'
	end
	
	output = output .. '</td>'
	
	local average = 0
	
	if args['scores'] == 0 then
		args['scores'] = 1
	end
	
	for i = 0, i < args['scores'], i++ do
		-- TODO: Figure out whether this concatenation trick thing even works
		average = average + args['score' .. i]
	end
	
	average = average / args['scores']
	
	output = output .. '<td>{{formatnum:' .. average .. '}}</td>'
	
	for i = 1, args['scores'], i++ do
		output = output .. '<td>{{formatnum:' .. args['score' .. i] .. '}}</td>'
	end
	
	output = output .. '</tr>'
	
	return output
end

--[[
	Players who qualified by submitting multiple games targetting a particular score
	
	Parameters:
	player = the tag of the player
	flag = the flag of the player
	score = the number of times the player scored the requisite target
	kicker = the highest score the player got that didn't meet the requisite target
	forfeit = optional, if the player dropped out after qualifying but before bracket
]]
function p.TargetQualifier()
	args = getArgs(frame)
	
	-- Default arg values
	args['score'] = args['score'] or 0
	args['kicker'] = args['kicker'] or 0
	args['forfeit'] = args['forfeit'] or 'false'
	
	local output = '<tr><td>' .. '1' .. '</td><td'
	
	-- If the player is listed as forfeiting, strike out their name
	if args['forfeit'] == true then
		output = output .. ' style:"text-decoration:line-through;"'
	end
	
	output = output .. '>' .. args['player']
	
	if args['flag'] then
		output = output .. ' {{flag|' .. args['flag'] .. '}}'
	end
	
	output = output .. '</td><td>{{formatnum:' .. args['score'] .. '}}</td>'
	output = output .. '<td>{{formatnum:' .. args['kicker'] .. '}}</td></tr>'
	
	return output
end

--[[
	End of the table
]]
function p.QualifierEnd()
	local output = '</table></div>'
	
	return output
end

return p