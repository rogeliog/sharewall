class Wall.Models.Link extends Backbone.Model

  addClick: ->
    url = "/links/#{@id}/add_click"
    $.post url, (j) =>

  goToUrl: ->
    window.location = @get('url')
