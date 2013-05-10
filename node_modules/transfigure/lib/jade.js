var jade = require('jade')
	, extend = require('lodash').extend
	, SETTINGS = {
			client: false,
			compileDebug: false,
			pretty: true
	};

/**
 * Compile 'content'
 * @param {String} content
 * @param {Object} options
 * @param {Function} fn(err, content)
 */
module.exports = function(content, options, fn) {
	jade.render(content, extend({}, SETTINGS, options), function(err, html) {
		if (err) return fn(err, content);
		content = html;
		return fn(null, content);
	});
};
