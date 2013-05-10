var stylus = require('stylus')
	, extend = require('lodash').extend
	, SETTINGS = {};

/**
 * Compile 'content'
 * @param {String} content
 * @param {Object} options
 * @param {Function} fn(err, content)
 */
module.exports = function(content, options, fn) {
	stylus.render(content, extend({}, SETTINGS, options), function(err, css) {
		if (err) return fn(err, content);
		content = css;
		return fn(null, content);
	});
};
