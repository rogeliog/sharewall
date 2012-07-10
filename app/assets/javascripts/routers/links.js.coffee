class Wall.Routers.Links extends Backbone.Router
  routes: 
    '':'index'

  initialize: ->
    @collection = new Wall.Collections.Links()
    @collection.fetch()

  index: ->
    view = new Wall.Views.LinksIndex(collection: @collection)
    $('#wrapper').html(view.render().el)

