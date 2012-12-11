FacebookModel = require 'models/facebook_model'
config = require 'config'
describe 'Facebook User Model', ->

    before ->
        sinon.stub window.FB.Events, 'subscribe'

    beforeEach ->    
        # Mock Facebook                         
        @model = new FacebookModel()        

    it "should exist", ->
        expect( @model ).to.be.ok


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