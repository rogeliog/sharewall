class Wall.Views.LinksIndex extends Backbone.View

  className: 'nav nav-tabs nav-stacked'
  tagName: 'ul'
  id: 'links'

  initialize: ->
    @collection.on('reset', @render, this)
    @collection.on('add', @prependLink, this)
    @collection.on('change:filter', @render, this)
    $('#order_selector').button()

  render: ->
    $(@el).html("")
    @prependLink(link) for link in @collection.filter()
    this
  
  prependLink: (link) =>
    view = new Wall.Views.Link(model: link)
    $(@el).prepend(view.render().el)
  
