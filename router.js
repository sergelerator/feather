var events        = require("events");
var url           = require("url");
var controllers   = require("./controllers");

module.exports = new events.EventEmitter()

module.exports.DEFAULT_CONTROLLER = "home";
module.exports.DEFAULT_ACTION     = "index";

module.exports.route = function(request, response){
  this.pathname   = url.parse(request.url).pathname;

  this.request    = request;
  this.response   = response;

  this.selectController();
}.bind(module.exports);

module.exports.selectController = function(){
  var controller  = this.splitPath()[0] || this.DEFAULT_CONTROLLER;
  var action      = this.splitPath()[1] || this.DEFAULT_ACTION;

  console.log("Received request for #" + controller + "/" + action);

  if (controllers[controller] && controllers[controller][action]){
    controllers[controller].request   = this.request;
    controllers[controller].response  = this.response;
    controllers[controller][action]()
  } else {
    console.log("  No route matches the request")
    this.emit("not.found");
  }
};

module.exports.splitPath = function(){
  return this.__splitPath ||
    this.pathname.split("/").filter(function(str){return str.length > 0});
};
