define [
  'components/Vector2D/Vector2D',
  'behaviors/PlatformerWalker',
  'components/underscore/underscore',
], (
Vector2D,
PlatformerWalker
)->
  class PlatformerWalkerAI

    @name: 'platformerWalkerAI'
    @single: yes

    constructor: (@model)->
      @model.use PlatformerWalker
      _.extend @model, @methods

    update: ->
      if Math.random()<0.01
        @model.jump()
      @model.walk()
      if @model.direction=="left" and @model.collisions.left
        @model.turnAround()
      if @model.direction=="right" and @model.collisions.right
        @model.turnAround()

    methods:

      walk: ->
        if @direction == 'left'
          @walkLeft()
        else
          @walkRight()