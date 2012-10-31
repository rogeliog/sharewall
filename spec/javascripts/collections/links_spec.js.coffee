describe 'Links collection', ->
  beforeEach ->
    @link1 = new Backbone.Model()
    @link2 = new Backbone.Model()
    @linkOld = new Backbone.Model()
    @collection = new Wall.Collections.Links([@link1, @link2])
  
  it 'Has the correct url', ->
    expect(@collection.url).toEqual('/links')

  describe 'Methods', ->
    describe 'weekly', ->
