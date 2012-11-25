#= require spec_helper

describe 'Wall.Views.LinksIndex', ->
  beforeEach ->
    @spies = []
    @link1 = new Wall.Models.Link()
    @link2 = new Wall.Models.Link()
    @collection = new Wall.Collections.Links([@link1, @link2])
    @view = new Wall.Views.LinksIndex(collection: @collection)

  afterEach ->
    spy.restore for spy in @spies

  describe 'Methods', ->
    describe 'Render', ->
      beforeEach ->
        @spies.push sinon.spy(@view, 'render')
        @linkView = new Backbone.View()
        @linkViewStub = sinon.stub(window.Wall.Views, "Link").returns(@linkView)
        @view.render()

      afterEach ->
        window.Wall.Views.Link.restore()

      it 'Returns the view object', ->
        @view.render().should.equal @view

      it 'create a link view for every link'
