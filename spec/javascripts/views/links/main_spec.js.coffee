describe 'Innsights.Views.Main', ->
  beforeEach ->
    @spies = []
    @link1 = new Backbone.Model()
    @link2 = new Backbone.Model()
    @collection = new Wall.Collections.Links([@link1, @link2])
    @view = new Wall.Views.Main(collection: @collection)
  afterEach ->
    spy.restore for spy in @spies

  describe 'methods', ->
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

