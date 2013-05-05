###
  Здесь реализован веьс клиентский JavaScript. Подразумевается, что модель
  подключается заранее.
###

do ($ = jQuery) -> $(document).ready(() ->
  socket = io.connect(document.URL.match(/^http:\/\/[^/]*/))

  setPlayerDiv = (pl) ->
    plDiv = $('#' + pl.name)
    if plDiv.length is 0
      plDiv = $(document.body).append(pl.html())
      plDiv = $('#' + pl.name)
    plDiv.css('left', pl.x + 'px')
    plDiv.css('top', pl.y + 'px')

  me = new Player()
  setPlayerDiv(me)

  socket.emit('add user', me.raw())
  socket.on('user have been added', (data) -> setPlayerDiv(new Player(data) ) )
  socket.on('user have been changed', (data) -> setPlayerDiv(new Player(data) ) )

  $("body").keydown((e) ->
    switch e.keyCode
      when 37 then me.x -= 10
      when 38 then me.y -= 10
      when 39 then me.x += 10
      when 40 then me.y += 10
    if 37 <= e.keyCode <= 40
      setPlayerDiv(me)
      socket.emit('change user', me.raw())
  )
)

