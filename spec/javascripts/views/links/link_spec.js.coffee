describe 'Link View', ->
  beforeEach ->
    @link = new Backbone.Model(url: "someUrl")
    @view = new Wall.Views.Link(model: @link)

  it 'has a li as a tag name', ->
    expect(@view.el.nodeName).toEqual('LI')

  it 'has a link class', ->
    expect($(@view.el).hasClass('link')).toEqual(true)
