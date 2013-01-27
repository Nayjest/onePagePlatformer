define [
  'GameObject',
  'components/Vector2D/Vector2D',
], (
GameObject,
Vector2D
)->
  class Unit extends GameObject
    constructor: (config)->
      super config
      @use Size
      @use Position
      @


