define [], ()->
  k =
    keyNames: []
    onKeyDown: (e) ->
      console.log e.keyCode
      k[k.keyNames[e.keyCode]] = yes

    onKeyUp: (e) ->
      k[k.keyNames[e.keyCode]] = no

    init: ->
      document.onkeydown = @onKeyDown
      document.onkeyup = @onKeyUp

  k.keyNames[32] = "space"
  k.keyNames[37] = "left"
  k.keyNames[38] = "up"
  k.keyNames[39] = "right"
  k.keyNames[40] = "down"
  k.keyNames[13] = "enter"
  k.keyNames[17] = "ctrl"

  k