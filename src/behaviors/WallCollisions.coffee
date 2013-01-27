define [
  'components/Vector2D/Vector2D',
  'behaviors/CalcMapPosition',
  'behaviors/Moving',
  'components/underscore/underscore',
], (
  Vector2D,
  CalcMapPosition,
  Moving
)->
  class WallCollisions
    @name: 'wallCollisions'
    @single: yes

    constructor: (@model)->
      @model.use CalcMapPosition
      @model.use Moving
      @model.onGround = no
      @_clearCollisions()

    _clearCollisions: ->
      @model.collisions =
        top:no
        left:no
        right:no
        bottom:no

    update: ->
      @_clearCollisions()
      pos = @model.pos.clone()
      walls = @model.map.getObjectsByDist @model.calcMapPos(), 1
      @model.onGround = no
      for wall in walls
        wPos = wall.pos.clone()
        dist = wPos.clone().substract(pos)
        if Math.abs(dist.x)>Math.abs(dist.y)
          if  Math.abs(dist.x) < @model.cellSize.x
            if dist.x>0
              @model.collisions.right = yes
              pos.x = wPos.x-@model.cellSize.x
            else
              @model.collisions.left = yes
              pos.x = wPos.x+@model.cellSize.x
        else
          if  Math.abs(dist.y)<@model.cellSize.y
            # we are above wall
            if dist.y>0
              @model.collisions.bottom = yes
              if @model.speed.y>0
                @model.speed.y = 0
              @model.onGround = yes
              pos.y = wPos.y-@model.cellSize.y
            # we are below wall
            else
              @model.collisions.top = yes
              pos.y = wPos.y+@model.cellSize.y
      @model.pos.set pos

