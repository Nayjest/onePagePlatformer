define ['components/Vector2D/Vector2D'], (Vector2D)->
  class Size
    @name: 'size'
    @single: yes
    constructor: (@model)->
      @model.size = Vector2D.cloneFrom @model.config.size or Vector2D.zero