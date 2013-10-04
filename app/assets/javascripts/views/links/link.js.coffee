class Wall.Views.Link extends Backbone.View
  template: JST['links/link']
  
  tagName: 'li'
  className: 'link'

  events:
    "click a": "handleClick"
    "click .icon-pencil": "handleEditingLink"
    "focusout .js-link-title-input": "editLinkWithFocusout"
    "keyup .js-link-title-input": "editLinkWithKeyboardEvent"

  initialize: ->
    @model.on('change:click_count', @goToUrl)

  render: ->
    $(@el).html(@template(link: @model, h: @helpers()))
    @$('img').tooltip()
    this

  handleClick: (e) ->
    e.preventDefault() if e?
    @model.addClick()

  handleEditingLink: (e) ->
    @_toggleInputVisibility()

  editLinkWithFocusout: (e) ->
    @_editLink()

  editLinkWithKeyboardEvent: (e) ->
    @_editLink() if e.keyCode == 13 #13 is the ENTER keycode

  goToUrl: (e) =>
    window.location = @model.get('url')

  _editLink: () =>
    attributes = title: $('.js-link-title-input').val()
    @model.save(attributes, {patch: true, wait: true, success: @_successEdit, error: @_errorEdit})

  _successEdit: () =>
    @render()

  _errorEdit: (model, xhr, options) =>
    @_toggleInputVisibility()

  _toggleInputVisibility: () ->
    $(@el).find('.js-link-title-value').toggleClass('hide')
    $(@el).find('.js-link-title-input').toggleClass('hide').focus()

  helpers: ->
    user: =>
      @model.get('user')
