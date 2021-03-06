//@ sourceMappingURL=server.map
// Generated by CoffeeScript 1.6.1

/*
  BEGIN server routine
*/


(function() {
  var Ws, app, fs, io, model, players;

  fs = require('fs');

  app = require('http').createServer(function(req, res) {
    var page;
    page = req.url === '/' ? '/index.html' : req.url;
    return fs.readFile(__dirname + page, function(err, data) {
      if (err) {
        res.writeHead(500);
        return res.end("Error loading " + page);
      } else {
        res.writeHead(200);
        return res.end(data);
      }
    });
  });

  io = require('socket.io').listen(app);

  app.listen(8080);

  /*
    END server routine
  */


  model = require('./js/model.js');

  players = {};

  Ws = new model.World();

  io.sockets.on('connection', function(socket) {
    socket.on('add user', function(pl) {
      Ws.AddPlayer(pl);
      socket.emit('Shut Up And Take My World', Ws);
      return socket.broadcast.emit('user have been added', pl);
    });
    return socket.on('change user', function(pl) {
      Ws.ChangePlayer(pl);
      return socket.broadcast.emit('user have been changed', pl);
    });
    /*
    socket.on('add enemy', (enemy) ->
      enemies[enemy.name] = new model.Enemy(enemy)
      socket.broadcast.emit('enemy have been added', enemies[enemy.name].raw())
      )
    
    socket.on('change enemy', (enemy) ->
      if enemies[enemy.name]? then enemies[enemy.name].change(enemy)
      socket.broadcast.emit('enemy have been changed', enemies[enemy.name].raw())
      )
    */

  });

}).call(this);
