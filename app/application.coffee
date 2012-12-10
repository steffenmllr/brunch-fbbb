# Base Application
module.exports =
    Views: {}
    Collections: {}
    Models: {}
    Router: {}    
    initialize: ->
        # Bootstrap Facebook User and Router
        @FacebookUser = new FacebookUser = require 'models/facebook_model'
        @Router = new AppRouter = require 'routers/app_router'        

        @Views.AppView = new AppView = require 'views/app_view'                
        Backbone.history.start() if Object.keys(@Router).length

        Object.freeze? this
        @