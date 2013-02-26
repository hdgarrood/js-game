stitch  = require "stitch"
express = require "express"
fs      = require "fs-extra"

app = stitch.createPackage(
    paths: [ "src" ]
    # dependencies: [ 'lib/box2d.js' ]
)

option '-p', '--port [PORT]', 'port to serve HTTP on'

task "server", "start a dev server", (options) ->
    server = express()
    server.configure ->
        server.get "/application.js", app.createServer()
        server.use express.static(__dirname + '/public')
    port = options.port or process.env.port or 3000
    console.log "starting server on http://0.0.0.0:#{port}"
    server.listen port

task "static", "create a static site", ->
    invoke 'clean'

    fs.mkdirSync 'static'

    # copy files in 'public' to 'static'
    for file in fs.readdirSync 'public'
        fs.copy("public/#{file}", "static/#{file}")

    # compile JS
    app.compile (err, source) ->
        throw err if err
        fs.writeFileSync('static/application.js', source)

task "clean", "clean the static site", ->
    fs.removeSync 'static'
