class Wall.Views.Main extends Backbone.View

  template: JST['links/main']

  events: 
    'submit #new_link':'createLink'
    'click #popular_trigger':'sortByPopularity'
    'click #recent_trigger':'sortByRecent'
 
  render: ->
    $(@el).html(@template())
    @renderLinks()
    this
  
  renderLinks: ->
    view = new Wall.Views.LinksIndex collection: @collection
    $(@el).find('#links-wrapper').html(view.render().el)

  createLink: (event) ->
    event.preventDefault() if event
    attributes = url: $('#new_link_url' ).val()
    $("#links").prepend("<li id='loading'><a>Loading...</a></li>")
    @collection.createWith attributes


  sortByPopularity: (event) =>
    event.preventDefault() if event
    $(@el).find('.sorter').removeClass('active')
    $(@el).find('#popular_trigger').addClass('active')
    @collection.sortByPopularity()

  sortByRecent: (event) =>
    event.preventDefault() if event
    $(@el).find('.sorter').removeClass('active')
    $(@el).find('#recent_trigger').addClass('active')
    @collection.sortByRecent()



