class Wall.Views.LinksIndex extends Backbone.View

  className: 'nav nav-tabs nav-stacked'
  tagName: 'ul'
  id: 'links'

  initialize: ->
    @collection.on('reset', @render, this)
    @collection.on('add', @prependLink, this)
    $('#order_selector').button()

  render: ->
    $(@el).html("")
    @collection.each(@prependLink)
    this
  
  prependLink: (link) =>
    view = new Wall.Views.Link(model: link)
    $(@el).prepend(view.render().el)
  
