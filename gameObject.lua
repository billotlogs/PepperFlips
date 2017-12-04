GameObject = {}
GameObject.__index = GameObject

function GameObject:new(sprite, world, startingX, startingY, scaleX, scaleY, bodyType, angle)
	local gameObject = {}
	setmetatable(gameObject, GameObject)
	gameObject.scaleX = scaleX
	gameObject.scaleY = scaleY
	gameObject.img = love.graphics.newImage(sprite)	
	gameObject.body = love.physics.newBody(world, startingX, startingY, bodyType)
	gameObject.shape = love.physics.newRectangleShape(0, 0, gameObject.img:getWidth() * scaleX, gameObject.img:getHeight() * scaleY)
	gameObject.fixture = love.physics.newFixture(gameObject.body, gameObject.shape)
	return gameObject
end

function GameObject:Draw()
	love.graphics.draw(
	self.img, 
	self.body:getX(),
	self.body:getY(),
	self.body:getAngle(),
	self.scaleX,
	self.scaleY,
	self.img:getWidth()/2, 
	self.img:getHeight()/2) 
end

function GameObject:getBody()
	return self.body
end

function GameObject:getSprite()
	return self.img
end

function GameObject:getShape()
	return self.shape
end

function GameObject:getFixture()
	return self.fixture
end