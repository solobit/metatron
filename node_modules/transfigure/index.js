// TODO: source maps

var path = require('path')
	, fs = require('fs')
	, existsSync = fs.existsSync || path.existsSync
	, COMPILERS = {
		'js': '',
		'css': '',
		'html': '',
		'coffee': 'coffeescript',
		'ls': 'livescript',
		'hbs': 'handlebars',
		'handlebars': 'handlebars',
		'styl': 'stylus',
		'less': 'less',
		'jade': 'jade',
		'twig': 'twig',
		'dust': 'dust'
	};

/**
 * Convert contents to js/css/html
 * @param {String} filepath
 * @param {String} content
 * @param {Object} [options]
 * @param {Function} fn(err, content)
 */
module.exports = function(filepath, content, options, fn) {
	if (!fn && 'function' == typeof options) {
		fn = options;
		options = {};
	}
	var extension = path.extname(filepath).slice(1)
		, name = path.basename(filepath).replace(extension, '');
	options.filepath = options.filename = filepath;
	options.extension = extension;
	options.name = name;
	if (COMPILERS[extension]) {
		return require('./lib/' + COMPILERS[extension])(content, options, fn);
	} else if (COMPILERS[extension] != null) {
		return fn(null, content);
	} else {
		return fn('no compiler found for ' + filepath, content);
	}
};
