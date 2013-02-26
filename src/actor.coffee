# Any game object. Has a sprite (for rendering), and a body
# (handled by box2d) for physics

exports.Actor = class Actor
    constructor: (opts) ->
        @sprite = opts.sprite
        @body = opts.body

    position: ->
        @body.GetPosition()

    angle: ->
        @body.GetAngle()
