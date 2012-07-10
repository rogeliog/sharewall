class Wall.Views.LinksIndex extends Backbone.View

  template: JST['links/index']
  events: 
    'submit #new_link':'createLink'
  
  initialize: ->
    @collection.on('reset', @render, this)
    @collection.on('add', @prependLink, this)

  render: ->
    $(@el).html(@template())
    @collection.each(@prependLink)
    this
  
  prependLink: (link) =>
    view = new Wall.Views.Link(model: link)
    @$('#links').prepend(view.render().el)

  
  createLink: (event)->
    event.preventDefault()
    attributes = url: $('#new_link_url' ).val()
    @collection.create attributes,
      wait: true
      success: ->
       $('#new_link_url').val('') 



