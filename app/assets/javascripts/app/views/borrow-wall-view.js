(function () {

  window.BorrowWallView = Backbone.View.extend({
    initialize: function (options) {
     this.listenTo(this.collection, 'add', this.add2ResourceToWall);
    },

    add2ResourceToWall: function (resource) {
      var view = new BorrowView({ model: resource });
      view.render();
      $(this.el).append(view.el);
    }
  });

})();