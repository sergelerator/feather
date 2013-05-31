fs = require("fs")

class module.exports.Base

  constructor: (request, response) ->
    @request        = request
    @response       = response
    @__beforeAction ||= []
    @__afterAction  ||= []

  handleAction: (@actionName) ->
    if (@[@actionName])
      @executeCallbacksCollection("__beforeAction")
      @[@actionName]()
      @executeCallbacksCollection("__afterAction")
      @render(@actionName)

  executeCallbacksCollection: (collection) ->
    @[collection].forEach((filter) ->
      if (typeof(filter) is "function")
        filter()
      else
        console.log("Callbacks must be functions!")
    )

  render: ->
    @response.writeHead(200, {"Content-Type": "text/html"})
    @response.write(@getContent())
    @response.end()

  getContent: ->
    try
      fs.readFileSync("./views/#{@constructor.name}/#{@actionName}.html", "utf-8")
    catch ex
      ex.stack

  @beforeAction: (cb) ->
    (@::__beforeAction ||= []).push cb

  @afterAction: (cb) ->
    (@::__afterAction ||= []).push cb
