this.Vector =
class Vector
    constructor: (@x, @y) ->

    add: (other) ->
        new Vector(
            this.x() + other.x(),
            this.y() + other.y()
        )
