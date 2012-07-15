class Wall.Views.LinksIndex extends Backbone.View

  template: JST['links/index']
  events: 
    'submit #new_link':'createLink'
    'click #popular_trigger':'sortByPopularity'
    'click #recent_trigger':'sortByRecent'
 
  initialize: ->
    @collection.on('reset', @render, this)
    @collection.on('add', @prependLink, this)
    $('#order_selector').button()

  render: ->
    $(@el).html(@template())
    @collection.each(@prependLink)
    this
  
  prependLink: (link) =>
    view = new Wall.Views.Link(model: link)
    @$('#links').prepend(view.render().el)
  
  createLink: (event) ->
    event.preventDefault() if event
    attributes = url: $('#new_link_url' ).val()
    $("#links").prepend("<li id='loading'><a>Loading...</a></li>")
    @collection.createWith attributes

  sortByPopularity: (event) ->
    event.preventDefault() if event
    @collection.sortByPopularity()

  sortByRecent: (event) ->
    event.preventDefault() if event
    @collection.sortByRecent()



