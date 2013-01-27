require [
    'components/require/require',
    'components/decorate/decorate',
    'components/Vector2d/Vector2d',
    'components/mixin/lib/mixin',
    'keyboard',
    'Map',
    'GameObject',
    'DynamicGameObject'
    'behaviors/Layer',
    'behaviors/WallCollisions',
    'behaviors/Gravity',
    'behaviors/PlatformerWalker',
    'behaviors/presenters/SlopeOnWalk',
    'behaviors/controllers/PlatformerWalkerAI',
    'behaviors/controllers/PlatformerKeyboard',
    'behaviors/PlatformerJump',
    'behaviors/CollisionCheck',
    'behaviors/Moving',
    'behaviors/Size',
    'behaviors/Shooter',
    'resources',
    'settings',
    'components/graphics/lib/layers/dom/DomRectLayer',
    'GameObjectCollection',
    'components/underscore/underscore',
], (
  require,
  decorate,
  Vector2d
  mixin
  keyboard,
  Map,
  GameObject,
  DynamicGameObject
  Layer,
  WallCollisions,
  Gravity,
  PlatformerWalker,
  SlopeOnWalk,
  PlatformerWalkerAI,
  PlatformerKeyboardController,
  PlatformerJump,
  CollisionCheck,
  Moving,
  Size,
  Shooter,
  resources,
  settings,
  DomRectLayer,
  GameObjectCollection
)->

  kills = 0
  deaths = 0
  points = 0
  paused = false
  Gravity.g.setValues(0, settings.g)
  keyboard.init()

  mapLayer = new DomRectLayer
    color:'#EEEEEE'

  objDefaults =
    size:settings.cellSize
    cellSize: settings.cellSize
    css:
      outline:'none'
  wallDefaults = _.defaults {
    parent:mapLayer
  },  objDefaults





  map = new Map resources.map1, resources.objDictionary, (config, pos, map)->
    cfg = _.extend {}, config, wallDefaults
    cfg.pos = pos
      .substract(map.size.clone().divideScalar(2))
      .addScalar(0.5)
      .multiply(settings.cellSize)
    new DomRectLayer cfg

  mapLayer.size.set map.size.clone().multiply settings.cellSize
  mapLayer.redraw()

  unitDefaults = _.defaults {
    map: map,
  }, objDefaults

  Layer.defaults =
    layerClass:DomRectLayer
    layerConfig:objDefaults

  enemies = new GameObjectCollection()
  player = new DynamicGameObject _.defaults {
    behaviors: [
      PlatformerKeyboardController
      PlatformerWalker,
      PlatformerJump,
      WallCollisions,
      Shooter,
      Gravity
      SlopeOnWalk,
      Size,
      CollisionCheck
    ],
    size:
      x: 20
      y: 20
    checkCollision:
      objects: enemies
      handler: (obj)->
        @die()
  },unitDefaults
  player.type = 'player'
  player.die = ->
    $('#deathsVal').html deaths
    $('#gameover').show('slow')
    paused = true
    setTimeout (->
      points=0
      $('#pointsVal').html points
      deaths++
      $('#gameover').hide('slow')
      for e in enemies.slice(0)
        e.destructor()
      player.pos.setValues 0, 0
      paused = false
      createEnemy()
    ),1000

  createBox = ->

    x = ~~(Math.random()*map.size.x)
    y = ~~(Math.random()*map.size.y)

    x -= map.size.x/2
    y -= map.size.x/2
    box = new DynamicGameObject _.defaults {
      pos:new Vector2d(x,y).multiply(settings.cellSize)
      size:
        x:15
        y:15
      layer: new  DomRectLayer _.defaults {
        color:'green'
        size:
          x:15
          y:15
        css:
          zIndex:9999
          outline:'none'
      }, objDefaults
      behaviors: [
        Gravity,
        Layer,
        Size,
        Moving,
        WallCollisions,
        #SlopeOnWalk
      ]
    },unitDefaults
    box.config.checkCollision =
      objects: [player]
      handler: (obj)->
        points++
        $('#pointsVal').html points
        @destructor()
    box.use CollisionCheck
    decorate box, 'destructor', ->
      createBox()
    box
  window.createBox = createBox

  player.createBullet = (pos, direction)->
    bullet = new DynamicGameObject
      pos:@pos
      speed: direction
      size:{x:1,y:1}
      layer: new  DomRectLayer
        color:'orange'
        size:{x:10,y:2}
        css:
          outline:'none'
    bullet.speed.multiplyScalar(20)
    bullet.speed.y = (Math.random()-0.5)*2
    bullet.config.checkCollision =
      objects: enemies
      handler: (obj)->
        kills++;
        $('#killsVal').html kills
        obj.destructor()
        @destructor()
    bullet.use CollisionCheck
    bullet.use Size



  createEnemy= ->
    enemySpawnPoint = map.size.clone().multiply({x:0,y:-0.5}).multiply(settings.cellSize)
    console.log enemySpawnPoint

    unit = new DynamicGameObject _.extend {
      pos:enemySpawnPoint
      walkSpeed:0.5+Math.random()*3
      layer: new  DomRectLayer _.extend {color:'red'}, objDefaults
      behaviors: [
        PlatformerWalkerAI,
        PlatformerJump,
        WallCollisions,
        Gravity,
        Layer,
        Size
        #SlopeOnWalk
      ]
    },unitDefaults
    enemies.push unit
    unit


  mapLayer.redraw()
  intervalTime = 1000 / 60
  gameLoop = ->
    return if paused
    for unit in DynamicGameObject.collection
      if unit
        if (Math.abs(unit.pos.y) > mapLayer.size.y/2) or (Math.abs(unit.pos.x) > mapLayer.size.x/2)
          if unit.type == "player"
            unit.die()
          else
            unit.destructor()
        unit.update()
        unit.layer.redraw()





    # mapLayer.redraw()
  setInterval gameLoop, intervalTime
  createEnemy()
  createBox()
  createEnemy()
  setInterval ()->
    if Math.random()< 0.44
      createEnemy()
  , 500

  window.objects = DynamicGameObject.collection
  window.enemies = enemies

