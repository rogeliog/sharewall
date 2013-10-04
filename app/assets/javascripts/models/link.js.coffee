class Wall.Models.Link extends Backbone.Model

  addClick: ->
    url = "/links/#{@id}/add_click"
    $.post url, (j) =>
      @set('click_count', parseInt(@get('click_count')) + 1)
  
  weekly: ->
    @_daysAgo(7+1).getTime() < new Date(@get('created_at')).getTime()

  monthly: ->
    @_daysAgo(30+1).getTime() < new Date(@get('created_at')).getTime()

  isOwnedByCurrentUser: ->
    current_user.get('id') == @get('user').id

  _daysAgo: (days) ->
    date = new Date()
    date.setDate(date.getDate() - days)
    date
