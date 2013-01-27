define [], ()->
  class LifeTime
    @name:'lifeTime'
    @single: yes
    constructor: (@model)->
      if @model.config.lifeTime
        @model.lifeTime = @model.config.lifeTime
        setTimeout (->@model.destructor()), @model.config.lifeTime
