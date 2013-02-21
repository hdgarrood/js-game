window = this

this.Game =
class Game
    constructor: ->
        @p = new Pendulum(100, new Point(100, 100))
        @c = new Canvas(window.document.getElementById('canvas'))
        this.enter_main_loop()

    # ms per step
    step_time: 10

    enter_main_loop: =>
        @p.draw(@c)
        @p.step()
        @c.clear()
        setTimeout(this.enter_main_loop, this.step_time)
