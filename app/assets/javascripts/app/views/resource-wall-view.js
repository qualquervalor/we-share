(function () {

  window.ResourceWallView = Backbone.View.extend({
    initialize: function (options) {
      this.listenTo(this.collection, 'add', this.addResourceToWall);
    },

    addResourceToWall: function (resource) {
      var view = new ResourceView({ model: resource });
      view.render();
      $(this.el).append(view.el);
    }
  });

})();