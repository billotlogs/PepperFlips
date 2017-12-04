Player = {speed = 2}
Player.__index = Player

function Player:new(sprite, world, startingX, startingY, scaleX, scaleY, bodyType, angle, life)
	local player = {}
	setmetatable(player, Player)
	player.base = GameObject:new(sprite, world, startingX, startingY, scaleX, scaleY, bodyType, angle)
	player.life = life
	return player
end

function Player:getLife()
	return self.life
end