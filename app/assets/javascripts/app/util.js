//
// Change underscore template interprolation syntax from <%= %> to {{ }}
// This is needed to avoid erb's interprolation syntax
_.templateSettings = {
  interpolate: /\{\{(.+?)\}\}/g
};

// Add our own utility functions to underscore
_.mixin({
  getTemplate: function (name) {
    var templateHtml = $('#templates .' + name).html();
    if (templateHtml) return _.template(templateHtml);
  },
  formToJSON: function (formEl) {
    var result = {};
    _.each( $(formEl).serializeArray(), function (dataPoint) {
      result[dataPoint.name] = dataPoint.value;
    });
    return result;
  }
});