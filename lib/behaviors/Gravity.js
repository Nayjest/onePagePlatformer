// Generated by CoffeeScript 1.3.3
(function() {

  define(['components/Vector2D/Vector2D', 'behaviors/Moving'], function(Vector2D, Moving) {
    var Gravity;
    return Gravity = (function() {

      Gravity.name = 'gravity';

      Gravity.single = true;

      Gravity.g = new Vector2D(0, 0.69);

      Gravity.defaults = {
        mass: 1
      };

      function Gravity(model) {
        this.model = model;
        this.model.use(Moving);
        this.model.mass = this.model.config.mass || Gravity.defaults.mass;
      }

      Gravity.prototype.update = function() {
        return this.model.speed.add(Gravity.g.clone().multiplyScalar(this.model.mass));
      };

      return Gravity;

    })();
  });

}).call(this);