this.Rect =
class Rect
    x: 0
    y: 0
    w: 0
    h: 0

    collidedWith: (other) ->
        this.x < (other.x + other.w) &&
            (this.x + this.w) > other.x &&
            this.y < (other.y + other.h) &&
            (this.y + this.h) > other.y
