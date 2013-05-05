###
  BEGIN server routine
###
fs = require('fs')
app = require('http').createServer (req, res) ->
  page = if req.url is '/' then '/index.html' else req.url
  fs.readFile(
    __dirname + page,
  (err, data) ->
    if err
      res.writeHead 500
      res.end "Error loading #{page}"
    else
      res.writeHead 200
      res.end data
  )
io = require('socket.io').listen app
app.listen 8080
###
  END server routine
###


model = require('./js/model.js') # loading common model for game

players = {}

io.sockets.on('connection', (socket) ->

  socket.on('add user', (player) ->
    players[player.name] = new model.Player(player)
    socket.broadcast.emit('user have been added', players[player.name].raw())
  )
  socket.on('change user', (player) ->
    if players[player.name]? then players[player.name].change(player)
    socket.broadcast.emit('user have been changed', players[player.name].raw())
  )

)