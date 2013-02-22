this.Body =
class Body
    constructor: ->
        @_forces = []

    x: 0
    y: 0
    xspeed: 0
    yspeed: 0

    position: ->
        new Vector(this.x, this.y)

    # ask that the given function (which should return a Force) be called on
    # every step, and be exerted on this Body.
    exert: (force) ->
        @_forces.append(force)

    forces: ->
        f() for f in @_forces

    resultant_force: ->
        forces.reduce (acc, f) ->
           acc.add(f)

