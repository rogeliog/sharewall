window.Wall =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}

  init: ->
    new Wall.Routers.Links()
    Backbone.history.start()

$(document).ready ->
  Wall.init()
