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

    describe 'createLink', ->
      beforeEach ->
        @linksCollection = new Wall.Collections.Links()
        @createSpy = sinon.spy(@linksCollection, 'create')
        @view.collection = @linksCollection

      it 'creates a model on the collection', ->
        @view.createLink()
        expect(@view.collection.create).toHaveBeenCalled()

    describe 'sortByPopularity', ->
      beforeEach ->
        @linksCollection = new Wall.Collections.Links()
        @popularSpy = sinon.spy(@linksCollection, 'sortByPopularity')
        @view.collection = @linksCollection

      it 'Sorts the collection by popularity', ->
        @view.sortByPopularity()
        expect(@view.collection.sortByPopularity).toHaveBeenCalled()

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

    describe 'When selecting the popular order', ->
      beforeEach ->
        @spies.push sinon.spy(Wall.Views.LinksIndex.prototype, 'sortByPopularity')
        @view = new Wall.Views.LinksIndex(collection: @collection)
        setFixtures("<div id='container'></div>")
        $('#container').append(@view.render().el)

      it 'Calls the sortByPopularity', ->
        $("#container #popular_trigger").trigger('click')
        expect(@view.sortByPopularity).toHaveBeenCalled()
        


