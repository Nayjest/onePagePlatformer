define [
  'components/Vector2D/Vector2D',
  'behaviors/Position',
  'components/underscore/underscore',
], (
  Vector2D,
  Position
)->
  class PlatformerWalker

    @name: 'platformerWalker'
    @single: yes

    @defaults:
      walkSpeed: 5

    constructor: (@model)->
      @model.use Position
      @model.walkSpeed = @model.config.walkSpeed or PlatformerWalker.defaults.walkSpeed
      @model.jumpSpeed = @model.config.jumpSpeed or PlatformerWalker.defaults.jumpSpeed
      @model.direction = new Vector2D(if Math.random()<0.5 then x:-1,y:0 else x:1,y:0)
      _.extend @model, @methods

    methods:

      turnAround: ->
        if @direction == 'left'
          @direction = 'right'
        else
          @direction = 'left'

      walkLeft: ->
        @direction = "left"
        @pos.x -= @walkSpeed

      walkRight: ->
        @direction = "right"
        @pos.x += @walkSpeed