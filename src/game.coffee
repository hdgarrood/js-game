window = this

this.Game =
class Game
    constructor: ->
        @p = new Pendulum(250, new Vector(320, 0))
        @p.velocity = 0.05
        @c = new Canvas(window.document.getElementById('canvas'))
        this.enter_main_loop()

    frames_per_sec = 60
    step_time: 1000 / frames_per_sec

    enter_main_loop: =>
        setTimeout(this.enter_main_loop, this.step_time)
        @c.clear()
        @p.draw(@c)
        @p.step()
