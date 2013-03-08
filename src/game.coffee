{Canvas} = require 'canvas'

exports.Game = class Game
    PLAYER = 1
    GROUND = 2

    constructor: (opts) ->
        @canvas = new Canvas(opts.canvas)

        # create world
        gravity = new Box2D.b2Vec2(0, 10)
        @world = new Box2D.b2World(gravity)

        # create the ground and give it an edge
        bd_ground = new Box2D.b2BodyDef
        bd_ground.set_type(Box2D.b2_staticBody)
        ground = @world.CreateBody(bd_ground)

        ground_shape = new Box2D.b2EdgeShape
        ground_shape.Set(new Box2D.b2Vec2(0, 20), new Box2D.b2Vec2(64, 48))
        ground.CreateFixture(ground_shape, 0.0)

        ground.SetUserData(GROUND)

        # create the player (for now, just a box)
        player_shape = new Box2D.b2PolygonShape
        player_shape.SetAsBox(1, 1)

        ZERO = new Box2D.b2Vec2(0, 0)

        bd_player = new Box2D.b2BodyDef
        bd_player.set_type(Box2D.b2_dynamicBody)
        bd_player.set_position(ZERO)

        # add the player to the world
        player = @world.CreateBody(bd_player)
        player.CreateFixture(player_shape, 5)
        player.SetTransform(new Box2D.b2Vec2(25, 4), 0)
        player.SetLinearVelocity(ZERO)
        player.SetAwake(1)
        player.SetActive(1)

        # identifies this object as the player
        player.SetUserData(PLAYER)

        @steps = 0
        @start = =>
            setInterval(@step, 16)
            # window.requestAnimationFrame(@start)

        @step = =>
            @steps += 1
            @update()
            @draw()

    positionIterations: 2
    velocityIterations: 3

    # Box2D works best when moving objects are between 0.1 and 10m large, so we
    # need to scale before rendering
    # this scale means the viewport is 64m wide and 48m high
    pixelsPerMetre: 10

    update: ->
        @world.Step(@stepTime, @velocityIterations, @positionIterations)
        @world.ClearForces()

    draw: ->
        @canvas.clear()
        b = @world.GetBodyList()
        while data = b.GetUserData()
            if data == PLAYER
                position =
                    x: b.GetPosition().get_x() * @pixelsPerMetre
                    y: b.GetPosition().get_y() * @pixelsPerMetre
                draw_radius = 10
                @canvas.drawCircle(position, draw_radius)
            else if data == GROUND
                @canvas.drawLine({x: 0, y: 200}, {x:640, y:480})
            b = b.GetNext()
