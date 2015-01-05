express = require "express"
path = require "path"
favicon = require "static-favicon"
cookieParser = require "cookie-parser"
bodyParser = require "body-parser"
config = require "./config/config.json"


log4js = require "log4js"
log4js.configure appenders:[type:"console"],replaceConsole:true
logger = log4js.getLogger "normal"

index = require "./routes/index"
app = express()

app.set "views",path.join __dirname,"views"
app.set "view engine","ejs"

app.use favicon()
app.use bodyParser.json()
app.use bodyParser.urlencoded()
app.use cookieParser()
app.use express.static path.join __dirname,"public"
app.use log4js.connectLogger logger,level:log4js.levels.INFO
app.use (req,res,next) ->
  res.set "X-Powered-By","Server"
  next()

app.use "/",index

app.use (req,res,next) ->
  res.status(404).end()

if (app.get "env") is "development"
  app.use (err,req,res,next) ->
    console.log err
    res.status(err.status or 500).end()

app.use (err,req,res,next) ->
  console.log err
  res.status(err.status or 500).end()

app.set "port",process.env.PORT or 3000

server = app.listen (app.get "port"),() ->
  console.log "Express server listening on port #{server.address().port}"

module.exports = app