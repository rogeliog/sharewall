describe 'Links View', ->
  beforeEach ->
    @spies = []
    @link1 = new Backbone.Model()
    @link2 = new Backbone.Model()
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
        expect(@view.render()).toEqual(@view)

      it 'create a link view for every link', ->
        expect(@linkViewStub).toHaveBeenCalledTwice()

  describe 'Events', ->

    describe 'When submiting the new link form', ->
      beforeEach ->
        @spies.push sinon.spy(Wall.Views.LinksIndex.prototype, 'createLink')
        @view = new Wall.Views.LinksIndex(collection: @collection)
        setFixtures("<div id='container'></div>")
        $('#container').append(@view.render().el)

      it 'Calls the createLink', ->
        $("#new_link").trigger('submit')
        expect(@view.createLink).toHaveBeenCalled()

