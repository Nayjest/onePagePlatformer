define [], ()->
  class GameObject

    constructor: (@config = {})->
      @_behaviors = []
      @behaviors = {}
      if @config.behaviors
        for b in @config.behaviors
          @use b

    use: (Behavior, config)->
      existing = @behaviors[Behavior.name]
      if Behavior.single
        if existing
          return @
        else
          behavior = new Behavior @, config
          @behaviors[Behavior.name] = behavior
          @_behaviors.push behavior
      else
        behavior = new Behavior @, config
        if existing
          existing.push behavior
        else
          @behaviors[Behavior.name] = [behavior]
        @_behaviors.push behavior

    update: ->
      for behavior in @_behaviors
        behavior.update and behavior.update()

    destructor: ->
      for behavior in @_behaviors
        behavior.destructor and behavior.destructor()