this.Pendulum = 
class Pendulum
    constructor: (@length, @pivot, @radius = 5) ->
        @body = new Body()
        @angle = Math.PI / 2
        @mass = 0.1
        @gravity = 0.1

        # gravity
        @body.exert ->
            new Force(@mass * @gravity, Math.PI)

        # tension
        @body.exert ->
            new CentripetalForce(@body, @pivot)

    position: ->
        @body.position()

    # draws the pendulum on the passed Canvas.
    draw: (canvas) ->
        # draw the bob
        pos = this.position()
        canvas.drawCircle(pos, @radius)

        # draw the string
        canvas.drawLine(pos, @pivot)

    step: ->
        @body.step()
