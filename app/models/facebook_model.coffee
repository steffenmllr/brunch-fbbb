config = require 'config'
module.exports = class FacebookUser extends Backbone.Model
    initialize: ->
        _.bindAll @, 'onLoginStatusChange'
        FB.Event.subscribe 'auth.authResponseChange', @onLoginStatusChange

        # Set User if there is a config
        @set config.user, silent: true if config.user

    isConnected: ->
        @get 'userID'

    onLoginStatusChange: (response) ->        
        if response.authResponse
            @set 
                accessToken : response.authResponse.accessToken
                userID : response.authResponse.userID            

        # Trigger Event
        @trigger(response.status, @, response)

    login: (callback = ->) ->
        FB.login callback,
            scope: config.scope?.join ","

    sync: (method, model, options) ->
        throw new Error 'FacebookUser is a readonly model, cannot perform ' + method unless method is 'read'
        FB.api '/me', (resp) =>
          if resp.error then options.error(resp) else options.success(resp)
          return true

    defaults:
        liked: false
        accessToken: null
        userID: null
        country: null
        locale: null
