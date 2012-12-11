express = require 'express'
sysPath = require 'path'
hbs = require 'hbs'
Configuration = require 'config'
brunchconfig = require '../config'
utils = require './utils'

# Config Values
VIEWS_PATH = __dirname + '/views'
PUBLIC_PATH = __dirname + '/../public'
PORT = process.env.PORT or brunchconfig.config.server.port or 3000

# App Instance
app = module.exports = express()

app.configure( =>
  app.set 'views', VIEWS_PATH
  app.set 'view engine', 'hbs'
  app.set 'view options', { layout: false }  # Option: pretty: true
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router
  app.use express.static( PUBLIC_PATH )
  hbs.registerHelper "json", (name, context) ->
    JSON.stringify name
)

# Config Stuff
app.configure 'development', ->
  app.use express.errorHandler { dumpExceptions: true, showStack: true }

app.configure 'production', ->
  app.use express.errorHandler()

# Routes
app.all '/channel.html', (req, res) ->
  res.render 'channel', Configuration

app.all '/', (req, res) =>
  # Set Tempalte Data
  
  templateData = utils.getConfigData(req.body['signed_request'])
  templateData.reqpath = req.headers.host + req.path
  res.render 'index', templateData

# Export Start Server
app.startServer = (port, path, callback) ->
  app.listen PORT, ->
    console.log "Express server listening on port %d in %s mode", PORT, app.settings.env

if app.settings.env is "production"
  app.listen PORT, ->
    console.log "Express server listening on port %d in %s mode", PORT, app.settings.env

module.exports = app
