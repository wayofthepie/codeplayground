var net         = require('net');
var filePath    = __dirname + '/logs.json';

/**
 * Write streams by default do not open in append mode
 */
var file        = require('fs').createWriteStream(filePath, {flags: 'a'});

var server      = net.createServer();

server.on('connection', function(socket) {
    /**
     * pipe() by default closes the destination stream, therefore 
     * add option end: false
     */
    socket.pipe(file, {end: false});
});

server.listen(4000)