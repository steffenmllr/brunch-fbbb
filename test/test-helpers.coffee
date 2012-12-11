MockConfig = require './mocks/mock_config'
expect = require 'expect.js'
chai = require 'chai'
sinon = require 'sinon'
sinonChai = require "sinon-chai"
chai.use(sinonChai)

module.exports =
  expect: require('chai').expect
  should: chai.should()
  sinon: sinon  