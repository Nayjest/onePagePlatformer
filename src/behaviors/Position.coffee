define ['components/Vector2D/Vector2D'], (Vector2D)->
  class Position
    @name: 'position'
    @single: yes
    constructor: (@model)->
      @model.pos = Vector2D.cloneFrom @model.config.pos or Vector2D.zero