


b2Vec2 = Box2D.Common.Math.b2Vec2;
b2BodyDef = Box2D.Dynamics.b2BodyDef;
b2Body = Box2D.Dynamics.b2Body;
b2FixtureDef = Box2D.Dynamics.b2FixtureDef;
b2Fixture = Box2D.Dynamics.b2Fixture;
b2World = Box2D.Dynamics.b2World;
b2MassData = Box2D.Collision.Shapes.b2MassData;
b2PolygonShape = Box2D.Collision.Shapes.b2PolygonShape;
b2CircleShape = Box2D.Collision.Shapes.b2CircleShape;
b2DebugDraw = Box2D.Dynamics.b2DebugDraw;
b2AABB = Box2D.Collision.b2AABB

#  worldBox = new b2AABB()
#  worldBox.lowerBound.Set(-mapW/2, -mapH/2)
#  worldBox.upperBound.Set(mapW/2, mapH/2)

world = window.world = new b2World(new b2Vec2(0,5), true)

bodyDef = new b2BodyDef;
bodyDef.type = b2Body.b2_dynamicBody
box = window.box = world.CreateBody(bodyDef)
fixDef = new b2FixtureDef
fixDef.density = 1000
fixDef.friction = 0
fixDef.restitution = 0
fixDef.shape = new b2PolygonShape
fixDef.shape.SetAsBox(16,16)
box.CreateFixture(fixDef)

# ground
bodyDef = new b2BodyDef
bodyDef.type = b2Body.b2_staticBody
fixDef = new b2FixtureDef
fixDef.density = 1.0
fixDef.friction = 0
fixDef.restitution = 0
fixDef.shape = new b2PolygonShape
fixDef.shape.SetAsBox(1000, 10)
bodyDef.position.Set(0,mapH/2)
ground = window.ground = world.CreateBody(bodyDef)
ground.CreateFixture(fixDef)



control = ->
  if keyboard.up
    box.ApplyForce(new b2Vec2(0,-200000000),new b2Vec2(0,0))
  if keyboard.left
    box.ApplyForce(new b2Vec2(-200000000,0),new b2Vec2(0,0))
  if keyboard.right
    box.ApplyForce(new b2Vec2(200000000,0),new b2Vec2(0,0))

gravity = ()->
  for unit in units
    coords = unit.getOffset()
    unit.setOffset [coords[0], coords[1]+1]
intervalTime = 1000 / 60
gameSpeed = 10
gameLoop = ->
  control()


  world.Step intervalTime*gameSpeed/1000, 10, 10
  pos = box.GetPosition()
  playerLayer.setOffset([pos.x,pos.y])
  mapLayer.redraw()
  world.ClearForces()
setInterval gameLoop, intervalTime