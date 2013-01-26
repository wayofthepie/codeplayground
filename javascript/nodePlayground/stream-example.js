/**
 * Creates an server which will only log JSON data 
 */

var net         = require('net');
var JSONStream  = require('json-stream');

/**
 *  Allows creation of streams that can be transformed/filtered... 
 */
var eventStream = require('event-stream');

var filePath    = __dirname + '/logs.json';
var file        = require('fs').createWriteStream(filePath, {flags: 'a'});

var stringifier = eventStream.mapSync(function(data) {
    return JSON.stringify(data) + '\n'
});

var server      = net.createServer();

stringifier.pipe(file)

server.on('connection', function(socket) {
    var jsonStream  = new JSONStream();
    socket
        .pipe(jsonStream)
        .pipe(stringifier, {end: false});
});

server.listen(4000)