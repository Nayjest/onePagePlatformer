// Generated by CoffeeScript 1.3.3
(function() {

  define(['behaviors/Position', 'behaviors/Size', 'components/Vector2d/Vector2d'], function(Position, Size, Vector2d) {
    var CollisionCheck;
    return CollisionCheck = (function() {

      CollisionCheck.name = 'collisionCheck';

      CollisionCheck.single = true;

      function CollisionCheck(model) {
        this.model = model;
        this.model.use(Position);
        this.model.use(Size);
        this.model.getCollided = this._getCollided;
        if (this.model.config.checkCollision) {
          this.toCheck = this.model.config.checkCollision;
        } else {
          this.toCheck = false;
        }
      }

      CollisionCheck.prototype._getCollided = function(collection) {
        var dx2, dy2, obj, res, size, _i, _len;
        res = [];
        for (_i = 0, _len = collection.length; _i < _len; _i++) {
          obj = collection[_i];
          size = obj.size || Vector2d.zero;
          dx2 = Math.abs(obj.pos.x - this.pos.x) * 2;
          dy2 = Math.abs(obj.pos.y - this.pos.y) * 2;
          if ((dx2 <= (this.size.x + size.x)) && (dy2 <= (this.size.y + size.y))) {
            res.push(obj);
          }
        }
        return res;
      };

      CollisionCheck.prototype.update = function() {
        var collided, _i, _len, _ref, _results;
        if (this.toCheck) {
          _ref = this.model.getCollided(this.toCheck.objects);
          _results = [];
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            collided = _ref[_i];
            _results.push(this.toCheck.handler.call(this.model, collided));
          }
          return _results;
        }
      };

      return CollisionCheck;

    })();
  });

}).call(this);
