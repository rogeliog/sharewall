class Wall.Views.Link extends Backbone.View
  template: JST['links/link']
  
  tagName: 'li'
  className: 'link'

  events:
    "click":"handleClick"

  render: ->
    $(@el).html(@template(link: @model))
    this

  handleClick: (event) ->
    event.preventDefault() if event
    @model.addClick()
    @model.goToUrl()
