/** 
 * A basic server which accepts connections at port 4000 and saves any received
 * data in logs.json.
 */
var net = require('net');
var file = require('fs').createWriteStream(__dirname + '/logs.json');
var server = net.createServer();

server.on('connection', function(socket) {
    socket.pipe(file);
});

server.listen(4000);

