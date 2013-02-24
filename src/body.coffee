this.Body =
class Body
    constructor: ->
        @_forces = []

    mass: 1
    x: 0
    y: 0
    xspeed: 0
    yspeed: 0

    position: ->
        new Vector(this.x, this.y)

    # ask that the given function (which should return a Force) be called on
    # every step, and be exerted on this Body.
    exert: (force) ->
        @_forces.push(force)

    forces: ->
        f() for f in @_forces

    resultant_force: ->
        sum = (acc,f) -> acc.add(f())
        @_forces.reduce sum, new Force(0, 0)

    step: ->
        force = this.resultant_force().toVector()
        xspeed += (force.x / this.mass)
        yspeed += (force.y / this.mass)
        x += xspeed
        y += yspeed

