define [], ()->
  class Unit
    _defaults =
      hp:10
      damage: 1

    @name: 'unit'
    @single: yes
    @defaults:_defaults
    constructor: (@model)->
      @model.hp = @model.config.hp or _defaults.hp
      @kills = @model.config.kills or 0
      @damage = @model.config.damage or _defaults.damage
      _.extend @model, @methods

    methods:
      kill: (unit)->
        unit.die()
        @kills++
      die: ()->
        @destructor()

      attack:(unit)->
        unit.getHurt(@damage)

      hetHurt: (damage)->
        @hp -= damage

    update: ->
        if @model.hp<0
          @model.die()


