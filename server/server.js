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
	//	::::::/r/devid/port/data			[ sent by gateway ]
	//	::::::/s/gateid/devid/port/data		[ sent by browser ]


	var command=decodeURI(base_path[1]);


	if( command == "r" )
	{
		var device_id=decodeURI(base_path[2]);
		var port=decodeURI(base_path[3]);
		var data=decodeURI(base_path[4]);

		var ip = req.headers['x-forwarded-for'] || 
			req.connection.remoteAddress || 
			req.socket.remoteAddress ||
			req.connection.socket.remoteAddress;

		gate_id=(ip.split(".")[ip.split(".").length - 1]);
		console.log("received :\t" + gate_id +"\t" + device_id + "\t" + port +"\t" + data );

		fs.appendFile('log.csv', gate_id +"," + device_id + "," + port +"," + data, (err) => {
			if (err) {
				throw err;
			}
		});

		res.writeHead(200, {'Content-Type': 'text/plain'});
		return res.end();
	}
	else if( command == "s" )
	{
		var gate_id=decodeURI(base_path[2]);
		var device_id=decodeURI(base_path[3]);
		var port=decodeURI(base_path[4]);
		var data=decodeURI(base_path[5]);
		var gate_ip = "10.0.0."+gate_id

		var options = {
			hostname: '0.0.0.0',
			port: 9090,
			path: '/'+port+'/'+data,
			method: 'GET'
		}
		
		options.hostname = gate_ip;
		
		
		const req2 = http.request(options, res2 => {
			res2.on('data', d => {
				process.stdout.write(d)
			})
		})

		req2.on('error', error => {
			console.error(error)
		})

		req2.end()
	}
	else
	{
				res.writeHead(404, {'Content-Type': 'text/plain'});
				return res.end("404 Not Found");
	}
}).listen(9090); 
