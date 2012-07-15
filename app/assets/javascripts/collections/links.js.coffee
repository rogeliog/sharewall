class Wall.Collections.Links extends Backbone.Collection

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

  createWith: (attrs) ->
    @create attrs,
      wait: true
      success: ->
        $("#loading").remove()
        $('#new_link_url').val('') 
      error: ->
        $("#loading").remove()


