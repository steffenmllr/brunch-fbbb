FacebookModel = require 'models/facebook_model'

describe 'Facebook User Model', ->
    beforeEach ->
        @model = new FacebookModel()

    it "should exist", ->
        expect( @model ).to.be.ok()