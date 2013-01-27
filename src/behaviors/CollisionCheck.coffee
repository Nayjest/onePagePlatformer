define [
  'behaviors/Position',
  'behaviors/Size',
  'components/Vector2d/Vector2d'
], (Position, Size, Vector2d)->
  class CollisionCheck
    @name:'collisionCheck'
    @single: yes
    constructor: (@model)->
      @model.use Position
      @model.use Size
      @model.getCollided = @_getCollided
      if @model.config.checkCollision
        @toCheck = @model.config.checkCollision
      else
        @toCheck = no

    _getCollided: (collection)->
      res = []
      for obj in collection
        size = obj.size or Vector2d.zero
        dx2 = Math.abs(obj.pos.x - @pos.x)*2
        dy2 = Math.abs(obj.pos.y - @pos.y)*2
        if (dx2<=(@size.x+size.x)) and (dy2<=(@size.y+size.y))
          res.push obj
      res

    update: ->
      if @toCheck
        for collided in @model.getCollided @toCheck.objects
          @toCheck.handler.call @model, collided





