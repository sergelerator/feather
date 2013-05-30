events        = require("events")
url           = require("url")

module.exports = new events.EventEmitter()

module.exports.DEFAULT_CONTROLLER = "home"
module.exports.DEFAULT_ACTION     = "index"

module.exports.route = ((request, response) ->
  @pathname   = url.parse(request.url).pathname

  @request    = request
  @response   = response

  @selectController()
).bind(module.exports)


module.exports.selectController = ->
  controllerName  = @splitPath()[0] || @DEFAULT_CONTROLLER
  actionName      = @splitPath()[1] || @DEFAULT_ACTION

  console.log("Received request for ##{controllerName}/#{actionName}")

  if (activeControllerClass = @getController(controllerName))
    @activeController  = new activeControllerClass(@request, @response)

    if @activeController[actionName]
      @activeController.handleAction(actionName)
    else
      console.log("  The '#{actionName}' action is missing!")
      @notFound()


module.exports.getController = (controllerName) ->
  try
    c = require("./controllers/#{controllerName}")[controllerName]
  catch ex
    console.log ex
    console.log "The '#{controllerName}' controller is missing!"
  c


module.exports.notFound = (controllerName, actionName) ->
  @emit("not.found")
  @response.writeHead(404, {"Content-Type": "text/plain"})
  @response.write("Error 404 - The page you were looking for does not exist!")
  @response.end()


module.exports.splitPath = () ->
  @__splitPath || @pathname.split("/").filter((str) -> str.length > 0)
