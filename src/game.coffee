{Canvas} = require 'canvas'

exports.Game = class Game
    PLAYER = 1
    PLAYER_RADIUS = 0.25
    GROUND = 2

    # Box2D works best when moving objects are between 0.1 and 10m large, so we
    # need to scale before rendering
    PIXELS_PER_METRE = 32

    WORLD_HEIGHT_PX = 480
    WORLD_WIDTH_PX = 640

    WORLD_HEIGHT_M = WORLD_HEIGHT_PX / PIXELS_PER_METRE
    WORLD_WIDTH_M = WORLD_WIDTH_PX / PIXELS_PER_METRE

    LINE_TOP_LEFT = new Box2D.b2Vec2(0, WORLD_HEIGHT_M/3)
    LINE_BOTTOM_RIGHT = new Box2D.b2Vec2(WORLD_WIDTH_M, WORLD_HEIGHT_M)

    # acceleration due to gravity, ms^-2
    G = 9.81

    constructor: (opts) ->
        @canvas = new Canvas(opts.canvas)

        # create world
        gravity = new Box2D.b2Vec2(0, G)
        @world = new Box2D.b2World(gravity)

        # create the ground and give it an edge
        bd_ground = new Box2D.b2BodyDef
        bd_ground.set_type(Box2D.b2_staticBody)
        ground = @world.CreateBody(bd_ground)

        ground_shape = new Box2D.b2EdgeShape
        ground_shape.Set(LINE_TOP_LEFT, LINE_BOTTOM_RIGHT)
        ground.CreateFixture(ground_shape, 0.0)

        ground.SetUserData(GROUND)

        # create the player (for now, just a box)
        player_shape = new Box2D.b2CircleShape
        player_shape.set_m_radius(PLAYER_RADIUS)

        ZERO = new Box2D.b2Vec2(0, 0)

        bd_player = new Box2D.b2BodyDef
        bd_player.set_type(Box2D.b2_dynamicBody)
        bd_player.set_position(ZERO)

        # add the player to the world
        player = @world.CreateBody(bd_player)
        player.CreateFixture(player_shape, 5)
        player.SetTransform(new Box2D.b2Vec2(1, 1), 0)
        player.SetLinearVelocity(ZERO)
        player.SetAwake(1)
        player.SetActive(1)

        # identifies this object as the player
        player.SetUserData(PLAYER)

        @start = =>
            window.requestAnimationFrame(@start)
            @step()

        @step = =>
            @update()
            @draw()

    stepTime: 1 / 60
    positionIterations: 2
    velocityIterations: 3

    update: ->
        @world.Step(@stepTime, @velocityIterations, @positionIterations)
        @world.ClearForces()

    draw: ->
        @canvas.clear()
        b = @world.GetBodyList()
        while data = b.GetUserData()
            if data == PLAYER
                position =
                    x: b.GetPosition().get_x() * PIXELS_PER_METRE
                    y: b.GetPosition().get_y() * PIXELS_PER_METRE
                draw_radius = PIXELS_PER_METRE * PLAYER_RADIUS
                @canvas.drawCircle(position, draw_radius)

                angle = b.GetAngle()
                point_on_edge =
                    x: position.x + (draw_radius * Math.cos(angle))
                    y: position.y + (draw_radius * Math.sin(angle))
                @canvas.drawLine(position, point_on_edge, 'red')
            else if data == GROUND
                top_left =
                    x: LINE_TOP_LEFT.get_x() * PIXELS_PER_METRE
                    y: LINE_TOP_LEFT.get_y() * PIXELS_PER_METRE
                bottom_right =
                    x: LINE_BOTTOM_RIGHT.get_x() * PIXELS_PER_METRE
                    y: LINE_BOTTOM_RIGHT.get_y() * PIXELS_PER_METRE
                @canvas.drawLine(top_left, bottom_right)
            b = b.GetNext()
