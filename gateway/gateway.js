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

	//format : 
	//	addr/r/port/data [ sent by endpoint ]
	//	addr/s/devid/port/data [ sent by server ]


	var command=decodeURI(base_path[1]);


	if( command == "r" )
	{
		var port=decodeURI(base_path[2]);
		var data=decodeURI(base_path[3]);

		var ip = req.headers['x-forwarded-for'] || 
			req.connection.remoteAddress || 
			req.socket.remoteAddress ||
			req.connection.socket.remoteAddress;

		device_id=(ip.split(".")[ip.split(".").length - 1]);
		console.log("received :\t" + device_id + "\t" + port +"\t" + data );

		res.writeHead(200, {'Content-Type': 'text/plain'});
		return res.end();
	}
	else
	{
				res.writeHead(404, {'Content-Type': 'text/plain'});
				return res.end("404 Not Found");
	}
}).listen(8080); 
