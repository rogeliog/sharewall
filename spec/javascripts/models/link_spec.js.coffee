describe 'Link', ->
  beforeEach ->
    @link = new Wall.Models.Link(url: 'http://github.com')

  describe 'Methods', ->
    describe '.addClick', ->
      beforeEach ->
        @postSpy = sinon.spy($, 'post')
      afterEach ->
        @postSpy.restore()

      it 'Posts to the backend api', ->
        @link.addClick()
        expect($.post).toHaveBeenCalled()

      it 'When successfull it updates the updated link'
        

      it 'When there is an error, it receives the apropiate response'

