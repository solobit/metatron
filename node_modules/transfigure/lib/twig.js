var twig = require('twig').twig
  , extend = require('lodash').extend
  , path = require('path')
  , SETTINGS = {};

/**
 * Compile 'content'
 * @param {String} content
 * @param {Object} options
 * @param {Function} fn(err, content)
 */
module.exports = function(content, options, fn) {
    var template = twig({
      path: options.filepath,
      base: path.dirname(options.filepath),
      async: false
    });
    try {
      content = template.render(extend({}, SETTINGS, options));
      return fn(null, content);
    } catch (err) {
      return fn(err, content);
    }
};
