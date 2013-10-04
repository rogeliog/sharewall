#= require spec_helper

describe 'Wall.Models.Link', ->
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
        sinon.assert.calledOnce(@postSpy)

      it 'When successfull it updates the updated link'
      it 'When there is an error, it receives the apropiate response'
      
    describe '#weekly', ->
      beforeEach -> @date = new Date()
      it 'True when it was created within the last 7 days', ->
        @date.setDate(@date.getDate() - 7)
        @link.set('created_at', @date.getTime())
        @link.weekly().should.equal true

      it 'False when it was not created within the last 7 days', ->
        @date.setDate(@date.getDate() - 8)
        @link.set('created_at', @date.getTime())
        @link.weekly().should.equal false


    describe '#monthly', ->
      beforeEach -> @date = new Date()
      it 'True when it was created within the last 7 days', ->
        @date.setDate(@date.getDate() - 30)
        @link.set('created_at', @date.getTime())
        @link.monthly().should.equal true

      it 'False when it was not created within the last 7 days', ->
        @date.setDate(@date.getDate() - 31)
        @link.set('created_at', @date.getTime())
        @link.monthly().should.equal false

    describe '#isOwnedByCurrentUser', ->
      beforeEach ->
        @current_user = new Wall.Models.User({id: 1, name: 'Charlie Slim'})
        window.current_user = @current_user
      it 'True when the link was created by the current user', ->
        @link.set('user', @current_user)
        @link.isOwnedByCurrentUser().should.equal true

      it 'False when it was not created by the current user', ->
        @link.set('user', new Wall.Models.User({id: 999, name: 'Mr. T'}))
        @link.isOwnedByCurrentUser().should.equal(false)



