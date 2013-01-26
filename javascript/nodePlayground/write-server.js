var net         = require('net');
var JSONStream  = require('json-stream');

/**
 *  Allows creation of streams that can be transformed/filtered... 
 */
var eventStream = require('event-stream');
var file        = require('fs')
                    .createWriteStream(__dirname + '/logs.json', {flags: 'a'});

var server      = net.createServer();

var stringifier = eventStream.mapSync(function(data) {
    return JSON.stringify(data) + '\n'
});

var source = eventStream.mapSync(function(o) {
    return o;
});

source
    .pipe(stringifier)
    .pipe(file);

server.on('connection', function(socket) {
    var jsonStream  = new JSONStream();
    socket
        .pipe(jsonStream)
        .pipe(source, {end: false});
});

server.listen(4000);

module.exports = source;