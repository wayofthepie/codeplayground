var net = require('net');
var JSONStream = require('json-stream');
var eventStream = require('event-stream');
var pup = require('pup');

module.exports = function(source) {
    var server = net.createServer();
    
    
    server.on('connection', function(socket) {
        var filter;
        var started = false;
        
        var stringifier = eventStream.mapSync(function(data) {
            return JSON.stringify(data) + '\n';
        });
        
        /**
         * Unbind all the pipes
         */
        function end() {
            pup.unpipe(source, filter);
            pup.unpipe(filter,stringifier);
            pup.unpipe(stringifier, socket);
            started = false;
        }
        
        var actions = {
            start: function(command) {
                if(started) return;
                
                /**
                 * If the filter option is specified contruct a new function 
                 * object with command.filter as the body, e.g. 
                 * {"action":"start", "filter": "return ev.a 
                 *      && ev.a.charAt(0) == 'A';"}
                 */
                if(command.filter) {
                    command.filter = new Function('ev', command.filter);
                } 
                
                /**
                 * If no filter is specified, or a non-function is specified 
                 * as a filter do not filter data, i.e. turn the filter into 
                 * a function that always returns true.
                 */
                if(!command.filter || typeof command.filter != 'function') {
                    command.filter = function() { return true; }
                }
                
                /**
                 * If the data (event) gets through the filter return it.
                 */
                filter = eventStream.mapSync(function(event) {
                    if(command.filter(event)) return event;
                });
                
                pup.pipe(source,filter)
                pup.pipe(filter, stringifier);
                pup.pipe(stringifier, socket);
                console.log(started)
                started = true;                
            },
            stop: end           
        };
        
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