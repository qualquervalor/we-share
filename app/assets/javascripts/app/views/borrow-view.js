(function () {

  window.BorrowView = Backbone.View.extend({

    className: 'resource_style',

    template2: _.getTemplate('resource2'),

    render: function (option) {

        var resourceHtml = this.template2( this.model.toJSON() );
        $(this.el).html(resourceHtml);

    }
  });

})();
