window.Wall =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}

  init: ->
    new Wall.Routers.Links()
    Backbone.history.start()

  currentUser: ->
    if current_user_id? and current_user_id != ''
      {name: window.current_user_name, id: window.current_user_id}

$(document).ready ->
  Wall.init()
