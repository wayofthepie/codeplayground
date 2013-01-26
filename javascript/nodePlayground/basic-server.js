var net = require('net');
var file = require('fs').createWriteStream(__dirname + '/logs.json');
var server = net.createServer();

server.on('connection', function(socket) {
    socket.pipe(file);
});

server.listen(4000);

