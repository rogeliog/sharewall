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
    @collection.create attributes,
      wait: true
      success: ->
       $('#new_link_url').val('') 

  sortByPopularity: (event) ->
    event.preventDefault() if event
    @collection.sortByPopularity()

  sortByRecent: (event) ->
    event.preventDefault() if event
    @collection.sortByRecent()



