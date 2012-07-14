describe 'Link View', ->
  beforeEach ->
    @spies = []
    @model = new Backbone.Model(url: "someUrl")
    @view = new Wall.Views.Link(model: @model)

  afterEach ->
    spy.restore for spy in @spies

  describe 'Init', ->
    it 'has a li as a tag name', ->
      expect(@view.el.nodeName).toEqual('LI')

    it 'has a link class', ->
      expect($(@view.el).hasClass('link')).toEqual(true)

  describe 'Events', ->
    describe '#click', ->
      beforeEach ->
        @view = new Wall.Views.Link()
        sinon.spy(@view, 'handleClick')
        @view.trigger("click")

      xit 'handles the click', ->
        expect(@view.handleClick).toHaveBeenCalledOnce()

  describe 'Methods', ->
    describe 'handelClick', ->
      beforeEach ->
        @linkModel = new Wall.Models.Link()
        @addClickSpy = sinon.spy(@linkModel, 'addClick')
        @goToUrlSpy = sinon.stub(@linkModel, 'goToUrl')
        @view.model = @linkModel

      it 'updates the click_count', ->
        @view.handleClick()
        expect(@view.model.addClick).toHaveBeenCalledOnce()

      it 'Navigates to the desired url', ->
        @view.handleClick()
        expect(@view.model.goToUrl).toHaveBeenCalled()
