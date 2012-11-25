#= require spec_helper

describe 'Wall.Views.Link', ->
  beforeEach ->
    @spies = []
    @model = new Backbone.Model(url: "someUrl")
    @view = new Wall.Views.Link(model: @model)

  afterEach ->
    spy.restore for spy in @spies

  describe 'Init', ->
    it 'has a li as a tag name', ->
      @view.el.nodeName.should.equal('LI')

    it 'has a link class', ->
      $(@view.el).hasClass('link').should.equal(true)

  describe 'Events', ->
    describe '#click', ->
      beforeEach ->
        @view = new Wall.Views.Link()
        @clickSpy = sinon.spy(@view, 'handleClick')
        @view.trigger("click")

      it 'handles the click'

  describe 'Methods', ->
    describe 'handelClick', ->
      beforeEach ->
        @linkModel = new Wall.Models.Link()
        @addClickSpy = sinon.spy(@linkModel, 'addClick')
        @goToUrlSpy = sinon.stub(@linkModel, 'goToUrl')
        @view.model = @linkModel

      it 'updates the click_count', ->
        @view.handleClick()
        sinon.assert.calledOnce @addClickSpy

      it 'Navigates to the desired url', ->
        @view.handleClick()
        sinon.assert.calledOnce @goToUrlSpy
