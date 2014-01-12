(function () {

  window.Resource = Backbone.Model.extend({});

  window.ResourceWall = Backbone.Collection.extend({
    model: Resource

  });

})();
