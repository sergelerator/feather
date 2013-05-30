http    = require("http")
router  = require("./router")


module.exports =
  config:
    port: 8888

  notFound: (response) ->
    response.writeHead(404, {"Content-Type": "text/plain"})
    response.write("404 - Not found")
    response.end()

  start: () ->
    if (!@__serverInstance)
      @__serverInstance = http.createServer(router.route)
      @__serverInstance.listen(@config.port)
      console.log("Server started listening on port " + @config.port)
    else
      console.log("You tried to start the server, but it's already running!")
