#= require spec_helper

describe 'Wall.Collections.Links', ->
  beforeEach ->
    @link1 = new Backbone.Model()
    @link2 = new Backbone.Model()
    @linkOld = new Backbone.Model()
    @collection = new Wall.Collections.Links([@link1, @link2])
  
  it 'Has the correct url', ->
    @collection.url.should.equal '/links'

  describe 'Methods', ->
    describe 'weekly', ->
