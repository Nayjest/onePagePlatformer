define ['behaviors/Position'], (Position)->
  class Layer
    @name: 'layer'

    @defaults:
      layerConfig:{}
      layerClass:null

    constructor: (@model)->
      @model.use Position
      if @model.config.layer
        @model.layer = @model.config.layer
      else
        _layerConfig = _.extend {}, Layer.defaults.layerConfig, @model.config.layerConfig
        _layerClass = @model.config.layerClass or Layer.defaults.layerClass
        @model.layer = new _layerClass _layerConfig

      # link positions
      @model.layer.pos = @model.pos

    destructor: ->
      @model.layer.destructor()
