{World} = require 'world'

exports.Game = class Game
    constructor: (opts) ->
        @world = new World()
        @canvas = opts.canvas

    start: ->
        mainLoop = ->
            @world.step() 
        setInterval(mainLoop, @world.stepTime)
