//create closure
// 
var fs = require("fs");
(function($){  
	$.dir = function (path, callback) {
		fs.readdir(path, function(err,files){
			if(err){
				console.log(err);
			}
			callback(files);
		});
	}
})(jQuery);  