var http    = require("http");
var router  = require("./router");


module.exports = {
  config: {
    port: 8888
  },

  notFound: function(response){
    response.writeHead(404, {"Content-Type": "text/plain"});
    response.write("404 - Not found");
    response.end();
  },

  start: function() {
    if (!this.__serverInstance){
      this.__serverInstance = http.createServer(router.route);
      this.__serverInstance.listen(this.config.port);
      console.log("Server started listening on port " + this.config.port);
    }
    else {
      console.log("You tried to start the server, but it's already running!");
    }
  },
};
