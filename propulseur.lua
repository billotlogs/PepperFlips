Propulseur = {}
Propulseur.__index = Propulseur

function Propulseur.create(x, y)
	local self = setmetatable({}, Propulseur)

	self.x = x
	self.y = y
	self.body = love.physics.newBody(world, x, y, "dynamic")
	self.shape = love.physics.newRectangleShape(x, y, 70, 10)
	self.fixture = love.physics.newFixture(self.body, self.shape)
	
	self.base = love.physics.newBody(world, x, y, "static")
	self.baseShape = love.physics.newRectangleShape(x, y + 50, 30, 100) 
	self.fixture = love.physics.newFixture(self.base, self.baseShape)
	
	self.weld = love.physics.newPrismaticJoint(self.body, self.base, self.base:getX(), self.base:getY(), 0, 10, collideConnected)
	self.weld:setLimits(0, 30)
	
	return self
end

function Propulseur:draw()
	love.graphics.setColor(141, 139, 147)
	love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))
	love.graphics.polygon("fill", self.base:getWorldPoints(self.baseShape:getPoints()))
end

function Propulseur:update(dt)
	if love.keyboard.isDown("down") then
		self.body:applyLinearImpulse(0, -300, self.base:getX(), self.base:getY())
	end
end