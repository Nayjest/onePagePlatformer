// Generated by CoffeeScript 1.3.3
(function() {

  define([], function() {
    var GameObject;
    return GameObject = (function() {

      function GameObject(config) {
        var b, _i, _len, _ref;
        this.config = config != null ? config : {};
        this._behaviors = [];
        this.behaviors = {};
        if (this.config.behaviors) {
          _ref = this.config.behaviors;
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            b = _ref[_i];
            this.use(b);
          }
        }
      }

      GameObject.prototype.use = function(Behavior, config) {
        var behavior, existing;
        existing = this.behaviors[Behavior.name];
        if (Behavior.single) {
          if (existing) {
            return this;
          } else {
            behavior = new Behavior(this, config);
            this.behaviors[Behavior.name] = behavior;
            return this._behaviors.push(behavior);
          }
        } else {
          behavior = new Behavior(this, config);
          if (existing) {
            existing.push(behavior);
          } else {
            this.behaviors[Behavior.name] = [behavior];
          }
          return this._behaviors.push(behavior);
        }
      };

      GameObject.prototype.update = function() {
        var behavior, _i, _len, _ref, _results;
        _ref = this._behaviors;
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          behavior = _ref[_i];
          _results.push(behavior.update && behavior.update());
        }
        return _results;
      };

      GameObject.prototype.destructor = function() {
        var behavior, _i, _len, _ref, _results;
        _ref = this._behaviors;
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          behavior = _ref[_i];
          _results.push(behavior.destructor && behavior.destructor());
        }
        return _results;
      };

      return GameObject;

    })();
  });

}).call(this);