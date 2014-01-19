(function () {

  window.UserWallView = Backbone.View.extend({
    initialize: function (options) {
      this.listenTo(this.collection, 'add', this.addUserToWall);
    },

    addUserToWall: function (user) {
      var view = new UserView({ model: user });
      view.render();
      $(this.el).append(view.el);
    }
  });

})();