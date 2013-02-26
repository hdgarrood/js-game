# a wrapper around Box2D's b2World

exports.World = class World
    constructor: ->
        gravity = new Box2D.b2Vec2(0, 10)
        doSleep = false
        @_world = new Box2D.b2World(gravity, doSleep)

    positionIterations: 8
    velocityIterations: 10

    # aim for 60 fps
    timeStep: 1 / 60

    step: ->
        @_world.Step(this.timeStep,
            this.velocityIterations,
            this.positionIterations)
        @_world.ClearForces()
