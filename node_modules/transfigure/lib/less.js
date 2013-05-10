var less = require('less')
	, extend = require('lodash').extend
	, SETTINGS = {};

/**
 * Compile 'content'
 * @param {String} content
 * @param {Object} options
 * @param {Function} fn(err, content)
 */
module.exports = function(content, options, fn) {
	var parser = new less.Parser(extend({}, SETTINGS, options));
	parser.parse(content, function(err, tree) {
		if (err) return fn(err, content);
		content = tree.toCSS();
		return fn(null, content);
	});
};
