define [
  'GameObject',
  'components/Vector2D/Vector2D',
], (
GameObject,
Vector2D
)->
  class Unit extends GameObject
    defaults = [
      walkSpeed: 5
      jumpSpeed: -11.5
    ]
    constructor: (config)->
      @walkSpeed = config.walkSpeed or defaults.walkSpeed
      @jumpSpeed = config.jumpSpeed or defaults.jumpSpeed
      @speed = Vector2D.cloneFrom config.speed or Vector2D.zero
      super config

    walkLeft: ->
      @speed.x -= @walkSpeed
      @
    walkRight: ->
      @speed.x = @walkSpeed
      @
    jump: ->
      @speed.y = @jumpSpeed


