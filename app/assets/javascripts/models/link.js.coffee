class Wall.Models.Link extends Backbone.Model

  addClick: ->
    url = "/links/#{@id}/add_click"
    $.post url, (j) =>

  goToUrl: ->
    window.location = @get('url')
  
  weekly: ->
    @_daysAgo(7+1).getTime() < new Date(@get('created_at')).getTime()

  monthly: ->
    @_daysAgo(30+1).getTime() < new Date(@get('created_at')).getTime()

  _daysAgo: (days) ->
    date = new Date()
    date.setDate(date.getDate() - days)
    date
