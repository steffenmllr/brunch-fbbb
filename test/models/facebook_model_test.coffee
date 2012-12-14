FacebookModel = require 'models/facebook_model'
config = require 'config'
describe 'Facebook User Model', ->

    before ->
        sinon.stub window.FB.Events, 'subscribe'

    beforeEach ->    
        # Mock Facebook                         
        @model = new FacebookModel()

    describe 'Constructor Function', =>
        it "should create a model", ->
            expect( @model ).to.be.ok
        
        it "should have set defaults for liked, accessToken and userID", ->
            expect(@model.get 'liked').to.be.false
            expect(@model.get 'accessToken').to.not.be.undefined
            expect(@model.get 'userID').to.not.be.undefined

        it "should set the model data from the config", ->
            config.user =
                testvalue: 'test'
                liked: true

            @model = new FacebookModel()
            expect(@model.get 'liked').to.equal true
            expect(@model.get 'testvalue').to.equal 'test'

    describe 'Model Login Function', =>
        before ->
            @fbLogin = sinon.stub window.FB, 'login'

        it "should be a function", ->
            expect( @model.login ).to.be.a 'function'

        it "should have a callback function", ->
            callback = sinon.spy()
            @model.login(callback)
            @fbLogin.should.have.been.calledWith(callback)

        it "should be callback with a scope", ->
            config.scope = ['email','publish_stream']
            callback = sinon.spy()
            @model.login(callback)
            @fbLogin.should.have.been.calledWith(callback, scope : 'email,publish_stream')

    describe 'Model sync Function', =>
        before ->
            @fbApi = sinon.stub window.FB, 'api'

        it "should throw an Error unless method is 'read'", ->
            expect(@model.fetch()).to.not.throw(Error)
#            expect(@model.sync('create')).to.throw(Error)
            #expect(fn).to.throw(Error)

        it "should call the Facebook API with /me", ->
            callback = sinon.spy()
            @model.fetch()
            @fbApi.should.have.been.calledWith('/me')            




