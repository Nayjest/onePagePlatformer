// Generated by CoffeeScript 1.3.3
(function() {

  define(['components/Vector2D/Vector2D', 'behaviors/Moving', 'behaviors/Gravity', 'components/underscore/underscore'], function(Vector2D, Moving, Gravity) {
    var PlatformerJump;
    return PlatformerJump = (function() {

      PlatformerJump.name = 'platformerJump';

      PlatformerJump.single = true;

      PlatformerJump.defaults = {
        jumpSpeed: 11.1
      };

      function PlatformerJump(model) {
        this.model = model;
        this.model.use(Moving);
        this.model.use(Gravity);
        this.model.jumpSpeed = this.model.config.jumpSpeed || PlatformerJump.defaults.jumpSpeed;
        this.model.jump = function() {
          if (this.collisions.bottom) {
            return this.speed.y = -this.jumpSpeed;
          }
        };
      }

      return PlatformerJump;

    })();
  });

}).call(this);
