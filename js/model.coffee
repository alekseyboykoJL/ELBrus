###
  Здесь реализована модель проекта. В частности игрок.
###

class Player
  constructor: (obj, x, y) ->
    switch typeof obj
      when 'string'
        @name = obj
        @x = x
        @y = y
      when 'object'
        @name = obj.name
        @x = obj.x
        @y = obj.y
      when 'undefined'
        @name = "Player#{Math.ceil(Math.random() * 1000)}"
        @x = Math.ceil(Math.random() * 500)
        @y = Math.ceil(Math.random() * 500)
      else throw "Wrong player constructor."

  html: () ->
    "<div id='#{@name}' class='player' style='background: rgb(#{Math.ceil(Math.random() * 256)},#{Math.ceil(Math.random() * 256)},#{Math.ceil(Math.random() * 256)})'>#{@name}</div>"
  raw: () ->
    name : @name
    x    : @x
    y    : @y
  change: (obj) ->
    @x = obj.x if obj.x?
    @y = obj.y if obj.y?


# exports for client (window.) and server (require(...).)
module?.exports =
  Player : Player
window?.Player = Player
