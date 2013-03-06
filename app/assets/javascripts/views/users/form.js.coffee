class Wall.Views.UsersForm extends Backbone.View
  template: JST['users/form']
  
  events: 
    'submit form': 'handleSubmit'
    'click .close': 'hideAlert'

  render: ->
    $(@el).html(@template(@helpers()))
    this

  hideAlert: ->
    $(@el).find('.alert').hide()

  handleSubmit: (e) ->
    e.preventDefault();
    attributes = $(@el).find('form').serializeForm().user
    attributes.preferences ?= {}
    @model.save(attributes, {patch: true, wait: true, success: @sucessEdit, error: @errorEdit})

  sucessEdit: =>
    app.navigate('/?success', {trigger: true})

  errorEdit: (model, xhr, options) =>
    $(@el).find('.alert-error').show()

  helpers: ->
    checkedPreference: (preferenceName) =>
      return "checked='checked'" if @model.get('preferences').newsletter
      return ""