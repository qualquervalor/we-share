(function () {

  window.UserView = Backbone.View.extend({
    initialize: function(options){
      //calculate the distance in the intialization
      //this.name = options.name;
    },
    className: 'user_style',
    template: _.getTemplate('user'),

    render: function () {
      var userHtml = this.template( this.model.toJSON() );
      $(this.el).html(userHtml);
    }
  });

})();
