define [
  'components/Vector2D/Vector2D',
  'behaviors/Moving',
  'behaviors/Gravity',
  'components/underscore/underscore',
], (
  Vector2D,
  Moving,
  Gravity
)->
  class PlatformerJump
    @name: 'platformerJump'
    @single: yes

    @defaults:
      jumpSpeed: 11.1

    constructor: (@model)->
      @model.use Moving
      @model.use Gravity
      @model.jumpSpeed = @model.config.jumpSpeed or PlatformerJump.defaults.jumpSpeed
      @model.jump =  ->
        if @collisions.bottom
          @speed.y = -@jumpSpeed
