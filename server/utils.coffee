crypto = require 'crypto'
Configuration = require 'config'

Utilities = class Utils
    getConfigData: (request) ->
      templateData = {}
      templateData.public_config = {}

      signed_request = @parseSignedRequest(request, Configuration.appSecret) if signed_request and Configuration.appSecret
      if signed_request
        templateData.public_config.user =
          liked: signed_request.page?.liked
          userID: signed_request.user_id
          locale: signed_request.locale
          country: signed_request.country
          accessToken: signed_request.oauth_token

      templateData.app_config = Configuration
      templateData.public_config.appconfig = Configuration.public_config
      templateData

    parseSignedRequest: (request, secret) ->    
      # Decode SignedRequest
      [encodedSignature, encoded] = request.split '.'
      signature = @base64decode encodedSignature
      decoded = @base64decode encoded
      data = JSON.parse decoded

      # verify
      return false unless data.algorithm == 'HMAC-SHA256'
      hmac = crypto.createHmac 'SHA256', secret
      hmac.update encoded

      # base64url encoding; can't use method as data from hmac is binary
      result = hmac.digest('base64')
        .replace(/\//g, '_')
        .replace(/\+/g, '-')
        .replace(/\=/g, '')

      return data if (result == encodedSignature) else console.log 'encodedSignature error'

    base64decode: (data) ->
      while data.length % 4 != 0
        data += '='
      data = data.replace(/-/g, '+').replace(/_/g, '/')
      new Buffer(data, 'base64').toString('utf-8')

module.exports = new Utilities