#= require spec_helper

describe 'Wall.Views.Link', ->
  beforeEach ->
    @spies = []
    @model = new Wall.Models.Link(url: "someUrl")
    @view = new Wall.Views.Link(model: @model)
    sinon.stub(@model, 'save').returns(true)

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
    describe 'handleClick', ->
      it 'updates the click_count', ->
        addClickSpy = sinon.spy(@model, 'addClick')
        @view.handleClick()
        sinon.assert.calledOnce addClickSpy
        addClickSpy.restore

    describe 'goToUrl', ->
      xit 'Sets window location to move to another page', ->

    describe 'editLinkWithFocusout', ->
      it 'calls edit link method when focousout has been triggered', ->
        spy = sinon.spy(@view,  '_editLink')
        @view.editLinkWithFocusout()
        sinon.assert.calledOnce spy
        spy.restore

    describe 'editLinkWithKeyboardEvent', ->
      beforeEach ->
        @spy = sinon.spy(@view, '_editLink')

      it 'calls edit link method when the keycode corresponds to the ENTER key', ->
        @view.editLinkWithKeyboardEvent({keyCode: 13})
        sinon.assert.calledOnce @spy

      it 'doesnt edit link when the keycode is different to the ENTER key', ->
        @view.editLinkWithKeyboardEvent({keyCode: 65})
        @spy.callCount.should.equal(0)

      afterEach ->
        @spy.restore

    describe 'handleEditingLink', ->
      it 'toggles the visibility for the input field in the form', ->
        spy = sinon.spy(@view, '_toggleInputVisibility')
        @view.handleEditingLink()
        sinon.assert.calledOnce spy
        spy.restore

