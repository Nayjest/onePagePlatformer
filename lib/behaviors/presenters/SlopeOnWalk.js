// Generated by CoffeeScript 1.3.3
(function() {

  define(['components/decorate/decorate', 'behaviors/PlatformerWalker', 'behaviors/Layer'], function(decorate, PlatformerWalker, Layer) {
    return (function() {
      var _methods;

      _Class.name = 'slopeOnWalk';

      _Class.single = true;

      function _Class(model) {
        this.model = model;
        this.model.use(PlatformerWalker);
        this.model.use(Layer);
        decorate(this.model, 'walkLeft', _methods.onWalkLeft);
        decorate(this.model, 'walkRight', _methods.onWalkRight);
      }

      _Class.prototype.update = function() {
        if (this.model._walkedLeft) {
          this.model.layer.angle = -5;
        } else if (this.model._walkedRight) {
          this.model.layer.angle = 5;
        } else {
          this.model.layer.angle = 0;
        }
        this.model._walkedLeft = false;
        return this.model._walkedRight = false;
      };

      _methods = {
        onWalkLeft: function() {
          return this._walkedLeft = true;
        },
        onWalkRight: function() {
          return this._walkedRight = true;
        }
      };

      return _Class;

    })();
  });

}).call(this);
