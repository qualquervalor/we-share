(function () {

  window.User = Backbone.Model.extend({});

  window.UserWall = Backbone.Collection.extend({
    model: User

  });

})();
