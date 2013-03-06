class Wall.Views.Link extends Backbone.View
  template: JST['links/link']
  
  tagName: 'li'
  className: 'link'

  events:
    "click a": "handleClick"

  initialize: ->
    @model.on('change:click_count', @goToUrl)

  render: ->
    $(@el).html(@template(link: @model, h: @helpers()))
    @$('img').tooltip()
    this

  handleClick: (e) ->
    e.preventDefault()
    @model.addClick()

  goToUrl: (e) =>
    window.location = @model.get('url')

  helpers: ->
    user: =>
      @model.get('user')
