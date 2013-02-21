this.Body =
class Body
    constructor: ->
        @forces = []

    resultant_force: ->
        @forces.reduce (acc, f) ->
           acc.add(f) 

