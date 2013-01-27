define ['GameObject', 'behaviors/Moving','behaviors/Layer', 'GameObjectCollection'], (GameObject, Moving, Layer, GameObjectCollection)->
  class DynamicGameObject extends GameObject
    @collection: new GameObjectCollection()
    constructor: (config)->
      super config
      DynamicGameObject.collection.push @
      @use Moving
      @use Layer
      @
