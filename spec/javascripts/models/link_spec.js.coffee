describe 'Link', ->
  beforeEach ->
    @link = new Wall.Models.Link(url: 'http://github.com')

  describe 'Methods', ->
    describe '#addClick', ->
      beforeEach ->
        @postSpy = sinon.spy($, 'post')
      afterEach ->
        @postSpy.restore()

      it 'Posts to the backend api', ->
        @link.addClick()
        expect($.post).toHaveBeenCalled()

      it 'When successfull it updates the updated link', ->
        expect("PENDING").toEqual(true)
        

      it 'When there is an error, it receives the apropiate response', ->
        expect("PENDING").toEqual(true)
      
    describe '#weekly', ->
      beforeEach -> @date = new Date()
      it 'True when it was created within the last 7 days', ->
        @date.setDate(@date.getDate() - 7)
        @link.set('created_at', @date.getTime())
        expect(@link.weekly()).toEqual(true)

      it 'False when it was not created within the last 7 days', ->
        @date.setDate(@date.getDate() - 8)
        @link.set('created_at', @date.getTime())
        expect(@link.weekly()).toEqual(false)


    describe '#monthly', ->
      beforeEach -> @date = new Date()
      it 'True when it was created within the last 7 days', ->
        @date.setDate(@date.getDate() - 30)
        @link.set('created_at', @date.getTime())
        expect(@link.monthly()).toEqual(true)

      it 'False when it was not created within the last 7 days', ->
        @date.setDate(@date.getDate() - 31)
        @link.set('created_at', @date.getTime())
        expect(@link.monthly()).toEqual(false)


