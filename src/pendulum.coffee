this.Pendulum = 
class Pendulum
    constructor: (@length, @pivot, @radius = 5) ->
        @angle = Math.PI / 3

    position: =>
        new Point(
            @pivot.x + (@length * Math.sin(@angle)),
            @pivot.y + (@length * Math.cos(@angle))
        )

    # hit the pendulum rightwards with impulse @impulse pixelsec
    strike: (@impulse) =>
        console.log('Pendulum#strike: Not implemented')

    # draws the pendulum on the passed Canvas.
    draw: (canvas) =>
        # draw the bob
        pos = this.position()
        canvas.drawCircle(pos, @radius)

        # draw the string
        canvas.drawLine(pos, @pivot)
