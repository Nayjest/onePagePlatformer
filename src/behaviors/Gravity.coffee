define [
  'components/Vector2D/Vector2D',
  'behaviors/Moving'
], (
Vector2D,
Moving
)->
  class Gravity
    @name: 'gravity'
    @single: yes

    @g: new Vector2D 0, 0.69

    @defaults:
      mass:1

    constructor: (@model)->
      @model.use Moving
      @model.mass = @model.config.mass or Gravity.defaults.mass

    update: ->
      @model.speed.add Gravity.g.clone().multiplyScalar(@model.mass)
