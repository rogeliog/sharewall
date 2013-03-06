class Wall.Routers.Links extends Backbone.Router
  routes: 
    '':'index'
    '?:success': 'index'
    'users/:username': 'user'

  initialize: ->
    @collection = new Wall.Collections.Links()
    @collection.reset($('#bootstrap-links').data('links'))
    
  index: (success) ->
    view = new Wall.Views.Main(collection: @collection)
    view.options.success = true if success?
    $('#container').html(view.render().el)

  user: (username) ->
    view = new Wall.Views.UsersForm(model: current_user)
    $('#container').html(view.render().el)