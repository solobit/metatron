var livescript = require('LiveScript')
	, extend = require('lodash').extend
	, SETTINGS = {
			bare: true
	};

/**
 * Compile 'content'
 * @param {String} content
 * @param {Object} options
 * @param {Function} fn(err, content)
 */
module.exports = function(content, options, fn) {
	try {
		// Compile without function wrapper
		content = livescript.compile(content, extend({}, SETTINGS, options));
		return fn(null, content);
	} catch (err) {
		return fn(err, content);
	}
};
