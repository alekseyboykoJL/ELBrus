###
  Здесь реализован веьс клиентский JavaScript. Подразумевается, что модель
  подключается заранее.
###

do ($ = jQuery) -> $(document).ready(() ->
  socket = io.connect(document.URL.match(/^http:\/\/[^/]*/))

  Viewer=(obj)->
    if (obj instanceof Player)
      html = """
            <div id='#{@name}' class='player'>
              <div class='left' style='background:rgb(#{50},#{255},#{20});display: inline-block;width: 10px;'>#{@ml}</div>
              <div class="main" style='background:rgb(#{255},#{0},#{0});display: inline-block;width: 70px;'>#{@name}</div>
              <div class='right' style='background:rgb(#{50},#{255},#{20});display: inline-block;width:20px;'>#{@mr}</div>
            </div>
            """
      return html
    if (obj instanceof Enemy)
      return alert "This is class Enemy"

  setPlayerDiv = (pl) ->
    plDiv = $('#' + pl.name)
    if plDiv.length is 0
      plDiv = $(document.body).append(pl.html())
      plDiv = $('#' + pl.name)
    plDiv.css('left', pl.x + 'px')
    plDiv.css('top', pl.y + 'px')

  Wc = new World()
  alert "Wc.name=" + Wc.name

  me = new Player()
  en = new Enemy()

  setPlayerDiv(me)

  socket.emit('add user', me)

  socket.on('Shut Up And Take My World', (Ws) ->
    #Wc = new World(Ws)
    alert "Wc.name="+Wc.name
  )
  socket.on('user have been added', (pl) ->
      setPlayerDiv( new Player(pl) )
      Wc.AddPlayer(pl)
      alert "Joined "+Wc.Players[pl.name].name
  )
  socket.on('user have been changed', (data) ->
      setPlayerDiv( new Player(data) )
      Wc.ChangePlayer(pl)
  )

  socket.on('enemy have been added', (data) -> setPlayerDiv(new Enemy(data) ) )
  socket.on('enemy have been changed', (data) -> setPlayerDiv(new Enemy(data) ))

  $("body").keydown((e) ->
    switch e.keyCode
      when 37
        me.x -= 10
      when 38 then me.y -= 10
      when 39 then me.x += 10
      when 40 then me.y += 10

      when 83
        en.x=me.x
        en.y=me.y+100
        setPlayerDiv(en)
        ###
         while(en.x<=100)
          en.x++
          setPlayerDiv(en)
          socket.emit('add enemy', en.raw())
          socket.emit('change enemy', en.raw())
        ###

    if String.fromCharCode(e.keyCode) == en.cd
        en.x=Math.ceil(Math.random() * 500)
        en.y=Math.ceil(Math.random() * 500)
        #me.ml="#{ String.fromCharCode(Math.ceil(65 + Math.random() * 25  ) ) }"
        setPlayerDiv(en)
        socket.emit('change enemy', en)

    if String.fromCharCode(e.keyCode) == me.ml
        me.x-=10
        me.ml="#{ String.fromCharCode(Math.ceil(65 + Math.random() * 25  ) ) }"
        setPlayerDiv(me)
        socket.emit('change user', me)

    if String.fromCharCode(e.keyCode) == me.mr
      me.x+=10
      me.mr="#{ String.fromCharCode(Math.ceil(65 + Math.random() * 25  ) ) }"
      setPlayerDiv(me)
      socket.emit('change user', me)

    if 37 <= e.keyCode <= 40
      setPlayerDiv(me)
      socket.emit('change user', me)
  )



)





