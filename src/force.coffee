this.Force =
class Force
    constructor: (@magnitude, @direction) ->

    # returns a vector representing the force
    toVector: ->
        new Vector(
            @magnitude * Math.cos(@direction),
            @magnitude * Math.sin(@direction)
        )

    # return a new Force as the sum of this one and the argument
    add: (other) ->
        (f.toVector() for f in [this, other]).reduce (acc, x) -> acc.add(x)
