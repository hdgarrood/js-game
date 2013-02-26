window = this

{World} = require 'world'

exports.Game = class Game
    constructor: (opts) ->
        @world = new World()
        @p = new Pendulum(250, new Vector(320, 0))
        @p.velocity = 0.05
        @canvas = opts.canvas

    start: ->
        mainLoop = ->
            @world.step() 
        setInterval(mainLoop, @world.stepTime)
