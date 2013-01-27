define [
  'components/decorate/decorate',
  'behaviors/PlatformerWalker',
  'behaviors/Layer'
], (
  decorate,
  PlatformerWalker,
  Layer
)->
  class
    @name: 'slopeOnWalk'
    @single: yes
    constructor: (@model)->
      @model.use PlatformerWalker
      @model.use Layer
      decorate @model, 'walkLeft', _methods.onWalkLeft
      decorate @model, 'walkRight', _methods.onWalkRight
    update: ->
      if @model._walkedLeft
        @model.layer.angle = -5
      else if @model._walkedRight
        @model.layer.angle = 5
      else
        @model.layer.angle = 0
      @model._walkedLeft = no
      @model._walkedRight = no

    _methods  =
      onWalkLeft: ->
        @_walkedLeft = yes
      onWalkRight: ->
        @_walkedRight = yes





