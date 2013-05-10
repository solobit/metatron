var handlebars = require('handlebars')
	, extend = require('lodash').extend
	, SETTINGS = {
			simple: true
	};

/**
 * Compile 'content'
 * @param {String} content
 * @param {Object} options
 * @param {Function} fn(err, content)
 */
module.exports = function(content, options, fn) {
	try {
		content = 'module.exports = Handlebars.template(' + handlebars.precompile(content, extend({}, SETTINGS, options)) + ');';
		return fn(null, content);
	} catch (err) {
		return fn(err, content);
	}
};
