this.Canvas = 
class Canvas
    constructor: (@canvas) ->

    width: -> @canvas.width
    height: -> @canvas.height
    _context: -> @canvas.getContext("2d")

    drawCircle: (centre, radius, fillStyle = 'black') ->
        con = this._context()
        con.beginPath()
        con.arc(centre.x, centre.y, radius, 0, 2*Math.PI, false)
        con.fillStyle = fillStyle
        con.fill()

    drawLine: (point1, point2) ->
        con = this._context()
        con.beginPath()
        con.moveTo(point1.x, point1.y)
        con.lineTo(point2.x, point2.y)
        con.stroke()

    clear: (preserveTransform = false) ->
        con = this._context()
        con.save() if preserveTransform
        con.setTransform(1, 0, 0, 1, 0, 0)
        con.clearRect(0, 0, this.width(), this.height())
        con.restore() if preserveTransform
