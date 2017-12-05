require "gameObject"
require "propulseur"

function love.load()
	love.window.setMode(1200, 768)
	pepperFlips = 0
	angle = 0
	objects = {}
	boundaries = {}

	love.physics.setMeter(64)
	background = love.graphics.newImage("Sprites/bg.png")
	world = love.physics.newWorld(0, 9.81*64, true)
	
	ground = {}
	ground.body = love.physics.newBody(world, 1200/2, 768-50/2)
	ground.shape = love.physics.newRectangleShape(0, 0, 1200, 50)
	ground.fixture = love.physics.newFixture(ground.body, ground.shape)
	
	boundaries.left = {}
	boundaries.left.body = love.physics.newBody(world, 0, 384)
	boundaries.left.shape = love.physics.newRectangleShape(0, 0, 0, 768)
	boundaries.left.fixture = love.physics.newFixture(boundaries.left.body, boundaries.left.shape)
	
	boundaries.right = {}
	boundaries.right.body = love.physics.newBody(world, 1200, 384)
	boundaries.right.shape = love.physics.newRectangleShape(0, 0, 0, 768)
	boundaries.right.fixture = love.physics.newFixture(boundaries.right.body, boundaries.right.shape)
	
	boundaries.top = {}
	boundaries.top.body = love.physics.newBody(world, 600, 0)
	boundaries.top.shape = love.physics.newRectangleShape(0, 0, 1200, 0)
	boundaries.top.fixture = love.physics.newFixture(boundaries.top.body, boundaries.top.shape)

	player = GameObject:new("Sprites/DrPepper.png", world, 1200/2, 700, 1, 1, "dynamic", 0)
	propulseur = Propulseur.create(50, 350)
	
	objects.block = {}
	objects.block.body = love.physics.newBody(world, 200, 50, "dynamic", 5)
	objects.block.shape = love.physics.newRectangleShape(0, 0, 50, 200)
	objects.block.fixture = love.physics.newFixture(objects.block.body, objects.block.shape)
end

function love.update(dt)
	world:update(dt)
	angle = (player:getBody():getAngle() * 180) / math.pi;
	
	if love.keyboard.isDown("left") then
		player:getBody():applyForce(-400, 0)
	elseif love.keyboard.isDown("right") then
		player:getBody():applyForce(400, 0)
	end
	
	if love.keyboard.isDown("space") then
		player:getBody():applyForce(0, -800)
	end

	if player:getBody():getLinearVelocity() == 0 then
		isJumping = false
	end
	
	if love.keyboard.isDown("ctrl") then
		player:getBody():applyForce(0, -800)
	end

	if angle >= 360 or angle <= -360 then
		love.audio.play(love.audio.newSource("Sounds/explosion.wav", "stream"))
		pepperFlips = pepperFlips + 1
		player:getBody():setAngle(0)
	end
	
	propulseur:update()
end

function love.draw()
	love.graphics.reset()
	love.graphics.draw(background, 0, 0, 0, 1200/background:getWidth(), 768/background:getHeight())
	
	love.graphics.setColor(90, 145, 51)
	love.graphics.polygon(
		"fill",
		ground.body:getWorldPoints(ground.shape:getPoints())
	)
	
	love.graphics.reset()
	player:Draw()
	
	love.graphics.setColor(0, 0, 255)
	love.graphics.polygon(
		"fill", 
		objects.block.body:getWorldPoints(objects.block.shape:getPoints())
	)
	
	love.graphics.setColor(0, 0, 255)
	love.graphics.polygon(
		"fill", 
		boundaries.top.body:getWorldPoints(boundaries.top.shape:getPoints())
	)
	
	love.graphics.setColor(255, 0, 0)
	love.graphics.print("Pepper Flips : " .. pepperFlips, 10, 10)
	propulseur:draw()
end