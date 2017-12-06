Propulseur = {}
Propulseur.__index = Propulseur

function Propulseur.create(x, y, angle)
	local self = setmetatable({}, Propulseur)

	self.x = x
	self.y = y
	self.head = love.physics.newBody(world, x, y, "dynamic")
	self.headShape = love.physics.newRectangleShape(x, y, 70, 10, angle)
	self.fixture = love.physics.newFixture(self.head, self.headShape)

	self.pistonArm = love.physics.newBody(world, x, y, "dynamic")
	self.pistonArmShape = love.physics.newRectangleShape(x, y + 15, 15, 40, angle)
	self.armFixture = love.physics.newFixture(self.pistonArm, self.pistonArmShape)
	self.armFixture:setMask(1)
	
	self.headArmWeld = love.physics.newWeldJoint(self.head, self.pistonArm, self.pistonArm:getX() / 2, self.pistonArm:getY() / 2)
	
	self.base = love.physics.newBody(world, x, y, "static")
	self.baseShape = love.physics.newRectangleShape(x, y + 50, 30, 100, angle) 
	self.fixture = love.physics.newFixture(self.base, self.baseShape)
	self.fixture:setCategory(1)
	
	self.weld = love.physics.newPrismaticJoint(self.head, self.base, self.base:getX(), self.base:getY(), 0, 10, collideConnected)
	self.weld:setLimits(0, 30)
	
	return self
end

function Propulseur:draw()
	love.graphics.setColor(141, 139, 147)
	love.graphics.polygon("fill", self.head:getWorldPoints(self.headShape:getPoints()))
	love.graphics.polygon("fill", self.head:getWorldPoints(self.pistonArmShape:getPoints()))
	love.graphics.polygon("fill", self.base:getWorldPoints(self.baseShape:getPoints()))
end

function Propulseur:update(dt)
	if love.keyboard.isDown("down") then
		self.head:applyLinearImpulse(0, -200, self.base:getX(), self.base:getY())
	end
end