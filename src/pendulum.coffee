this.Pendulum = 
class Pendulum
    constructor: (@length, @pivot, @radius = 5) ->
        @angle = Math.PI / 3
        @velocity = 0
        @mass = 1
        # acceleration due to gravity, pixels/step^2
        @g = 1

    position: ->
        new Point(
            @pivot.x + (@length * Math.cos(@angle)),
            @pivot.y + (@length * Math.sin(@angle))
        )

    # hit the pendulum rightwards with the given impulse pixelsteps
    strike: (impulse) ->
        console.log('Pendulum#strike: Not implemented')

    # draws the pendulum on the passed Canvas.
    draw: (canvas) ->
        # draw the bob
        pos = this.position()
        canvas.drawCircle(pos, @radius)

        # draw the string
        canvas.drawLine(pos, @pivot)

    step: ->
        accel = @mass * @g * (Math.cos(@angle))
        @velocity += accel
        @angle += @velocity
