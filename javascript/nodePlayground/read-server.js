var net = require('net');
var JSONStream = require('json-stream');
var eventStream = require('event-stream');
var pup = require('pup');

module.exports = function(source) {
    var server = net.createServer();
    
    
    server.on('connection', function(socket) {
        var started = false;
        
        var stringifier = eventStream.mapSync(function(data) {
            return JSON.stringify(data) + '\n';
        });
        
        /**
         * Unbind all the pipes
         */
        function end() {
            pup.unpipe(source, stringifier);
            pup.unpipe(stringifier, socket);
            started = false;
        }
        
        var actions = {
            start: function(command) {
                if(started) return;
              
                /**
                 * Effectively:
                 * source
                 * .pipe(stringifier)
                 * .pipe(socket);
                 */
                pup.pipe(source, stringifier);
                pup.pipe(stringifier, socket);
                console.log(started)
                started = true;                
            },
            stop: end           
        };
        
        /*
         * {"action" : "start"} | {"action" : "stop"} 
         */
        var jsonStream = new JSONStream();
        jsonStream.on('data', function(command) {
            var action = command.action;
            
            if(action && actions[action]) actions[action](command);
        });
        
        socket.pipe(jsonStream);
        socket.on('end', end);
    });
    
    server.listen(4001);    
}