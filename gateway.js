var http = require('http');
var url = require('url');
var fs = require('fs');

/*
 *
 *
*/

http.createServer(function (req, res) {
	var q = url.parse(req.url, true);
	var base_path = q.pathname.split("/");
	var command=decodeURI(base_path[1]);
	console.log(req);
//		content=decodeURI(content);
	var filename=decodeURI(base_path[2]);

	console.log(command);
	console.log("FILE : \n" + filename + "\n\n---------\n\n");


	if( command == "r" )
	{
		fs.readFile(filename, function(err, data) {
			if (err) {
				res.writeHead(404, {'Content-Type': 'text/plain'});
				return res.end("404 Not Found");
		    } 
			res.writeHead(200, {'Content-Type': 'text/plain'});
			res.write(data);
			console.log(data + " ");
			return res.end();
		});
		
	}
	else
	{
				res.writeHead(404, {'Content-Type': 'text/plain'});
				return res.end("404 Not Found");
	}
}).listen(8080); 
