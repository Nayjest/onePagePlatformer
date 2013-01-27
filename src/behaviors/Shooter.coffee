define [
  'components/Vector2D/Vector2D',
  'behaviors/Position',
], (
Vector2D,
Position
)->
  class Shooter
    @name: 'shooter'
    @single: yes
    @defaults:
      shootingDelay: 40

    constructor: (model)->
      @model = model
      @model.use Position

      @model.shootingDelay = @model.config.shootingDelay or Shooter.defaults.shootingDelay
      @model._canShoot = yes
      @model._restoreCanShoot = ->
        model._canShoot = yes

      _.extend @model, @methods



    methods:
      shoot: ->
        if @_canShoot
          directionVector = if @direction == "left" then {x:-1,y:0} else {x:1,y:0}
          @createBullet(@pos,directionVector)
          @_canShoot = no
          setTimeout @_restoreCanShoot,  @shootingDelay

