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
	//	:/r/port/data			[ sent by endpoint to server ]	receive
	//	:/s/devid/port/data		[ sent by server to endpoint ]	send


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
		var server_ip = "127.0.0.1"

		var options = {
			hostname: '0.0.0.0',
			port: 9090,
			path: '/r/'+device_id+'/'+port+'/'+data,
			method: 'GET'
		}
		
		options.hostname = server_ip;
		
		
		const req2 = http.request(options, res2 => {
		res2.on('data', d => {
			process.stdout.write(d)
		})
	})

		req2.on('error', error => {
			console.error(error)
		})

		req2.end()
		

		res.writeHead(200, {'Content-Type': 'text/plain'});
		return res.end();
	}
	else if( command == "s" )
	{
		
		var port=decodeURI(base_path[2]);
		var data=decodeURI(base_path[3]);
		
	}
	else
	{
				res.writeHead(404, {'Content-Type': 'text/plain'});
				return res.end("404 Not Found");
	}
}).listen(8080); 
