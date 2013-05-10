var dust = require('dustjs-linkedin')
	, path = require('path')
	, extend = require('lodash').extend
	, SETTINGS = {
	};

/**
 * Compile 'content'
 * @param {String} content
 * @param {Object} options
 * @param {Function} fn(err, content)
 */
module.exports = function(content, options, fn) {
	try {
		// Pass 'name' as file basename without extension
		content = 'module.exports = ' + dust.compile(content, options.name);
		return fn(null, content);
	} catch (err) {
		return fn(err, content);
	}
};
