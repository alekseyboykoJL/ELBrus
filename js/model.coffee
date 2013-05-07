###
  Здесь реализована модель проекта. В частности игрок.
###

class World
  Players = {}
  Enemies = {}
  Bullets = {}
  constructor: ()->
    @bx1 = 0
    @bx2 = 1000
    @by1 = 0
    @by2 = 1000
  AddPlayer : (pl)->
    Players.push(pl)
    alert "Player was added"
  AddEnemy: (en)->
    Enemies.push(en)
    alert "Enemy was added"
  AddBullet: (bullet)->
    Bullets.push(bullet)
    alert "Bullet was added"

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
        #@x = Math.ceil(Math.random() * 500)
        @x = 700
        #@y = Math.ceil(Math.random() * 500)
        @y = 350
        @ml = "#{ String.fromCharCode(Math.ceil(65 + Math.random() * 25  ) ) }"
        @mr = "L"
      else throw "Wrong player constructor."

  html: () ->
    """
     <div id='#{@name}' class='player'>
        <div class='left' style='background:rgb(#{50},#{255},#{20});display: inline-block;width: 10px;'>#{@ml}</div>
        <div class="main" style='background:rgb(#{255},#{0},#{0});display: inline-block;width: 70px;'>#{@name}</div>
        <div class='right' style='background:rgb(#{50},#{255},#{20});display: inline-block;width:20px;'>#{@mr}</div>
     </div>
    """

    ###
    $("##{@name} .left")


    $("##{@name}").css('left', '10px')
    a = $("##{@name}").css('left')
    ###

  raw: () ->
    name : @name
    x    : @x
    y    : @y
  change: (obj) ->
    @x = obj.x if obj.x?
    @y = obj.y if obj.y?

class Enemy
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
        @name = "Enemy#{Math.ceil(Math.random() * 1000)}"
        @x = Player.x
        @y = Player.y
        @cd = "23"
      else throw "Wrong enemy constructor."

  html: () ->
    "
    <div id='#{@name}' class='player' style='background: rgb(#{0},#{208},#{255})'>#{@name}
       <div id='#{@name}' class='player' style='background: rgb(#{50},#{255},#{20})'>#{@cd}</div>
    </div>
    "
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
  Enemy  : Enemy
  World  : World
window?.Player = Player
window?.Enemy = Enemy
window?.World = World


