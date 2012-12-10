View = require '../lib/view'
Config = require 'config'
Application = require 'application'
FanGate = require './fangate_view'
Template = require '../templates/main'

module.exports = class AppView extends View
    el: '#appView'
    template: Template
    initialize: ->
        # Process Fangate, if User did not like the Page        
        if Application.FacebookUser.get 'liked' then @render() else new FanGate (el : @$el)

