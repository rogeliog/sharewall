class Wall.Collections.Links extends Backbone.Collection

  active_filter: 'weekly'
  url: '/links'
  model: Wall.Models.Link

  sortByPopularity: ->
    @by('click_count')
    @sort()

  sortByRecent: ->
    @by('created_at')
    @sort()

  by: (attr) ->
    @comparator = (link) -> link.get("#{attr}")
  
  updateFilter: (new_filter) ->
    @active_filter = new_filter
    @trigger('change:filter')

  filter: ->
   switch @active_filter
     when 'weekly' then @weekly()
     when 'monthly' then @monthly()
     else @models

  monthly: ->
    models = []
    for model in @models
      models.push model if model.monthly()
    models

  weekly: ->
    models = []
    for model in @models
      models.push model if model.weekly()
    models

  createWith: (attrs) ->
    @create attrs,
      wait: true
      success: ->
        $("#loading").remove()
        $('#new_link_url').val('') 
      error: ->
        $("#loading").remove()


