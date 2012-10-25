class Wall.Routers.Links extends Backbone.Router
  routes: 
    '':'index'

  initialize: ->
    @collection = new Wall.Collections.Links()
    @collection.reset($('#bootstrap-links').data('links'))
    

  index: ->
    view = new Wall.Views.Main(collection: @collection)
    $('#container').html(view.render().el)

