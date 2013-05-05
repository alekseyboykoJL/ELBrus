//@ sourceMappingURL=model.map
// Generated by CoffeeScript 1.6.1

/*
  Здесь реализована модель проекта. В частности игрок.
*/


(function() {
  var Player;

  Player = (function() {

    function Player(obj, x, y) {
      switch (typeof obj) {
        case 'string':
          this.name = obj;
          this.x = x;
          this.y = y;
          break;
        case 'object':
          this.name = obj.name;
          this.x = obj.x;
          this.y = obj.y;
          break;
        case 'undefined':
          this.name = "Player" + (Math.ceil(Math.random() * 1000));
          this.x = Math.ceil(Math.random() * 500);
          this.y = Math.ceil(Math.random() * 500);
          break;
        default:
          throw "Wrong player constructor.";
      }
    }

    Player.prototype.html = function() {
      return "<div id='" + this.name + "' class='player' style='background: rgb(" + (Math.ceil(Math.random() * 256)) + "," + (Math.ceil(Math.random() * 256)) + "," + (Math.ceil(Math.random() * 256)) + ")'>" + this.name + "</div>";
    };

    Player.prototype.raw = function() {
      return {
        name: this.name,
        x: this.x,
        y: this.y
      };
    };

    Player.prototype.change = function(obj) {
      if (obj.x != null) {
        this.x = obj.x;
      }
      if (obj.y != null) {
        return this.y = obj.y;
      }
    };

    return Player;

  })();

  if (typeof module !== "undefined" && module !== null) {
    module.exports = {
      Player: Player
    };
  }

  if (typeof window !== "undefined" && window !== null) {
    window.Player = Player;
  }

}).call(this);
