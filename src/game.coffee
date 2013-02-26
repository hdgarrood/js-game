{World} = require 'world'

exports.Game = class Game
    constructor: (opts) ->
        @world = new World()
        @canvas = opts.canvas

    start: ->
        setInterval(@world.step, @world.stepTime)
