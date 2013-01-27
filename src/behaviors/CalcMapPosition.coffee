define [
  'components/Vector2D/Vector2D',
  'behaviors/Position',
  'components/underscore/underscore',
], (
  Vector2D,
  Position
)->
  class CalcMapPosition
    @name: 'calcMapPosition'
    @single: yes

    @calcMapPos = (obj, map, cellSize)->
      obj.pos.clone().divide(cellSize).add(
        map.size.clone().divideScalar(2).addScalar(-0.5)
      ).round()

    constructor: (model)->
      @model = model
      @model.use Position
      @model.map = @model.config.map
      @model.cellSize = @model.config.cellSize
      @model.calcMapPos = -> CalcMapPosition.calcMapPos model, model.map, model.cellSize

    update: ->

