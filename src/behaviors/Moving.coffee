define [
  'components/Vector2D/Vector2D',
  'behaviors/Position'
], (
  Vector2D,
  Position
)->
  class Moving
    @name: 'moving'
    @single: yes
    constructor: (@model)->
      @model.use Position
      @model.speed = Vector2D.cloneFrom @model.config.speed or Vector2D.zero
    update: ->
      @model.pos.add @model.speed
