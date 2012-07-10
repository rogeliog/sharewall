class Wall.Views.Link extends Backbone.View
  template: JST['links/link']

  tagName: 'li'
  className: 'link'
  

  render: ->
    $(@el).html(@template(link: @model))
    this
