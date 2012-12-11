FacebookModel = require 'models/facebook_model'

window.FB = 
    api: ->
    Events: 
        subscribe: ->
    login: ->

describe 'Facebook User Model', ->
    
    before ->
        sinon.stub window.FB.Events, 'subscribe'

    beforeEach ->    
        # Mock Facebook                         
        @model = new FacebookModel()        

    it "should exist", ->
        expect( @model ).to.be.ok


    describe 'Facebook Login Method', =>
        before ->
            @fbLogin = sinon.stub window.FB, 'login'            

        it "login should be a function", ->
            expect( @model.login ).to.be.a 'function'

        it "FB login can have a callback function", ->
            callback = sinon.spy()
            @model.login(callback)
            @fbLogin.should.have.been.calledWith(callback)