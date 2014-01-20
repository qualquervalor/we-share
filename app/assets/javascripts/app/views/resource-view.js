(function () {

  window.ResourceView = Backbone.View.extend({
    initialize: function(options){
      //calculate the distance in the intialization
      //this.name = options.name;
    },
    className: 'resource_style',
    template: _.getTemplate('resource'),

    // events: {
    //   'click #submit': 'submit'
    // },

    // edit: function(){
    //   console.log("Edit function on resource-view.js fired");
    // },
    // submit: function(e){
    //   e.preventDefault();
    //   console.log("Request submit function on resource-view.js fired");
    //   this.sendRequest(msg);
    // },
    // sendRequest: function(msg)
    // {
    //   console.log("sendRequest function on resource-view.js fired");
    //   //trigger an event to an eent agregator?
    // },
    render: function () {
      var resourceHtml = this.template( this.model.toJSON() );
      $(this.el).html(resourceHtml);
    }
  });

})();
