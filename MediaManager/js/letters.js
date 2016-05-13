//create closure
// http://www.cnblogs.com/blackmanba/p/windows-nodejs-show-system-letter.html
(function($){  
    //plugin definition  
    exec = require('child_process').exec;
	// show  Windows letter, to compatible Windows xp
	$.letters = function (callback) {
		var wmicResult;
		var command = exec('wmic logicaldisk get caption', function(err, stdout, stderr) {
			if(err || stderr) {
				console.log("root path open failed" + err + stderr);
				return;
			}
			wmicResult = stdout;
		});
		command.stdin.end();   // stop the input pipe, in order to run in windows xp
		command.on('close', function(code) {
			var data = wmicResult.split(os.EOL);
			var result = new Array();
			$.each(data, function(i,val){      
				var temp=$.trim(data[i]);
				if(temp!="Caption"&&temp!=""&&temp!=''){
					result[result.length]=temp
				}
			});   
			callback(result);
		});
	}
})(jQuery);  