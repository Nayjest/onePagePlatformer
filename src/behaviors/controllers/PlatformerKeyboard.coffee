define ['keyboard'], (keyboard)->
  class PlatformerKeyboard
    @single: yes
    @name: 'platformerKeyboardController'
    constructor: (@model)->

    update: ->
      if keyboard.up
        @model.jump()
      if keyboard.left
        @model.walkLeft()
      if keyboard.right
        @model.walkRight()
      if keyboard.ctrl
        @model.shoot()
