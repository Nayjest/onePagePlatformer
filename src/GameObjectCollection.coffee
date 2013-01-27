define [], ()->
  class CollectionBehavior
    @name: 'collection'
    @single: no
    constructor: (@model, @collection)->
    destructor: ->
      @collection.remove @model



  class GameObjectCollection extends Array
    constructor: (items = [])->
      super()
      for item in items
        @push item

    push:(item)->
      item.use CollectionBehavior, @
      super item

    remove:(item)->
      @.splice @.indexOf(item),1

